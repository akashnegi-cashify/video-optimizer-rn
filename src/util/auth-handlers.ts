import type { AuthHandlers } from '@reglobe/admin-ui-components-react';
import DeviceInfo from 'react-native-device-info';

import type { LoginType } from '../components/common/LoginScreen/login-type.config';
import {
  AUTH_TOKEN_KEY,
  LOGIN_TYPE_KEY,
  SharedAppStorage,
} from '../storage/SharedAppStorage';
import { CshSnackbar } from './toast.util';

type CreateAuthHandlersOpts = {
  loginType: LoginType;
  /** Fires after token + loginType are persisted to shared MMKV. */
  onComplete: () => void;
};

/**
 * Builds the `AuthHandlers` blob the npm `LoginScreen` widget needs. Centralised here so
 * every login flow (TRC / QC / Shipex / RMS) wires the same storage, toast, device-id and
 * post-login plumbing. The npm widget then handles the form, API calls, MFA flow, etc.
 *
 * `onLoginSuccess`: persist the auth token + login type into the shared `lego_shared` MMKV
 * (co-owned with Flutter's `AppPreferences.app.getAuthToken()` / `getLoginType()`), then
 * hand off to the screen via `onComplete` (navigate or finish-leaf).
 */
export function createAuthHandlers(opts: CreateAuthHandlersOpts): AuthHandlers {
  return {
    storage: {
      getItem: (k) => SharedAppStorage.getString(k),
      setItem: (k, v) => SharedAppStorage.setString(k, v),
    },
    toast: {
      showError: (m) => CshSnackbar.showError(m),
      showSuccess: (m) => CshSnackbar.showSuccess(m),
    },
    getDeviceId: () => DeviceInfo.getUniqueId(),
    onLoginSuccess: ({ token }) => {
      SharedAppStorage.setString(AUTH_TOKEN_KEY, token);
      SharedAppStorage.setString(LOGIN_TYPE_KEY, opts.loginType);
      opts.onComplete();
    },
  };
}
