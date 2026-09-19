import 'package:flutter/material.dart';

/// GitHub-inspired theme, covering both light and dark mode.
/// Wire this up in MaterialApp as:
///
/// MaterialApp.router(
///   theme: GithubTheme.light,
///   darkTheme: GithubTheme.dark,
///   themeMode: ThemeMode.system, // <- follows device setting automatically
///   routerConfig: router,
/// )

class ColorsData {
  // ---- Light mode palette ----
  static const lightCanvas = Color(0xFFFFFFFF);
  static const lightCanvasSubtle = Color(0xFFF6F8FA);
  static const lightBorder = Color(0xFFD0D7DE);
  static const lightBorderMuted = Color(0xFFD8DEE4);
  static const lightFgDefault = Color(0xFF1F2328);
  static const lightFgMuted = Color(0xFF656D76);
  static const lightAccent = Color(0xFF0969DA);
  static const lightSuccess = Color(0xFF1A7F37);
  static const lightAttention = Color(0xFF9A6700);
  static const lightDanger = Color(0xFFCF222E);
  static const lightDone = Color(0xFF8250DF);
  static const lightNeutralEmphasis = Color(0xFF6E7781);

  // ---- Dark mode palette  ----
  static const darkCanvas = Color(0xFF0D1117);
  static const darkCanvasSubtle = Color(0xFF161B22);
  static const darkBorder = Color(0xFF30363D);
  static const darkBorderMuted = Color(0xFF21262D);
  static const darkFgDefault = Color(0xFFE6EDF3);
  static const darkFgMuted = Color(0xFF848D97);
  static const darkAccent = Color(0xFF58A6FF);
  static const darkSuccess = Color(0xFF3FB950);
  static const darkAttention = Color(0xFFD29922);
  static const darkDanger = Color(0xFFF85149);
  static const darkDone = Color(0xFFA371F7);
  static const darkNeutralEmphasis = Color(0xFF6E7681);
}

class ThemeInfo {
  ThemeInfo._();

