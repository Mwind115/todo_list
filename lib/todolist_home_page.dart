import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v1/provider.dart';

import 'main.dart';

class TodolistHomePage extends StatefulWidget {
  const TodolistHomePage({super.key});

  @override
  State<TodolistHomePage> createState() => _TodolistHomePageState();
}

class _TodolistHomePageState extends State<TodolistHomePage> {

  late Box<Todo> todoBox;

  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDescription =TextEditingController();
  // Color todoColor = Colors.amberAccent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<Todo>("todo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
            "Note App",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            )
        ),
      ),

      body: ValueListenableBuilder(
          valueListenable: todoBox.listenable(),
          builder: (context, Box<Todo> box, _){
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Todo todo = box.getAt(index)!;
                  return Padding(
                    padding: const EdgeInsets.only(left: 25, top: 20),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: todo.isCompleted ? Colors.greenAccent : Colors.amberAccent,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
                      ),
                      child: Dismissible(
                        key: Key(todo.dateTime.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.only(right: 25),
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction){
                          setState(() {
                            todo.delete();
                          });
                        },
                        child: ListTile(
                          leading: Checkbox(
                              value: todo.isCompleted, 
                              onChanged: (value) {
                                setState(() {
                                  todo.isCompleted = value!;
                                  todo.save();
                                });
                              }
                          ),
                          title: Consumer<FontSize>(
                              builder: (context, sizes, child){
                                return Text(todo.title, style: TextStyle(fontSize: sizes.size, fontWeight: FontWeight.w700));
                              }
                          ),
                          subtitle: Consumer<FontSize>(
                              builder: (context, sizes, child){
                                return Text(todo.description, style: TextStyle(fontSize: sizes.size - 1, fontWeight: FontWeight.w500));
                              }
                          ),
                          trailing: Text(DateFormat.yMMMd().format(todo.dateTime,),style: TextStyle(fontSize: 15),),
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),


      
      floatingActionButton: FloatingActionButton(
          onPressed: () => _todolistShowdialog(context),
          child: Icon(Icons.add),
      ),
      
    );
  }
  Future<void> _todolistShowdialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Create new todo"),
            content: Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: todoTitle,
                        decoration: InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 10),

                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber
                    ),
                    child: Center(
                      child: TextField(
                        maxLength: 200,
                        textAlign: TextAlign.center,
                        controller: todoDescription,
                        decoration: InputDecoration.collapsed(
                          hintText: "Content",
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
            actions: <Widget>[
              
              Container(
                width: MediaQuery.of(context).size.width*0.32,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: () {
                      _addTodo(todoTitle.text, todoDescription.text);
                      Navigator.pop(context);
                      setState(() {
                        todoTitle.text = "";
                        todoDescription.text = "";
                      });
                    },
                    child: Text("Submit", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.32,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text("Cancel", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
              ),

              
            ],
            actionsAlignment: MainAxisAlignment.spaceBetween,
          );
        }
    );
  }
  void _addTodo(String title, String description) {
    if(title.isNotEmpty) {
      todoBox.add(
        Todo(title: title, description: description, dateTime: DateTime.now())
      );
    }
  }
}


