import 'package:core_widgets/core_widgets.dart';import 'package:core_widgets/src/theme/pallete.dart';

class ProjectTheme implements AbsProjectTheme {
  final bool isDarkTheme;

  static getTheme(bool isDarkTheme) {
    return ProjectTheme(isDarkTheme);
  }

  ProjectTheme(this.isDarkTheme)
      : themeColor = isDarkTheme
            ? DarkThemeColors(
                primary: getDarkPrimaryColor(),
              )
            : LightThemeColors(
                primary: getLightPrimaryColor(),
              );

  @override
  ThemeColor? themeColor;

  @override
  String? fontFamily;

  @override
  ResponsiveFont? typography = ProjectFonts();
}

class ProjectFonts extends ResponsiveFont {
  // @override
  // TextStyle get headline2 {
  //   return const TextStyle(fontSize: 100, height: 1);
  // }
}
