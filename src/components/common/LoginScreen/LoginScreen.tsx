import { LoginScreen as NpmLoginScreen } from '@reglobe/admin-ui-components-react';
import React, { useEffect, useMemo, useRef } from 'react';
import Toast from 'react-native-toast-message';

import { finishLeaf } from '../../../native/RnLeafModule';
import type { RootScreenProps } from '../../../navigation/types';
import { AUTH_TOKEN_KEY, SharedAppStorage } from '../../../storage/SharedAppStorage';
import { createAuthHandlers } from '../../../util/auth-handlers';
import { cshToastConfig } from '../../../util/toast.util';
import { LOGIN_TYPE_CONFIG } from './login-type.config';

/**
 * Generic RN login screen. Hosts the npm `LoginScreen` widget from
 * `@reglobe/admin-ui-components-react` and drives post-login navigation from
 * `LOGIN_TYPE_CONFIG[route.params.loginType]`:
 *   - `postLoginRoute` set → `navigation.reset(...)` to that stack route
 *   - `postLoginRoute` null → `finishLeaf()` so Flutter resumes and reads the
 *      token via the existing `AppPreferences.app.getAuthToken()` path
 *
 * If a token is already cached in shared MMKV (e.g. from a prior session), the
 * form is skipped and the same post-login dispatch runs on mount.
 */
export function LoginScreen({ navigation, route }: RootScreenProps<'Login'>) {
  const { loginType } = route.params;
  const config = LOGIN_TYPE_CONFIG[loginType];

  if (!config) {
    throw new Error(`Unknown loginType: ${loginType}`);
  }

  const completedRef = useRef(false);

  const dispatchPostLogin = () => {
    if (completedRef.current) {
      return;
    }
    completedRef.current = true;
    if (config.postLoginRoute) {
      navigation.reset({ index: 0, routes: [{ name: config.postLoginRoute }] });
    } else {
      finishLeaf();
    }
  };

  useEffect(() => {
    if (SharedAppStorage.getString(AUTH_TOKEN_KEY)) {
      dispatchPostLogin();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handlers = useMemo(
    () => createAuthHandlers({ loginType, onComplete: dispatchPostLogin }),
    // dispatchPostLogin is stable-ish via completedRef; loginType is the only
    // input that should rebuild the handlers.
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [loginType],
  );

  return (
    <>
      <NpmLoginScreen handlers={handlers} texts={{ welcomeTitle: config.title }} />
      <Toast config={cshToastConfig} />
    </>
  );
}
