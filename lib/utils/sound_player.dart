import "package:audioplayers/audioplayers.dart";

final List<AudioPlayer> audioPlayers = [
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
];

int _index = 0;

/// Plays all sounds in the list of audio players with a volume of 0.0.
/// This is used to preload the sounds so that they are ready to play when needed.
void preloadSounds() {
  var paths = ["audio/correct.mp3", "audio/incorrect.mp3"];
  var index = 0;
  for (var player in audioPlayers) {
    player.play(AssetSource(paths[index]), volume: 0.0);

    index = (index + 1) % paths.length;
  }
}

Future<void> playSound(String soundPath) {
  var future = audioPlayers[_index].play(AssetSource(soundPath), volume: 0.5);

  _index = (_index + 1) % audioPlayers.length;

  return future;
}

Future<void> playCorrect() async {
  await playSound("audio/correct.mp3");
}

Future<void> playIncorrect() async {
  await playSound("audio/incorrect.mp3");
}
