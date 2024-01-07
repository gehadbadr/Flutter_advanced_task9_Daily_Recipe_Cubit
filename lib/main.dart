import 'package:daily_recipe2/cubit/auth_cubit.dart';
import 'package:daily_recipe2/cubit/carsoul_cubit.dart';
import 'package:daily_recipe2/cubit/recipe_cubit.dart';
import 'package:daily_recipe2/screens/homepage.screens.dart';
import 'package:daily_recipe2/screens/intro.screens.dart';
import 'package:daily_recipe2/screens/login_screen.dart';
import 'package:daily_recipe2/screens/signup_screen.dart';
import 'package:daily_recipe2/screens/splash.screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  try {
      var prefrence  = await SharedPreferences.getInstance();
      GetIt.I.registerSingleton<SharedPreferences>(prefrence);
  } catch (e) {
    print(e.toString());
  }
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsoulCubit>(
      create: (context) => CarsoulCubit()),
        BlocProvider<RecipeCubit>(
      create: (context) => RecipeCubit()),
      BlocProvider<AuthCubit>(
      create: (context) => AuthCubit()),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daily Recipe',
          /*    theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),*/
         theme: ThemeData(
          
        fontFamily: 'Hellix',
      
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xfff45b00),
          primary: Color(0xfff45b00),
          secondary: Color(0xfff45b00),
        ),
        useMaterial3: true,
      ),
    
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            'IntroScreen/': (context) => IntroScreen(),
            'LoginScreen/': (context) => LoginScreen(),
            'SignupScreen/': (context) => SignupScreen(),
            'HomepageScreen/': (context) => HomepageScreen(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
