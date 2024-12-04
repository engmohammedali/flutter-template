import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/extensions/extensions.dart';
import 'package:template/core/keys/keys.dart';
import 'package:template/core/router/app_router.dart';
import 'package:template/core/themes/app_themes.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/providers/language/language_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final localeNotifier = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldKey,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      locale: localeNotifier.locale,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return MediaQuery(
          // Replace the textScaler with the calculated scale.
          data: context.mediaQuery.copyWith(
            textScaler: context.clampTextScaler,
          ),
          child: child!,
        );
      },
    );
  }
}
