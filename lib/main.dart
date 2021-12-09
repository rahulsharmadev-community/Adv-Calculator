import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.yellow.shade50, Colors.green.shade100],
        tileMode: TileMode.clamp,
        begin: Alignment.topRight,
        end: Alignment.center,
      )),
      child: Column(
        children: [
          AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(
              'Calculator',
              style: TextStyle(color: Colors.green.shade700),
            ),
          ),
          const Expanded(child: CalculatorPage()),
        ],
      ),
    ));
  }
}
