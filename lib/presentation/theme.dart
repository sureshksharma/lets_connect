import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  AppTheme(
      {this.primaryColor = const Color(0xFF356859),
      this.tertiaryColor = const Color(0xFFFF5722),
      this.neutralColor = const Color(0xFFFFFBE6)});

  final Color primaryColor;
  final Color tertiaryColor;
  final Color neutralColor;

  Scheme _scheme() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(tertiaryColor.value).tertiary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    return Scheme(
      primary: primary.get(40),
      onPrimary: primary.get(100),
      primaryContainer: primary.get(90),
      onPrimaryContainer: primary.get(10),
      secondary: base.secondary.get(40),
      onSecondary: base.secondary.get(100),
      secondaryContainer: base.secondary.get(90),
      onSecondaryContainer: base.secondary.get(10),
      tertiary: tertiary.get(40),
      onTertiary: tertiary.get(100),
      tertiaryContainer: tertiary.get(90),
      onTertiaryContainer: tertiary.get(10),
      error: base.error.get(40),
      onError: base.error.get(100),
      errorContainer: base.error.get(90),
      onErrorContainer: base.error.get(10),
      background: neutral.get(99),
      onBackground: neutral.get(10),
      surface: neutral.get(99),
      onSurface: neutral.get(10),
      outline: base.neutralVariant.get(50),
      outlineVariant: base.neutralVariant.get(80),
      surfaceVariant: base.neutralVariant.get(90),
      onSurfaceVariant: base.neutralVariant.get(30),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(20),
      inverseOnSurface: neutral.get(95),
      inversePrimary: primary.get(80),
    );
  }

  ThemeData _base(final ColorScheme colorScheme) {
    final primaryTextTheme = GoogleFonts.workSansTextTheme();
    final secondaryTextTheme = GoogleFonts.robotoTextTheme();
    final textTheme = primaryTextTheme.copyWith(
      displaySmall: secondaryTextTheme.displaySmall,
      displayMedium: secondaryTextTheme.displayMedium,
      displayLarge: secondaryTextTheme.displayLarge,
      headlineSmall: secondaryTextTheme.headlineSmall,
      headlineMedium: secondaryTextTheme.headlineMedium,
      headlineLarge: secondaryTextTheme.headlineLarge,
    );
    final isLight = colorScheme.brightness == Brightness.light;
    return ThemeData(
      useMaterial3: true,
      extensions: [this],
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: isLight ? neutralColor : colorScheme.background,
      textTheme: textTheme,
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorScheme.primary, width: 2.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: isLight ? neutralColor : colorScheme.surface,
        selectedIconTheme: IconThemeData(color: colorScheme.onSecondaryContainer),
        indicatorColor: colorScheme.secondaryContainer
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? neutralColor : colorScheme.surface
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isLight ? neutralColor : colorScheme.surface
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(isLight ? neutralColor : colorScheme.surface),
          textStyle: MaterialStatePropertyAll(textTheme.bodyLarge),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
       style: ButtonStyle(
         iconColor: MaterialStatePropertyAll(isLight ? primaryColor : colorScheme.secondary)
       ),
      )
    );
  }

  ThemeData toThemeData() {
    final colorScheme = _scheme().toColorScheme(Brightness.light);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) => AppTheme(
    primaryColor: primaryColor ?? this.primaryColor,
    tertiaryColor: primaryColor ?? this.tertiaryColor,
    neutralColor: primaryColor ?? this.neutralColor,
  );

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme> other, double t) {
    if(other is! AppTheme) return this;
    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }
}

extension on Scheme {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
        primary: Color(primary),
        onPrimary: Color(onPrimary),
        primaryContainer: Color(primaryContainer),
        onPrimaryContainer: Color(onPrimaryContainer),
        secondary: Color(secondary),
        onSecondary: Color(onSecondary),
        secondaryContainer: Color(secondaryContainer),
        onSecondaryContainer: Color(onSecondaryContainer),
        tertiary: Color(tertiary),
        onTertiary: Color(onTertiary),
        tertiaryContainer: Color(tertiaryContainer),
        onTertiaryContainer: Color(onTertiaryContainer),
        error: Color(error),
        onError: Color(onError),
        errorContainer: Color(errorContainer),
        onErrorContainer: Color(onErrorContainer),
        outline: Color(outline),
        outlineVariant: Color(outlineVariant),
        background: Color(background),
        onBackground: Color(onBackground),
        surface: Color(surface),
        onSurface: Color(onSurface),
        surfaceVariant: Color(surfaceVariant),
        onSurfaceVariant: Color(onSurfaceVariant),
        inverseSurface: Color(inverseSurface),
        onInverseSurface: Color(inverseOnSurface),
        inversePrimary: Color(inversePrimary),
        shadow: Color(shadow),
        scrim: Color(scrim),
        surfaceTint: Color(primary),
        brightness: brightness);
  }
}