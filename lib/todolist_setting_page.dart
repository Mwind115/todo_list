import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v1/provider.dart';

class TodolistSettingPage extends StatefulWidget {
  const TodolistSettingPage({super.key});

  @override
  State<TodolistSettingPage> createState() => _TodolistSettingPageState();
}

class _TodolistSettingPageState extends State<TodolistSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
            "Setting",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      
      body: Center(
        child: Container(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("Font Size", style: TextStyle(fontSize: 20)),
                ),
              ),

              
              Container(
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Consumer<FontSize>(
                          builder: (context, sizes, child){
                            return Container(
                              child: TextButton(
                                  onPressed: () => sizes.increment(),
                                  child: Text("+", style: TextStyle(fontSize: 20))
                              ),
                            );
                          }
                      ),
                    ),

                    SizedBox(width: 15),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Consumer<FontSize>(
                            builder: (context, sizes, child){
                              return Text(sizes.size.toString(),style: TextStyle(fontSize: 20),);
                            }
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Consumer<FontSize>(
                          builder: (context, sizes, child){
                            return Container(
                              child: TextButton(
                                  onPressed: () => sizes.decrement(),
                                  child: Text("-",style: TextStyle(fontSize: 20))
                              ),
                            );
                          }
                      ),
                    ),

                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
