// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gateway_fence_employee/main.dart';

enum LogLevel {
  error,
  warn,
  debug,
  info,
}

class Logger {
  /// Write a controlled log output in json format
  static void log({
    required String message,
    LogLevel level = LogLevel.error,
    Map<String, dynamic>? data,
  }) {
    // check the level to determine if the log should be made
    try {
      LogLevel logAt = _getLogLevelFromString(appVarLogLevel);
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
    Map<String, dynamic> output = {
      'level': level.toString().split('.').last,
      'message': message,
    };

    // add data to the output
    if (data != null) {
      output['data'] = {};
      output['data'].addAll(data);
    }

    // add the timestamp to the end of the output 
    output['utc'] = DateTime.now().toUtc().toIso8601String();

    // log the output
    print(jsonEncode(output));
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

  /// Returns the LogLevel enum value from a string or error if the string is not valid
  static LogLevel _getLogLevelFromString(String loglevel) {
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
}
