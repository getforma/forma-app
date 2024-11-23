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

  /// `Home`
  String get bottom_navigation_item_home {
    return Intl.message(
      'Home',
      name: 'bottom_navigation_item_home',
      desc: '',
      args: [],
    );
  }

  /// `Plans`
  String get bottom_navigation_item_plans {
    return Intl.message(
      'Plans',
      name: 'bottom_navigation_item_plans',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get bottom_navigation_item_stats {
    return Intl.message(
      'Stats',
      name: 'bottom_navigation_item_stats',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get bottom_navigation_item_profile {
    return Intl.message(
      'Profile',
      name: 'bottom_navigation_item_profile',
      desc: '',
      args: [],
    );
  }

  /// `Every step, perfected`
  String get onboarding_title {
    return Intl.message(
      'Every step, perfected',
      name: 'onboarding_title',
      desc: '',
      args: [],
    );
  }

  /// `Enhance your running form, minimize injury risks, and cut down medical expenses.`
  String get onboarding_description {
    return Intl.message(
      'Enhance your running form, minimize injury risks, and cut down medical expenses.',
      name: 'onboarding_description',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboarding_get_started {
    return Intl.message(
      'Get Started',
      name: 'onboarding_get_started',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Log in`
  String get onboarding_log_in {
    return Intl.message(
      'Already have an account? Log in',
      name: 'onboarding_log_in',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get login_title {
    return Intl.message(
      'Enter your phone number',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get login_submit_button {
    return Intl.message(
      'Submit',
      name: 'login_submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Or log in with`
  String get login_alternative_login {
    return Intl.message(
      'Or log in with',
      name: 'login_alternative_login',
      desc: '',
      args: [],
    );
  }

  /// `Search by country name or dial code`
  String get login_search_hint {
    return Intl.message(
      'Search by country name or dial code',
      name: 'login_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number!`
  String get login_error_invalid_phone_number {
    return Intl.message(
      'Invalid phone number!',
      name: 'login_error_invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Invalid SMS code!`
  String get login_error_invalid_sms_code {
    return Intl.message(
      'Invalid SMS code!',
      name: 'login_error_invalid_sms_code',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get login_error_unknown {
    return Intl.message(
      'Something went wrong!',
      name: 'login_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Start new session`
  String get home_start_session {
    return Intl.message(
      'Start new session',
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

  /// `How do you feel?`
  String get home_button_feeling {
    return Intl.message(
      'How do you feel?',
      name: 'home_button_feeling',
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
  String get home_score_title {
    return Intl.message(
      'Score',
      name: 'home_score_title',
      desc: '',
      args: [],
    );
  }

  /// `Training recommendation`
  String get home_training_recommendation_title {
    return Intl.message(
      'Training recommendation',
      name: 'home_training_recommendation_title',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get home_training_recommendation_today {
    return Intl.message(
      'Today',
      name: 'home_training_recommendation_today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get home_training_recommendation_tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'home_training_recommendation_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Rest`
  String get home_training_recommendation_rest {
    return Intl.message(
      'Rest',
      name: 'home_training_recommendation_rest',
      desc: '',
      args: [],
    );
  }

  /// `Intervals`
  String get home_training_recommendation_intervals {
    return Intl.message(
      'Intervals',
      name: 'home_training_recommendation_intervals',
      desc: '',
      args: [],
    );
  }

  /// `Easy`
  String get home_training_recommendation_easy {
    return Intl.message(
      'Easy',
      name: 'home_training_recommendation_easy',
      desc: '',
      args: [],
    );
  }

  /// `Long`
  String get home_training_recommendation_long {
    return Intl.message(
      'Long',
      name: 'home_training_recommendation_long',
      desc: '',
      args: [],
    );
  }

  /// `Insights`
  String get home_insights_title {
    return Intl.message(
      'Insights',
      name: 'home_insights_title',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Pro`
  String get home_insights_upgrade_pro_title {
    return Intl.message(
      'Upgrade to Pro',
      name: 'home_insights_upgrade_pro_title',
      desc: '',
      args: [],
    );
  }

  /// `Get more insights while you are running`
  String get home_insights_upgrade_pro_description {
    return Intl.message(
      'Get more insights while you are running',
      name: 'home_insights_upgrade_pro_description',
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

  /// `km`
  String get tracking_distance_suffix {
    return Intl.message(
      'km',
      name: 'tracking_distance_suffix',
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

  /// `cm`
  String get tracking_vertical_oscillation_suffix {
    return Intl.message(
      'cm',
      name: 'tracking_vertical_oscillation_suffix',
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

  /// `spm`
  String get tracking_cadence_suffix {
    return Intl.message(
      'spm',
      name: 'tracking_cadence_suffix',
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

  /// `ms`
  String get tracking_ground_contact_time_suffix {
    return Intl.message(
      'ms',
      name: 'tracking_ground_contact_time_suffix',
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

  /// `m`
  String get tracking_stride_length_suffix {
    return Intl.message(
      'm',
      name: 'tracking_stride_length_suffix',
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

  /// `km/h`
  String get tracking_average_speed_suffix {
    return Intl.message(
      'km/h',
      name: 'tracking_average_speed_suffix',
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

  /// `min`
  String get tracking_total_time_suffix {
    return Intl.message(
      'min',
      name: 'tracking_total_time_suffix',
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

  /// `Stop session`
  String get tracking_stop_session {
    return Intl.message(
      'Stop session',
      name: 'tracking_stop_session',
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
