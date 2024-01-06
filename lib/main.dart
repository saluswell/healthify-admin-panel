import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/providers/role_provider.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/providers/loginauthprovider.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/screens/splash_screen.dart';
import 'package:saluwell_admin_panel/src/careGoalPlanSection/providers/care_goal_provider.dart';
import 'package:saluwell_admin_panel/src/dashboardSection/providers/menu_provider.dart';
import 'package:saluwell_admin_panel/src/mealPlansSection/providers/meal_plan_provider.dart';
import 'package:saluwell_admin_panel/src/recipesSection/providers/recipes_provider.dart';
import 'package:saluwell_admin_panel/utils/navigatorHelper.dart';
import 'package:saluwell_admin_panel/utils/themes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => LoginAuthProvider()),
        ChangeNotifierProvider(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (_) => MealPlanProvider()),
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
        ChangeNotifierProvider(create: (_) => CareGoalProvider())
      ],
      child: MaterialApp(
          title: 'SalusWell Admin',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          navigatorKey: navstate,
          home: const SplashScreen()),
    );
  }
}
