import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:letsdo/models/TodoModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:letsdo/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String toboBoxName = 'todo';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<TodoModel> todoBox;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    todoBox = Hive.box(toboBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Let\'s Do',
          style: GoogleFonts.dancingScript(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.green,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('log', false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
            },
            child: Icon(
              Icons.logout,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, Box<TodoModel> todos, _) {
                List<int> keys = todos.keys.cast<int>().toList();
                return ListView.separated(
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final TodoModel todo = todos.get(key);
                    return ListTile(
                      trailing: GestureDetector(
                        onTap: () {
                          TodoModel mTodo = TodoModel(
                              title: todo.title,
                              desc: todo.desc,
                              isCompleted: true);
                          todoBox.put(key, mTodo);
                        },
                        child: Icon(todo.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outlined),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 20.0,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        todo.desc,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Text(
                        '⦿',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                      onLongPress: () {
                        todoBox.delete(key);
                      },
                    );
                  },
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: keys.length,
                  shrinkWrap: true,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                color: Color(0xff757575),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Add Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: 'Title',
                            focusColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          hintText: 'Desc',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            final String title = titleController.text;
                            final String desc = descController.text;

                            TodoModel todo = TodoModel(
                                title: title, desc: desc, isCompleted: false);

                            todoBox.add(todo);

                            Navigator.pop(context);
                            titleController.clear();
                            descController.clear();
                          },
                          child: Container(
                            height: 70,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