  // =========================================================
  // LIGHT THEME
  // =========================================================
  static ThemeData get light {
    
    final colorScheme = ColorScheme.light(
      primary: ColorsData.lightAccent,
      onPrimary: Colors.white,
      secondary: ColorsData.lightDone,
      onSecondary: Colors.white,
      error: ColorsData.lightDanger,
      onError: Colors.white,
      surface: ColorsData.lightCanvas,
      onSurface: ColorsData.lightFgDefault,
      surfaceContainerHighest: ColorsData.lightCanvasSubtle,
      outline: ColorsData.lightBorder,
      outlineVariant: ColorsData.lightBorderMuted,
      inversePrimary: ColorsData.darkAccent,
      tertiary: ColorsData.lightSuccess,
      onTertiary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorsData.lightCanvas,
      canvasColor: ColorsData.lightCanvas,
      dividerColor: ColorsData.lightBorder,
      splashColor: ColorsData.lightAccent.withValues(alpha: 0.08),
      highlightColor: ColorsData.lightAccent.withValues(alpha: 0.05),
      hoverColor: ColorsData.lightCanvasSubtle,
      focusColor: ColorsData.lightAccent.withValues(alpha: 0.15),
      disabledColor: ColorsData.lightFgMuted.withValues(alpha: 0.5),
      shadowColor: Colors.black.withValues(alpha: 0.1),

      textTheme: _buildTextTheme(ColorsData.lightFgDefault, ColorsData.lightFgMuted),

      appBarTheme: AppBarTheme(
        backgroundColor: ColorsData.lightCanvas,
        foregroundColor: ColorsData.lightFgDefault,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorsData.lightBorder,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: ColorsData.lightFgDefault,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: ColorsData.lightFgDefault),
        actionsIconTheme: const IconThemeData(color: ColorsData.lightFgMuted),
      ),

      cardTheme: CardThemeData(
        color: ColorsData.lightCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: ColorsData.lightBorder),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: ColorsData.lightCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ColorsData.lightBorder),
        ),
        titleTextStyle: const TextStyle(
          color: ColorsData.lightFgDefault,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(
          color: ColorsData.lightFgDefault,
          fontSize: 14,
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsData.lightCanvas,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: ColorsData.lightCanvas,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorsData.lightFgDefault,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actionTextColor: ColorsData.darkAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: ColorsData.lightFgDefault,
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsData.lightCanvas,
        hintStyle: const TextStyle(color: ColorsData.lightFgMuted),
        labelStyle: const TextStyle(color: ColorsData.lightFgMuted),
        errorStyle: const TextStyle(color: ColorsData.lightDanger, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.lightAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.lightDanger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.lightDanger, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: ColorsData.lightBorder.withValues(alpha: 0.5)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsData.lightSuccess,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ColorsData.lightSuccess.withValues(alpha: 0.5),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Colors.transparent),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsData.lightFgDefault,
          backgroundColor: ColorsData.lightCanvasSubtle,
          side: const BorderSide(color: ColorsData.lightBorder),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsData.lightAccent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: ColorsData.lightFgMuted,
          highlightColor: ColorsData.lightCanvasSubtle,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsData.lightAccent,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: ColorsData.lightCanvasSubtle,
        disabledColor: ColorsData.lightCanvasSubtle.withValues(alpha: 0.5),
        selectedColor: ColorsData.lightAccent.withValues(alpha: 0.15),
        secondarySelectedColor: ColorsData.lightAccent.withValues(alpha: 0.15),
        labelStyle: const TextStyle(color: ColorsData.lightFgDefault, fontSize: 12),
        secondaryLabelStyle: const TextStyle(color: ColorsData.lightAccent, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: ColorsData.lightBorder),
        ),
        side: const BorderSide(color: ColorsData.lightBorder),
      ),

      dividerTheme: const DividerThemeData(
        color: ColorsData.lightBorder,
        thickness: 1,
        space: 1,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return ColorsData.lightCanvas;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.lightSuccess;
          return ColorsData.lightNeutralEmphasis.withValues(alpha: 0.4);
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.lightAccent;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: ColorsData.lightBorder, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.lightAccent;
          return ColorsData.lightFgMuted;
        }),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ColorsData.lightAccent,
        linearTrackColor: ColorsData.lightCanvasSubtle,
        circularTrackColor: ColorsData.lightCanvasSubtle,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: ColorsData.lightFgDefault,
        unselectedLabelColor: ColorsData.lightFgMuted,
        indicatorColor: ColorsData.lightAccent,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: ColorsData.lightBorder,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsData.lightCanvas,
        selectedItemColor: ColorsData.lightAccent,
        unselectedItemColor: ColorsData.lightFgMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorsData.lightCanvas,
        indicatorColor: ColorsData.lightAccent.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: ColorsData.lightAccent, fontSize: 12, fontWeight: FontWeight.w600);
          }
          return const TextStyle(color: ColorsData.lightFgMuted, fontSize: 12);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: ColorsData.lightAccent);
          }
          return const IconThemeData(color: ColorsData.lightFgMuted);
        }),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: ColorsData.lightCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: ColorsData.lightFgMuted,
        textColor: ColorsData.lightFgDefault,
        selectedColor: ColorsData.lightAccent,
        selectedTileColor: ColorsData.lightCanvasSubtle,
      ),

      iconTheme: const IconThemeData(color: ColorsData.lightFgMuted, size: 22),
      primaryIconTheme: const IconThemeData(color: ColorsData.lightFgDefault),

      popupMenuTheme: PopupMenuThemeData(
        color: ColorsData.lightCanvas,
        surfaceTintColor: Colors.transparent,
        textStyle: const TextStyle(color: ColorsData.lightFgDefault, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: ColorsData.lightBorder),
        ),
      ),

      badgeTheme: const BadgeThemeData(
        backgroundColor: ColorsData.lightDanger,
        textColor: Colors.white,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(ColorsData.lightNeutralEmphasis.withValues(alpha: 0.4)),
        trackColor: WidgetStateProperty.all(Colors.transparent),
      ),

      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(ColorsData.lightCanvasSubtle),
        dataRowColor: WidgetStateProperty.all(ColorsData.lightCanvas),
        dividerThickness: 1,
        columnSpacing: 24,
      ),
    );
  }

  // =========================================================
  // DARK THEME
  // =========================================================
  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: ColorsData.darkAccent,
      onPrimary: Colors.black,
      secondary: ColorsData.darkDone,
      onSecondary: Colors.black,
      error: ColorsData.darkDanger,
      onError: Colors.black,
      surface: ColorsData.darkCanvas,
      onSurface: ColorsData.darkFgDefault,
      surfaceContainerHighest: ColorsData.darkCanvasSubtle,
      outline: ColorsData.darkBorder,
      outlineVariant: ColorsData.darkBorderMuted,
      inversePrimary: ColorsData.lightAccent,
      tertiary: ColorsData.darkSuccess,
      onTertiary: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorsData.darkCanvas,
      canvasColor: ColorsData.darkCanvas,
      dividerColor: ColorsData.darkBorder,
      splashColor: ColorsData.darkAccent.withValues(alpha: 0.12),
      highlightColor: ColorsData.darkAccent.withValues(alpha: 0.08),
      hoverColor: ColorsData.darkCanvasSubtle,
      focusColor: ColorsData.darkAccent.withValues(alpha: 0.2),
      disabledColor: ColorsData.darkFgMuted.withValues(alpha: 0.5),
      shadowColor: Colors.black.withValues(alpha: 0.5),

      textTheme: _buildTextTheme(ColorsData.darkFgDefault, ColorsData.darkFgMuted),

      appBarTheme: AppBarTheme(
        backgroundColor: ColorsData.darkCanvas,
        foregroundColor: ColorsData.darkFgDefault,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorsData.darkBorder,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: ColorsData.darkFgDefault,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: ColorsData.darkFgDefault),
        actionsIconTheme: const IconThemeData(color: ColorsData.darkFgMuted),
      ),

      cardTheme: CardThemeData(
        color: ColorsData.darkCanvasSubtle,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: ColorsData.darkBorder),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: ColorsData.darkCanvasSubtle,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ColorsData.darkBorder),
        ),
        titleTextStyle: const TextStyle(
          color: ColorsData.darkFgDefault,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(
          color: ColorsData.darkFgDefault,
          fontSize: 14,
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsData.darkCanvasSubtle,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: ColorsData.darkCanvasSubtle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorsData.darkCanvasSubtle,
        contentTextStyle: const TextStyle(color: ColorsData.darkFgDefault, fontSize: 14),
        actionTextColor: ColorsData.darkAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: ColorsData.darkBorder),
        ),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: ColorsData.darkCanvasSubtle,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorsData.darkBorder),
        ),
        textStyle: const TextStyle(color: ColorsData.darkFgDefault, fontSize: 12),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsData.darkCanvas,
        hintStyle: const TextStyle(color: ColorsData.darkFgMuted),
        labelStyle: const TextStyle(color: ColorsData.darkFgMuted),
        errorStyle: const TextStyle(color: ColorsData.darkDanger, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.darkAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.darkDanger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: ColorsData.darkDanger, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: ColorsData.darkBorder.withValues(alpha: 0.5)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsData.darkSuccess,
          foregroundColor: Colors.black,
          disabledBackgroundColor: ColorsData.darkSuccess.withValues(alpha: 0.4),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsData.darkFgDefault,
          backgroundColor: ColorsData.darkCanvasSubtle,
          side: const BorderSide(color: ColorsData.darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsData.darkAccent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: ColorsData.darkFgMuted,
          highlightColor: ColorsData.darkCanvasSubtle,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsData.darkAccent,
        foregroundColor: Colors.black,
        elevation: 2,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: ColorsData.darkCanvasSubtle,
        disabledColor: ColorsData.darkCanvasSubtle.withValues(alpha: 0.5),
        selectedColor: ColorsData.darkAccent.withValues(alpha: 0.2),
        secondarySelectedColor: ColorsData.darkAccent.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: ColorsData.darkFgDefault, fontSize: 12),
        secondaryLabelStyle: const TextStyle(color: ColorsData.darkAccent, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: ColorsData.darkBorder),
        ),
        side: const BorderSide(color: ColorsData.darkBorder),
      ),

      dividerTheme: const DividerThemeData(
        color: ColorsData.darkBorder,
        thickness: 1,
        space: 1,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.black;
          return ColorsData.darkFgMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.darkSuccess;
          return ColorsData.darkNeutralEmphasis.withValues(alpha: 0.4);
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.darkAccent;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.black),
        side: const BorderSide(color: ColorsData.darkBorder, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ColorsData.darkAccent;
          return ColorsData.darkFgMuted;
        }),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ColorsData.darkAccent,
        linearTrackColor: ColorsData.darkCanvasSubtle,
        circularTrackColor: ColorsData.darkCanvasSubtle,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: ColorsData.darkFgDefault,
        unselectedLabelColor: ColorsData.darkFgMuted,
        indicatorColor: ColorsData.darkAccent,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: ColorsData.darkBorder,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsData.darkCanvas,
        selectedItemColor: ColorsData.darkAccent,
        unselectedItemColor: ColorsData.darkFgMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorsData.darkCanvas,
        indicatorColor: ColorsData.darkAccent.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: ColorsData.darkAccent, fontSize: 12, fontWeight: FontWeight.w600);
          }
          return const TextStyle(color: ColorsData.darkFgMuted, fontSize: 12);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: ColorsData.darkAccent);
          }
          return const IconThemeData(color: ColorsData.darkFgMuted);
        }),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: ColorsData.darkCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: ColorsData.darkFgMuted,
        textColor: ColorsData.darkFgDefault,
        selectedColor: ColorsData.darkAccent,
        selectedTileColor: ColorsData.darkCanvasSubtle,
      ),

      iconTheme: const IconThemeData(color: ColorsData.darkFgMuted, size: 22),
      primaryIconTheme: const IconThemeData(color: ColorsData.darkFgDefault),

      popupMenuTheme: PopupMenuThemeData(
        color: ColorsData.darkCanvasSubtle,
        surfaceTintColor: Colors.transparent,
        textStyle: const TextStyle(color: ColorsData.darkFgDefault, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: ColorsData.darkBorder),
        ),
      ),

      badgeTheme: const BadgeThemeData(
        backgroundColor: ColorsData.darkDanger,
        textColor: Colors.black,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(ColorsData.darkNeutralEmphasis.withValues(alpha: 0.4)),
        trackColor: WidgetStateProperty.all(Colors.transparent),
      ),

      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(ColorsData.darkCanvasSubtle),
        dataRowColor: WidgetStateProperty.all(ColorsData.darkCanvas),
        dividerThickness: 1,
        columnSpacing: 24,
      ),
    );
  }

  // Shared text theme builder, parameterized by fg colors so light/dark reuse the same structure.
  static TextTheme _buildTextTheme(Color fgDefault, Color fgMuted) {
    return TextTheme(
      displayLarge: TextStyle(color: fgDefault, fontSize: 57, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(color: fgDefault, fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(color: fgDefault, fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(color: fgDefault, fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(color: fgDefault, fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: fgDefault, fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: fgDefault, fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: fgDefault, fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: fgDefault, fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: fgDefault, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(color: fgDefault, fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: fgMuted, fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(color: fgDefault, fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: fgMuted, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(color: fgMuted, fontSize: 11, fontWeight: FontWeight.w500),
    );
  }
}