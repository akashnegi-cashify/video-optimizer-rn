# Run Project

Execute the commands—don't just describe them.

## "run stage" (no AAR)

```bash
cd android && ./gradlew installStageDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales.stage/in.cashify.supersale.MainActivity
```

## "run beta" (no AAR)

```bash
cd android && ./gradlew installBetaDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales.beta/in.cashify.supersale.MainActivity
```

## "run prod" (no AAR)

```bash
cd android && ./gradlew installProdDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales/in.cashify.supersale.MainActivity
```

## "run stage with aar"

```bash
cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile --dart-define=env=stage
cd android && ./gradlew installStageDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales.stage/in.cashify.supersale.MainActivity
```

## "run beta with aar"

```bash
cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile --dart-define=env=beta
cd android && ./gradlew installBetaDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales.beta/in.cashify.supersale.MainActivity
```

## "run prod with aar"

```bash
cd flutter_module && flutter pub get && flutter build aar --no-debug --no-profile --dart-define=env=prod
cd android && ./gradlew installProdDebug -PreactNativeDevServerPort=8081 && adb shell am start -n in.cashify.supersales/in.cashify.supersale.MainActivity
```

## Notes

- Swap `stage` for the requested flavor/env (`beta`, `prod`, etc.).
- iOS: `npx react-native run-ios` (use `flutter build ios-framework` for AAR equivalent).
- On `INSTALL_FAILED_VERSION_DOWNGRADE`: `adb uninstall in.cashify.supersales.stage` (or `.beta` / no suffix for prod), then retry.
