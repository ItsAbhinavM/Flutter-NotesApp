import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notetwo/pages/editPage.dart';
import 'package:notetwo/pages/pageData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final List<pageData> _pageData = [];
  //for displaying the note
  List<Map<String, dynamic>> _items = [];
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

  /*Future<void> _createNote(Map<String, dynamic> newItem) async {
    await _noteBox.add(newItem);
    _refreshItems();
    print("Amount of data is : ${_noteBox.length}");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) {
            final currenIndex = _items[index];
            return SizedBox(
              height: 150,
              child: Card(
                color: Colors.blue.shade100,
                margin: const EdgeInsets.only(left: 30, right: 5, top: 20),
                elevation: 25,
                child: ListTile(
                  title: Text(currenIndex['name']),
                  subtitle: Text(currenIndex['note']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: null, icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => editPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Side Brain",
        style: TextStyle(
            fontSize: 35,
            color: Colors.blue.shade100,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }
}
