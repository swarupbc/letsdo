import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:letsdo/controllers/loginController.dart';
import 'package:letsdo/models/TodoModel.dart';
import 'package:path_provider/path_provider.dart';

const String toboBoxName = 'todo';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final docPath = await getApplicationDocumentsDirectory();
  Hive.init(docPath.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(toboBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Let\'s Do',
      home: LoginController(),
    );
  }
}
