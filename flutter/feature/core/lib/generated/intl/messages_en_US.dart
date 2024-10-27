// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Forma"),
        "home_cadence": MessageLookupByLibrary.simpleMessage("Cadence"),
        "home_distance": MessageLookupByLibrary.simpleMessage("Distance"),
        "home_generic_error":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "home_ground_contact_time":
            MessageLookupByLibrary.simpleMessage("Ground contact time"),
        "home_last_measurement":
            MessageLookupByLibrary.simpleMessage("Last measurement"),
        "home_name_error":
            MessageLookupByLibrary.simpleMessage("Please enter your name"),
        "home_pace": MessageLookupByLibrary.simpleMessage("Pace"),
        "home_sensor_disconnected":
            MessageLookupByLibrary.simpleMessage("Sensor is not connected!"),
        "home_session_started":
            MessageLookupByLibrary.simpleMessage("Session started"),
        "home_session_stopped":
            MessageLookupByLibrary.simpleMessage("Session stopped"),
        "home_speed": MessageLookupByLibrary.simpleMessage("Speed"),
        "home_start_session":
            MessageLookupByLibrary.simpleMessage("Start session"),
        "home_stop_session":
            MessageLookupByLibrary.simpleMessage("Stop session"),
        "home_stride_length":
            MessageLookupByLibrary.simpleMessage("Stride length"),
        "home_vertical_oscillation":
            MessageLookupByLibrary.simpleMessage("Vertical oscillation")
      };
}
