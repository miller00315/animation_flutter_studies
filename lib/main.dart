import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogoApp(title: 'Flutter Demo Home Page'),
    );
  }
}

class LogoApp extends StatefulWidget {
  LogoApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _animationController.reverse();
        else if (status == AnimationStatus.dismissed)
          _animationController.forward();
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTransition(
          animation: _animation,
          child: LogoWidget(),
        ),
      ],
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(),
    );
  }
}

class CustomTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  final Tween<double> sizeTween = Tween<double>(begin: 0, end: 300);
  final Tween<double> opacityTWeen = Tween<double>(begin: 0.1, end: 1);

  CustomTransition({Key key, @required this.child, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Opacity(
          opacity: opacityTWeen.evaluate(animation).clamp(0.0, 1.0),
          child: Container(
            height: sizeTween.evaluate(animation).clamp(0.0, 300.0),
            width: sizeTween.evaluate(animation).clamp(0.0, 300.0),
            child: child,
          ),
        ),
        child: child,
      ),
    );
  }
}
