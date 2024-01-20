import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notetwo/pages/editPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for displaying the note
  List<Map<String, dynamic>> _items = [];
  final _noteBox = Hive.box("Note_box");

  Future<void> _createNote(Map<String, dynamic> newItem) async {
    await _noteBox.add(newItem);
    print("Amount of data is : ${_noteBox.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "hello",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => editPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
/*showModalBottomSheet(
              elevation: 5,
              isScrollControlled: true,
              context: context,
              builder: (_) => (Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 15,
                        left: 15,
                        right: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        TextField(
                          controller: _namecontroller,
                          decoration: InputDecoration(hintText: 'Enter name'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextField(
                          controller: _notecontroller,
                          decoration: InputDecoration(hintText: 'Enter Note'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _createNote({
                                "name": _namecontroller.text,
                                "note": _notecontroller.text
                              });
                              _namecontroller.text = '';
                              _notecontroller.text = '';

                              Navigator.pop(context);
                            },
                            child: Text("Create note")),
                      ],
                    ),
                  )));*/