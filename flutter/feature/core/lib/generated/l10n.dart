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

  /// `Start session`
  String get home_start_session {
    return Intl.message(
      'Start session',
      name: 'home_start_session',
      desc: '',
      args: [],
    );
  }

  /// `Stop session`
  String get home_stop_session {
    return Intl.message(
      'Stop session',
      name: 'home_stop_session',
      desc: '',
      args: [],
    );
  }

  /// `Last measurement`
  String get home_last_measurement {
    return Intl.message(
      'Last measurement',
      name: 'home_last_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Cadence`
  String get home_cadence {
    return Intl.message(
      'Cadence',
      name: 'home_cadence',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get home_distance {
    return Intl.message(
      'Distance',
      name: 'home_distance',
      desc: '',
      args: [],
    );
  }

  /// `Ground contact time`
  String get home_ground_contact_time {
    return Intl.message(
      'Ground contact time',
      name: 'home_ground_contact_time',
      desc: '',
      args: [],
    );
  }

  /// `Pace`
  String get home_pace {
    return Intl.message(
      'Pace',
      name: 'home_pace',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get home_speed {
    return Intl.message(
      'Speed',
      name: 'home_speed',
      desc: '',
      args: [],
    );
  }

  /// `Stride length`
  String get home_stride_length {
    return Intl.message(
      'Stride length',
      name: 'home_stride_length',
      desc: '',
      args: [],
    );
  }

  /// `Vertical oscillation`
  String get home_vertical_oscillation {
    return Intl.message(
      'Vertical oscillation',
      name: 'home_vertical_oscillation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get home_name_error {
    return Intl.message(
      'Please enter your name',
      name: 'home_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Session started`
  String get home_session_started {
    return Intl.message(
      'Session started',
      name: 'home_session_started',
      desc: '',
      args: [],
    );
  }

  /// `Session stopped`
  String get home_session_stopped {
    return Intl.message(
      'Session stopped',
      name: 'home_session_stopped',
      desc: '',
      args: [],
    );
  }

  /// `Sensor is not connected!`
  String get home_sensor_disconnected {
    return Intl.message(
      'Sensor is not connected!',
      name: 'home_sensor_disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Sensor could not be initialized!`
  String get home_sensor_initialization_error {
    return Intl.message(
      'Sensor could not be initialized!',
      name: 'home_sensor_initialization_error',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get home_generic_error {
    return Intl.message(
      'Something went wrong',
      name: 'home_generic_error',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get tracking_score {
    return Intl.message(
      'Score',
      name: 'tracking_score',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get tracking_distance {
    return Intl.message(
      'Distance',
      name: 'tracking_distance',
      desc: '',
      args: [],
    );
  }

  /// `Avg pace`
  String get tracking_average_pace {
    return Intl.message(
      'Avg pace',
      name: 'tracking_average_pace',
      desc: '',
      args: [],
    );
  }

  /// `Vertical oscillation`
  String get tracking_vertical_oscillation {
    return Intl.message(
      'Vertical oscillation',
      name: 'tracking_vertical_oscillation',
      desc: '',
      args: [],
    );
  }

  /// `Cadence`
  String get tracking_cadence {
    return Intl.message(
      'Cadence',
      name: 'tracking_cadence',
      desc: '',
      args: [],
    );
  }

  /// `Ground contact time`
  String get tracking_ground_contact_time {
    return Intl.message(
      'Ground contact time',
      name: 'tracking_ground_contact_time',
      desc: '',
      args: [],
    );
  }

  /// `Stride length`
  String get tracking_stride_length {
    return Intl.message(
      'Stride length',
      name: 'tracking_stride_length',
      desc: '',
      args: [],
    );
  }

  /// `Avg speed`
  String get tracking_average_speed {
    return Intl.message(
      'Avg speed',
      name: 'tracking_average_speed',
      desc: '',
      args: [],
    );
  }

  /// `Total time`
  String get tracking_total_time {
    return Intl.message(
      'Total time',
      name: 'tracking_total_time',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get tracking_tips {
    return Intl.message(
      'Tips',
      name: 'tracking_tips',
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
