import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { LoginType } from '../components/common/LoginScreen/login-type.config';

export type RootStackParamList = {
  Login: { loginType: LoginType };
  RmsRoot: undefined;
};

export type RootScreenProps<R extends keyof RootStackParamList> =
  NativeStackScreenProps<RootStackParamList, R>;
