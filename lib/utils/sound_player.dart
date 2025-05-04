import "package:audioplayers/audioplayers.dart";

final List<AudioPlayer> audioPlayers = [
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
];

int _index = 0;

void playSound(String soundPath) {
  audioPlayers[_index].play(AssetSource(soundPath), volume: 0.5);

  _index = (_index + 1) % audioPlayers.length;
}

void playCorrect() {
  playSound("audio/correct.mp3");
}

void playIncorrect() {
  playSound("audio/incorrect.mp3");
}
