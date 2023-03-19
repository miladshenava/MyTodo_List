import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:memory_game/ui/taskPage.dart';
import 'package:memory_game/ui/ui_helper/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TaskPage();
          }));
        },
        backgroundColor: kcreem,
        child: const Icon(
          Icons.add,
          color: kblackBlu,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: kcreem,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(80, 90),
              ),
            ),
            width: width,
            height: height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Lets GO ',
                  style: GoogleFonts.ubuntu(fontSize: 35, color: kblackBlu),
                ),
              ],
            ),
          ),
          Container(
            height: height*0.7,
            child: FutureBuilder(
              future: loadeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListViewBuilder();
                } else {
                  return Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Box> loadeData() {
    return Hive.openBox('todo');
  }

  Widget ListViewBuilder() {
    final TodoBox = Hive.box('todo');
    return ValueListenableBuilder(
        valueListenable: TodoBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'NO Iteam',
                  style: TextStyle(fontSize: 30, color: kblackBlu),
                ),
              ),
            );
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: TodoBox.length,
                itemBuilder: (context, index) {
                  final todo Todo = box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: kblackBlu,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(40, 60),
                          ),
                        ),
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  color: kred,
                                    alignment: Alignment.bottomLeft,
                                    onPressed: () {remove(index);},
                                    icon: Icon(Icons.remove_circle_outline)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 120,
                                  width:130,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: Text(
                                      Todo.title,
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 20, color: kwite),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }

  remove(int index) {
    Box box = Hive.box('todo');
    box.deleteAt(index);
    print('remove');
  }
}
