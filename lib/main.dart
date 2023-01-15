import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newrelic_mobile/config.dart';
import 'package:newrelic_mobile/newrelic_mobile.dart';

import 'ar_furniture_app.dart';
import 'config/env.dart';

var androidToken = 'AA3bb8de0386fb83f48922280d1376db27b76434c7-NRMA';
var iosToken = '';

var appToken = Platform.isAndroid ? androidToken : iosToken;

Config config = Config(
    accessToken: appToken,

    //Android Specific
    // Optional:Enable or disable collection of event data.
    analyticsEventEnabled: true,

    // Optional:Enable or disable reporting successful HTTP requests to the MobileRequest event type.
    networkErrorRequestEnabled: true,

    // Optional:Enable or disable reporting network and HTTP request errors to the MobileRequestError event type.
    networkRequestEnabled: true,

    // Optional:Enable or disable crash reporting.
    crashReportingEnabled: true,

    // Optional:Enable or disable interaction tracing. Trace instrumentation still occurs, but no traces are harvested. This will disable default and custom interactions.
    interactionTracingEnabled: true,

    // Optional:Enable or disable capture of HTTP response bodies for HTTP error traces, and MobileRequestError events.
    httpResponseBodyCaptureEnabled: true,

    // Optional: Enable or disable agent logging.
    loggingEnabled: true,

    //iOS Specific
    // Optional:Enable/Disable automatic instrumentation of WebViews
    webViewInstrumentation: true,

    //Optional: Enable or Disable Print Statements as Analytics Events
    printStatementAsEventsEnabled: true);

Future<void> main() async {
  try {
    await Env.i.load();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  NewrelicMobile.instance.start(config, () {
    runApp(const ArFurnitureApp());
  });
}
