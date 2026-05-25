import React, { useMemo } from 'react';
import { Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { finishLeaf } from '../../../native/RnLeafModule';
import {
  AUTH_TOKEN_KEY,
  SharedAppStorage,
  probeSharedStorage,
} from '../../../storage/SharedAppStorage';

type RmsRootScreenProps = {
  params?: Record<string, unknown>;
};

/**
 * Placeholder landing screen for the RN-migrated RMS module.
 *
 * Reads the auth token written by the Flutter side and renders a multi-path/multi-id probe
 * so we can locate where Flutter's MMKV files actually live on this device. Once cross-
 * framework storage is confirmed working, the diagnostic block can be removed.
 */
export function RmsRootScreen(_props: RmsRootScreenProps): React.ReactElement {
  const { authToken, otherKeys, probe } = useMemo(() => {
    const token = SharedAppStorage.getString(AUTH_TOKEN_KEY);
    const keys = SharedAppStorage.getAllKeys().filter((k) => k !== AUTH_TOKEN_KEY);
    return { authToken: token, otherKeys: keys, probe: probeSharedStorage() };
  }, []);

  return (
    <SafeAreaView style={styles.root}>
      <ScrollView contentContainerStyle={styles.body}>
        <Text style={styles.title}>RMS (React Native)</Text>
        <Text style={styles.subtitle}>
          Bridge handshake successful. Screens will land here one by one.
        </Text>

        <View style={styles.box}>
          <Text style={styles.label}>Auth token ({AUTH_TOKEN_KEY})</Text>
          <Text style={styles.value} selectable>
            {authToken ?? '<not set>'}
          </Text>
        </View>

        <View style={styles.box}>
          <Text style={styles.label}>Other keys in primary instance ({otherKeys.length})</Text>
          <Text style={styles.value} selectable>
            {otherKeys.length === 0 ? '<none>' : otherKeys.join(', ')}
          </Text>
        </View>

        <Text style={styles.sectionHeader}>Storage probe</Text>
        {probe.map((p, i) => (
          <View key={`${p.path}|${p.id}|${i}`} style={styles.box}>
            <Text style={styles.label}>
              {i + 1}. id="{p.id}"
            </Text>
            <Text style={styles.pathText} selectable>
              {p.path}
            </Text>
            {p.error ? (
              <Text style={styles.errorText}>error: {p.error}</Text>
            ) : (
              <Text style={styles.value} selectable>
                keys ({p.keys?.length ?? 0}):{' '}
                {p.keys && p.keys.length > 0 ? p.keys.join(', ') : '<empty>'}
              </Text>
            )}
          </View>
        ))}

        <Pressable style={styles.button} onPress={finishLeaf}>
          <Text style={styles.buttonText}>Back to Flutter</Text>
        </Pressable>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#FFFFFF' },
  body: { flexGrow: 1, padding: 24 },
  title: { fontSize: 22, fontWeight: '600', color: '#111111', marginBottom: 8, marginTop: 8 },
  subtitle: { fontSize: 13, color: '#555555', marginBottom: 16 },
  sectionHeader: { fontSize: 14, fontWeight: '600', color: '#333333', marginTop: 16, marginBottom: 8 },
  box: {
    width: '100%',
    backgroundColor: '#F5F7FA',
    borderRadius: 8,
    padding: 12,
    marginBottom: 12,
  },
  label: { fontSize: 12, color: '#888888', marginBottom: 4 },
  pathText: { fontSize: 11, color: '#444444', fontFamily: 'Courier', marginBottom: 4 },
  value: { fontSize: 13, color: '#111111', fontFamily: 'Courier' },
  errorText: { fontSize: 12, color: '#B00020' },
  button: {
    backgroundColor: '#42C8B7',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
    marginTop: 16,
    alignSelf: 'center',
  },
  buttonText: { color: '#FFFFFF', fontSize: 15, fontWeight: '600' },
});
