// ignore_for_file: avoid_classes_with_only_static_members

// Project imports:
import 'package:gateway_fence_employee/util/config.dart';
import 'package:logger/logger.dart';

// start the logger
Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: getLogLevelFromString(appVarLogLevel));

/// Returns a [Level] from a string
Level getLogLevelFromString(String loglevel) {
  switch (loglevel) {
    case 'trace':
      return Level.trace;
    case 'debug':
      return Level.debug;
    case 'info':
      return Level.info;
    case 'warning':
      return Level.warning;
    case 'error':
      return Level.error;
    case 'fatal':
      return Level.fatal;
    case 'off':
      return Level.off;
    case 'all':
      return Level.all;
    default:
      return Level.fatal;
  }
}

class AppLogger {
  static dynamic prepareMessage(String message, Map<String, dynamic>? data) {
    if (data != null) {
      data['message'] = message;
      return data;
    } else {
      return message;
    }
  }

  static void trace(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.t(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static void debug(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.d(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static void info(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.i(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static void warn(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.w(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static void error(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.e(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static void fatal(
    String message, {
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.f(
      prepareMessage(message, data),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }
}
