import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/app.dart';
import 'package:template/providers/observers.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await GetStorage.init();

      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );

      // // Set the background messaging handler early on, as a named top-level function
      // FirebaseMessaging.onBackgroundMessage(
      //   firebaseMessagingBackgroundHandler,
      // );

      // await setupFlutterNotifications();

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          // statusBarColor: AppColor.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      runApp(
        // ProviderScope(
        //   child: MaterialApp.router(
        //     debugShowCheckedModeBanner: false,
        //   ),
        // ),
        ProviderScope(
          observers: [
            Observers(),
          ],
          child: App(),
        ),
      );
    },
    (error, stackTrace) {
      // Handle the error gracefully
      debugPrint('Error: $error');
      // You can log the error or send it to a crash reporting service
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
