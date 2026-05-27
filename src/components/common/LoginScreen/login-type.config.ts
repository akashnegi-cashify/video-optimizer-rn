export type LoginType = 'TRC' | 'QC' | 'Shipex' | 'RMS';

export interface LoginTypeConfig {
  title: string;
  defaultCompany?: string;
  /**
   * Stack route to navigate to on successful login. `null` means finish the RN
   * leaf so Flutter resumes and reads the token via AppPreferences. Add new
   * route names here as more home screens are migrated to RN.
   */
  postLoginRoute: 'RmsRoot' | null;
}

export const LOGIN_TYPE_CONFIG: Record<LoginType, LoginTypeConfig> = {
  RMS: { title: 'RMS Login', postLoginRoute: 'RmsRoot' },
  TRC: { title: 'TRC Login', postLoginRoute: null },
  QC: { title: 'QC Login', postLoginRoute: null },
  Shipex: { title: 'Shipex Login', postLoginRoute: null },
};
