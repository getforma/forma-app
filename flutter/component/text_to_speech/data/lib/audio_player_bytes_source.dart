import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerBytesSource extends StreamAudioSource {
  final List<int> bytes;
  AudioPlayerBytesSource(this.bytes)
      : super(
          tag: MediaItem(
            id: Random().nextDouble().toString(),
            title: 'Forma Coach',
          ),
        );

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
