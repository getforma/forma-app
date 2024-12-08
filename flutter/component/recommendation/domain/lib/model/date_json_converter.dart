import 'package:json_annotation/json_annotation.dart';

class DateJsonConverter implements JsonConverter<DateTime, String> {
  const DateJsonConverter();

  @override
  DateTime fromJson(String json) {
    final parts = json.split("/");
    if (parts.length != 3) {
      throw Exception("Invalid date format");
    }

    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  @override
  String toJson(DateTime json) => "${json.year}/${json.month}/${json.day}";
}
