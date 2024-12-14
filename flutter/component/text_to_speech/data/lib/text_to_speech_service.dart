import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:text_to_speech_component_data/model/text_to_speech_request.dart';

part 'text_to_speech_service.g.dart';

@RestApi()
@lazySingleton
abstract class TextToSpeechService {
  @factoryMethod
  factory TextToSpeechService(Dio dio) => _TextToSpeechService(dio,
      baseUrl: "https://getspeechfromtext-3pukyo7nvq-uc.a.run.app/");

  @POST("")
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<Uint8List>> getSpeechFromText(
      @Body() TextToSpeechRequest body);
}
