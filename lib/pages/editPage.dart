import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';

class editPage extends StatefulWidget {
  const editPage({super.key});

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final _noteBox = Hive.box("Note_box");

  Future<void> _createNote(Map<String, dynamic> newItem) async {
    await _noteBox.add(newItem);
    print("Amount of data is ${_noteBox.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Note",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    'What are you thinking about?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                /*decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/bg1.jpg"),
                        fit: BoxFit.cover)),*/
                padding: EdgeInsets.only(top: 15, left: 50, right: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: "Enter name",
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 75,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: _noteController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Enter note",
                          labelText: "Note",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // place an image here
                    ElevatedButton(
                      onPressed: () {
                        _createNote({
                          "name": _nameController.text,
                          "note": _noteController.text
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Create note",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
