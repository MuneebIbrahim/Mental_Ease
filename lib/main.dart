import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mental_ease/user/Providers/Chat_Providers/Chat_Provider.dart';
import 'package:mental_ease/user/Providers/Dashboard_Provider/Dashboard_Provider.dart';
import 'package:mental_ease/user/Providers/Doctors_Provider/DoctorProfileProvider.dart';
import 'package:mental_ease/user/Providers/Profile_Provider/Profile_Provider.dart';
import 'package:provider/provider.dart';

import 'Auth_Provider/SignUp_Provider.dart';
import 'Auth_Provider/login_Provider.dart';
import 'Model_provider.dart';
import 'Notification_Services.dart';
import 'Phycologist/Providers/Phycologist_Profile_Provider/Phycologist_Profile_Provider.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51Pt47MH8RYav7UwyTR7NkDhLimzDlMGEGujKFlhxp0nOm5YfiW4VaSSS0iGKkAX3FZS5iDrwA3wf2u8hBPbYaTGQ00ZLDF4GFq';
}
void main() async {
  await _setup();
  WidgetsFlutterBinding.ensureInitialized();
  // PaymentGateway.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => PsychologistProvider()),
        ChangeNotifierProvider(create: (_) => PsychologistProfileProvider()),
        ChangeNotifierProvider(create: (_) => PsychologistProfileViewProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ModelProvider())


      ],
      child: const MyApp(),
    ),
  );


}

Future<void> _firebaseMessagingBackgroundHandler ( RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: "CustomFont", // Apply font globally
        ),
        debugShowCheckedModeBanner: false,
        home: SplachScreen(),
      ),
    );
  }

}

