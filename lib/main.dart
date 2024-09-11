import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v1/provider.dart';
import 'package:todo_app_v1/todolist_bottom_navigator_bar.dart';
import 'package:todo_app_v1/todolist_home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_v1/todolist_setting_page.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>("todo");
  runApp(const MyApp());
}


@HiveType(typeId: 0)
class Todo extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool isCompleted;

  @HiveField(3)
  late DateTime dateTime;

  Todo({

    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,

  });

}

class TodoAdapter extends TypeAdapter<Todo>{

  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader){
    return Todo(
        title: reader.readString(),
        description: reader.readString(),
        dateTime: DateTime.parse(reader.readString()),
        isCompleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj){
        writer.writeString(obj.title);
        writer.writeString(obj.description);
        writer.writeString(obj.dateTime.toIso8601String());
        writer.writeBool(obj.isCompleted);

  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontSize())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/h' : (context) => const TodolistHomePage(),
          '/s' : (context) => const TodolistSettingPage()
        },
        home: const TodolistBottomNavigatorBar(),
      ),
    );
  }
}