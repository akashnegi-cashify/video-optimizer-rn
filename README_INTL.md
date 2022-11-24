# flutter_supersale

### localization
- step1
    pub run intl_translation:extract_to_arb --output-dir=target/directory
          my_program.dart more_of_my_program.dart

    commond: flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/*/* lib/*/*/*

    this command generates intl.messages.arb file.

- step2
     command: sh ./scripts/localize.sh --env=stage --p

     downloads all language .arb files

- step3
    pub run intl_translation:generate_from_arb --generated-file-prefix=<prefix>
        <my_dart_files> <translated_ARB_files>

    command: flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/*/* lib/*/*/* lib/l10n/core/intl_*.arb

    existing issue: (https://github.com/localizely/flutter-intl-vscode/issues/63)

    above command generates messages_all.dart, messages_messages.dart
    and messages_<locale>.dart files like, message_en.dart, message_hi.dart file
