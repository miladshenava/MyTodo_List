import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:memory_game/models/todo.dart';
import 'package:memory_game/ui/ui_helper/constant.dart';
import 'package:path_provider/path_provider.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController MyTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcreem,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    label: Center(
                        child: Text(
                      'Title',
                      style: GoogleFonts.ubuntu(
                        fontSize: 17,
                        color: kblackBlu,
                      ),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kgreenBlu),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kgreenBlu)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 20),
              child: TextField(
                  maxLines: 3,
                  controller: description,
                  decoration: InputDecoration(
                    label: Center(
                        child: Text(
                      'description',
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: kblackBlu,
                      ),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kgreenBlu),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kgreenBlu)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: TextField(
                  maxLines: 7,
                  controller: MyTask,
                  decoration: InputDecoration(
                    label: Center(
                        child: Text(
                      'My Task',
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: kblackBlu,
                      ),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: kgreenBlu),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kgreenBlu)),
                  )),
            ),
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                primary: kcreem,
                onPrimary: Colors.white,
              ),
              onPressed: onButtenPres,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 25, color: kblackBlu),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  onButtenPres(){
    String valu = titleController.text;
    print(valu);
    add(title: titleController.text, description: description.text, myTask: MyTask.text);
  }
  add({required String title , required String description, required String myTask}) async{
  var box = await Hive.openBox('todo');
  todo Todo = todo(title: title, description: description, myTask: myTask);
  int result =await box.add(Todo);
  print(result);
  }
}
