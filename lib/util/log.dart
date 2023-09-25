// ignore_for_file: avoid_print, avoid_classes_with_only_static_members

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:gateway_fence_employee/util/config.dart';

enum LogLevel {
  error,
  warn,
  debug,
  info,
}

/// Returns the LogLevel enum value from a string or error if the string is not valid
LogLevel getLogLevelFromString(String loglevel) {
  switch (loglevel) {
    case 'error':
      return LogLevel.error;
    case 'warn':
      return LogLevel.warn;
    case 'debug':
      return LogLevel.debug;
    case 'info':
      return LogLevel.info;
    default:
      throw Exception('Invalid log level');
  }
}

class Logger {
  static final LogLevel logAt = getLogLevelFromString(appVarLogLevel);

  /// Write a controlled log output in json format
  static void log({
    required String message,
    LogLevel level = LogLevel.error,
    Map<String, dynamic>? data,
  }) {
    // check the level to determine if the log should be made
    try {
      if (level.index > logAt.index) {
        return;
      }
    } catch (e) {
      // print the error only in debug mode
      if (kDebugMode) {
        print('[EXCEPTION] $e');
        print('Invalid log level - using error level');
      }

      // if it was an error then log, if not the discard
      if (level.index > LogLevel.error.index) {
        print('log requested too low of a level (exception) - discarding');
        return;
      }
    }

    // create the general log output
    final Map<String, dynamic> output = <String,dynamic>{
      'level': level.toString().split('.').last,
      'message': message,
    };

    // add data to the output
    if (data != null) {
      output['data'] = <String,dynamic>{};
      output['data'].addAll(data);
    }

    // add the timestamp to the end of the output
    output['utc'] = DateTime.now().toUtc().toIso8601String();

    // log the output
    try {
      print(jsonEncode(output));
    } catch (e) {
      print(
          '[EXCEPTION] LOGGER EXCEPTION | failed to log message, error: ${e.toString()}');
      print('[EXCEPTION] original message: $message');
    }
  }

  /// Write a controlled log output in json format at the error level
  static void error(String message, {Map<String, dynamic>? data}) =>
      log(message: message, level: LogLevel.error, data: data);

  /// Write a controlled log output in json format at the warn level
  static void warn(String message, {Map<String, dynamic>? data}) =>
      log(message: message, level: LogLevel.warn, data: data);

  /// Write a controlled log output in json format at the debug level
  static void debug(String message, {Map<String, dynamic>? data}) =>
      log(message: message, level: LogLevel.debug, data: data);

  /// Write a controlled log output in json format at the info level
  static void info(String message, {Map<String, dynamic>? data}) =>
      log(message: message, level: LogLevel.info, data: data);
}
