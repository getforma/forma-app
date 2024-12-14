import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:text_to_speech_component_data/model/text_to_speech_request.dart';
import 'package:text_to_speech_component_data/text_to_speech_service.dart';

@injectable
class TextToSpeechDataSource {
  final TextToSpeechService _textToSpeechService;

  TextToSpeechDataSource(this._textToSpeechService);

  Future<List<int>> getSpeechFromText(TextToSpeechRequest body) async {
    final response = await _textToSpeechService.getSpeechFromText(body);
    if (response.response.statusCode == HttpStatus.ok) {
      return response.data;
    }
    throw Exception(response.data);
  }
}
