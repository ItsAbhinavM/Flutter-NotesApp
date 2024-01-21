import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notetwo/pages/pageData.dart';

class editPage extends StatefulWidget {
  const editPage({super.key});

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  int _selectedIndex = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<Map<String, dynamic>> _items = [];

  late List<pageData> _pageData = [
    pageData(
        nameController: _nameController.text,
        noteController: _noteController.text)
  ];

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _noteBox = Hive.box("Note_box");
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() {
    final data = _noteBox.keys.map((key) {
      final item = _noteBox.get(key);
      return {"key": key, "name": item['name'], "note": item['note']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  Future<void> _createNote(Map<String, dynamic> newItem) async {
    await _noteBox.add(newItem);
    _refreshItems();
    print("Amount of data is ${_noteBox.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar(),
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            _createNote(
                {"name": _nameController.text, "note": _noteController.text});
            Navigator.pop(context);
          },
          child: Icon(Icons.add_comment))*/
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    'What are you thinking about?',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
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
                      style: TextStyle(color: Colors.deepPurple, fontSize: 25),
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
                      style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                      controller: _noteController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Enter note",
                          labelText: "Note",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 20,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 96,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 95,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(
                            "   Exit   ",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 95,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text(
                            "Create",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            _createNote({
                              "name": _nameController.text,
                              "note": _noteController.text
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _navigationBottomBar,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.save_as), label: "Save")
          ]),*/
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "Create New",
        style: TextStyle(
            fontSize: 32, color: Colors.white, fontWeight: FontWeight.w800),
      ),
      centerTitle: true,
    );
  }
}
