abstract class TextToSpeechRepository {
  Future<List<int>> getSpeechFromText(String text);
}
