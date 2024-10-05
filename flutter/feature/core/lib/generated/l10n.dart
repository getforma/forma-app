// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Forma`
  String get app_name {
    return Intl.message(
      'Forma',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Scores`
  String get home_scores {
    return Intl.message(
      'Scores',
      name: 'home_scores',
      desc: '',
      args: [],
    );
  }

  /// `Last 4 runs`
  String get home_last_runs {
    return Intl.message(
      'Last 4 runs',
      name: 'home_last_runs',
      desc: '',
      args: [],
    );
  }

  /// `%`
  String get home_percent {
    return Intl.message(
      '%',
      name: 'home_percent',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get home_start {
    return Intl.message(
      'Start',
      name: 'home_start',
      desc: '',
      args: [],
    );
  }

  /// `Ready to improve your form?`
  String get home_card_action_description {
    return Intl.message(
      'Ready to improve your form?',
      name: 'home_card_action_description',
      desc: '',
      args: [],
    );
  }

  /// `TRY`
  String get home_try {
    return Intl.message(
      'TRY',
      name: 'home_try',
      desc: '',
      args: [],
    );
  }

  /// `Premium Club`
  String get home_premium_club {
    return Intl.message(
      'Premium Club',
      name: 'home_premium_club',
      desc: '',
      args: [],
    );
  }

  /// `7 DAYS FREE`
  String get home_7_days_free {
    return Intl.message(
      '7 DAYS FREE',
      name: 'home_7_days_free',
      desc: '',
      args: [],
    );
  }

  /// `Form score`
  String get home_form_score {
    return Intl.message(
      'Form score',
      name: 'home_form_score',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
