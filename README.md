# flutter_boilerplate

## Features in boiler plate
1. Theming
1. Sentry (Need to check: Tracking HTTP events)
1. Interceptors
1. Localization
1. Environments (Created for Flutter, Android, iOS)
1. Alice
1. Analytics
1. Connectivity
1. Session expire handling
1. Utils
    1. Shared Preference
    1. Image Util
    1. ImageAssetHelper
    1. Api Util
    1. App Util  
    
## arguments
--dart-define=env=stage --web-port=8089 --flavor=stage --no-sound-null-safety
 sentry-cli upload-dif --org cashify --project <project-name> --wait <mapping-files-path>

### localization
- step1
  Update info in scripts/localize.sh according to your project
- step2
  flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/*/*
- step3
  sh ./scripts/localize.sh --env=stage --p
- step4
  flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/*/* lib/l10n/core/intl_*.arb


## upload Debug Symbols files on sentry using sentry-cli
Step1 :
- install sentry-cli > "curl -sL https://sentry.io/get-cli/ | bash"
  Either you can use sentry AUTH_TOKEN to execute sentry-cli commands or you can login to sentry-cli itself.
Step2 :
- upload flutter symbols files:
  sentry-cli --auth-token <YOUR_AUTH_TOKEN> upload-dif --org cashify --project <YOUR_PROJECT_NAME_ON_SENTRY> <PATH_TO_SYMBOL_FILES>
- upload proguard mapping file for android app:
  sentry-cli --auth-token <YOUR_AUTH_TOKEN> upload-dif --org cashify --project <YOUR_PROJECT_NAME_ON_SENTRY> <PATH_TO_PROGUARD_MAPPING_FILES>
- Upload dSYN for ios app:
  sentry-cli --auth-token <YOUR_AUTH_TOKEN> upload-dif --org cashify --project <YOUR_PROJECT_NAME_ON_SENTRY> <PATH_TO_DSYM_FILES>

## Template Features
1. Theming - Done
2. Sentry - Need to Update - SentryNavigatorObserver(), Use init method, Manish needs to update read me
3. Interceptors - Log interceptor: request time issue
4. Localization - add scripts by Manish
5. Environments - Only flutter env support
6. Alice - Log interceptor: request time issue
7. Analytics - Mix panel issue
8. Connectivity - 
9. Session expire handling
10. Shared preference utils
11. Generic Utils - Image Util, ImageAssetHelper
12. ci-cd - Update readme 
13. Widgets - 
14. State Management - 

### Android debug build
- flutter build apk --dart-define=env=stage --debug
- flutter build apk --dart-define=env=stage
- flutter build apk --dart-define=env=stage --flavor stage --obfuscate --split-debug-info=mappings
- flutter build apk --dart-define=env=beta --flavor beta --obfuscate --split-debug-info=mappings
- flutter build apk --dart-define=env=prod --flavor prod --obfuscate --split-debug-info=mappings

### Android Prod Release Build
- flutter build appbundle --dart-define=env=prod --obfuscate --split-debug-info=mappings --flavor prod
- java -jar /Users/msc/Downloads/bundletool-all-1.4.0.jar build-apks --bundle=/Users/msc/Downloads/app-prod-release.aab --output=gt_agent.apks --ks=/Users/msc/Documents/deploy_keys/deploy_keys/deploy_keys_v2.jks --ks-key-alias=reglobe
- java -jar /Users/msc/Downloads/bundletool-all-1.4.0.jar install-apks --apks=/Users/msc/Downloads/gt_agent.apks


- bundletool build-apks --bundle=/Users/msc/Downloads/app-prod-release.aab --output=phoneshop.apks --ks=/Users/ravi/Workspace/Android/deploy_keys/deploy_keys_v2.jks --ks-key-alias=cashify
- bundletool install-apks --apks=/Users/ravi/Workspace/Flutter/flutter_phoneshop/phoneshop.apks --adb=./adb
