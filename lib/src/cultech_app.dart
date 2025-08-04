import 'package:cultech_app/core/l10n/app_localizations.dart';
import 'package:cultech_app/core/l10n/localization_cubit.dart';
import 'package:cultech_app/core/theme/app_theme.dart';
import 'package:cultech_app/src/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CultechApp extends StatelessWidget {
  const CultechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalizationCubit(),
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(textTheme: AppTextTheme.textTheme),
          );
        },
      ),
    );
  }
}
