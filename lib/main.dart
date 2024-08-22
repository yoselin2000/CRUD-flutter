import 'package:flutter/material.dart';

//import firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:pagina_boton/page/screens/add_data.dart';
import 'package:pagina_boton/page/screens/crud_methods.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demooo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/edit': (context) => const EditData(),
      },
      home: const MyHomePage(title: 'Training App'),
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
  void _navigateToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }
  void _navigateToAddData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToSecondPage,
              child: const Text('Usuarios'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToAddData,
              child: const Text('Crear usuario'),
            ),
          ],
        ),
      ),
    );
  }
}


