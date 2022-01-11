import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/models/contact_model.dart';
import 'package:hive_crud/screens/contact_screen.dart';
import "package:path_provider/path_provider.dart" as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: Hive.openBox("contacts", compactionStrategy: (int total, int deleted) {
            return deleted > 20;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return ContactScreen();
            } else
              return Scaffold();
          },
        ));
  }

  @override
  void dispose() {
    Hive.box("contacts").compact();
    Hive.close();
    super.dispose();
  }
}
