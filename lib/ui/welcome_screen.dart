import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/repository/login_repository.dart';
import 'package:smart_kitchen/ui/home_screen.dart';
import 'package:smart_kitchen/ui/login_screen.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Splash) {
          return SplashScreen();
        }
        if (state is Authenticated) {
          return HomeScreen(name: state.displayName);
        }
        if (state is Unauthenticated) {
          return LoginScreen(loginRepository: LoginRepository());
        }
        return Scaffold(body: Center(child: Image.asset('assets/back1.jpg')));
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
  List<Slide> slides = [
      Slide(
        title: "Przepisy",
        description: "Trzymaj swoje przepisy w jednym miejscu i przeglądaj w przyjazny sposób",
        backgroundColor: Colors.green,
        pathImage: 'assets/slider1.jpg'
      ), 
      Slide(
        title: "Zakupy",
        description: "Lista zakupów zawsze pod ręką",
        backgroundColor: Colors.red,
        pathImage: 'assets/slider2.jpg'
      ),
      Slide(
        title: "Nie daj się zaskoczyć!",
        description: "Planer pomoże w utrzymaniu wartości odżywczych oraz pomoże w chwilach zawachania",
        colorBegin: Colors.green,
        colorEnd: Colors.deepOrange,
        pathImage: 'assets/slider3.png'
        // backgroundColor: Colors.blue,
      ),
      Slide(
        title: "Zaczynajmy",
        colorBegin: Colors.blue,
        colorEnd: Colors.indigo,
        pathImage: 'assets/slider4.jpg'
      )
  ];
    return IntroSlider(
      slides: slides,
      onDonePress: () => BlocProvider.of<AuthBloc>(context).add(SplashEnded()),
    );
  }
}