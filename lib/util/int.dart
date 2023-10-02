// Dart imports:
import 'dart:math';

/// Returns a random integer between min and max.
int getRandomInt(int min, int max) {
  return min + Random().nextInt(max - min + 1);
}
