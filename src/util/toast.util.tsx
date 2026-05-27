import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Toast, { type ToastConfig } from 'react-native-toast-message';

/**
 * Snackbar colors matching Flutter's csh_snackbar.dart:
 *   SUCCESS  → primary (#42C8B7), white text
 *   ERROR    → errorColor (#FE6461), white text
 *   WARNING  → pendingColor (#FE9708), black text
 */
const SnackbarColors = {
  success: { background: '#42C8B7', text: '#FFFFFF' },
  error: { background: '#FE6461', text: '#FFFFFF' },
  warning: { background: '#FE9708', text: '#000000' },
} as const;

type SnackbarType = 'csh_success' | 'csh_error' | 'csh_warning';

const SnackbarBase = ({
  text1,
  backgroundColor,
  textColor,
}: {
  text1?: string;
  backgroundColor: string;
  textColor: string;
}) => (
  <View style={[styles.container, { backgroundColor }]}>
    <Text style={[styles.message, { color: textColor }]} numberOfLines={3}>
      {text1}
    </Text>
  </View>
);

/**
 * Custom toast config to be passed to `<Toast config={cshToastConfig} />`.
 * Renders a floating snackbar at the bottom matching Flutter's Flushbar.
 */
export const cshToastConfig: ToastConfig = {
  csh_success: (props) => (
    <SnackbarBase
      text1={props.text1}
      backgroundColor={SnackbarColors.success.background}
      textColor={SnackbarColors.success.text}
    />
  ),
  csh_error: (props) => (
    <SnackbarBase
      text1={props.text1}
      backgroundColor={SnackbarColors.error.background}
      textColor={SnackbarColors.error.text}
    />
  ),
  csh_warning: (props) => (
    <SnackbarBase
      text1={props.text1}
      backgroundColor={SnackbarColors.warning.background}
      textColor={SnackbarColors.warning.text}
    />
  ),
};

function show(type: SnackbarType, message: string, durationSec = 2) {
  Toast.show({
    type,
    text1: message,
    position: 'bottom',
    visibilityTime: durationSec * 1000,
    bottomOffset: 50,
  });
}

/** Common snackbar API — mirrors Flutter showSuccess / showError / showWarning. */
export const CshSnackbar = {
  showSuccess(message: string, durationSec = 2) {
    show('csh_success', message, durationSec);
  },
  showError(message: string, durationSec = 2) {
    show('csh_error', message, durationSec);
  },
  showWarning(message: string, durationSec = 2) {
    show('csh_warning', message, durationSec);
  },
};

const styles = StyleSheet.create({
  container: {
    marginHorizontal: 20,
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 4,
    width: '90%',
  },
  message: {
    fontSize: 14,
    fontWeight: '400',
    lineHeight: 20,
  },
});
