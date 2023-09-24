// Flutter imports:
import 'package:flutter/material.dart';

class Timer with ChangeNotifier {
  DateTime? _startTime;
  DateTime? _endTime;
  bool _isRunning = false;
  bool _isStarted = false;

  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;
  bool get isRunning => _isRunning;
  bool get isStarted => _isStarted;

  /// Starts the timer.
  void start() {
    _startTime = DateTime.now();
    _isRunning = true;
    _isStarted = true;
    notifyListeners();
  }

  /// Stops the timer.
  void stop() {
    _endTime = DateTime.now();
    _isRunning = false;
    notifyListeners();
  }

  /// Resets the timer.
  void reset() {
    _startTime = null;
    _endTime = null;
    _isRunning = false;
    _isStarted = false;
    notifyListeners();
  }

  /// Returns the duration of the timer in the format HH:MM:SS.
  String getDuration() {
    if (_startTime == null) {
      return '00:00:00';
    }
    if (_endTime == null) {
      final duration = DateTime.now().difference(_startTime!);
      return _formatDuration(duration);
    }
    final duration = _endTime!.difference(_startTime!);
    return _formatDuration(duration);
  }

  /// Returns the start time in the format HH:MM:SS.
  String getStartTime() {
    if (_startTime == null) {
      return '00:00:00';
    }
    final hours = _startTime!.hour.toString().padLeft(2, '0');
    final minutes = _startTime!.minute.toString().padLeft(2, '0');
    final seconds = _startTime!.second.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Returns the end time of the timer in the format HH:MM:SS.
  String getEndTime() {
    if (_endTime == null) {
      return '00:00:00';
    }
    final hours = _endTime!.hour.toString().padLeft(2, '0');
    final minutes = _endTime!.minute.toString().padLeft(2, '0');
    final seconds = _endTime!.second.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  // Helper functions

  /// Formats a [Duration] into a string of the format HH:MM:SS.
  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
