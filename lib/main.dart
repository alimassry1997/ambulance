import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/firebase_options.dart';
import 'package:ambulancecheckup/routes/app_routes.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

FirebaseFirestore? firestore;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('localStorage');

  firestore = FirebaseFirestore.instance;
  // firebaseCrashlytics = FirebaseCrashlytics.instance;
  firestore?.settings = const Settings(persistenceEnabled: false);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(BlocProvider(
    create: (context) => GlobalCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambulance Checkup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainRedColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const SplashScreen(),
    );
  }
}
