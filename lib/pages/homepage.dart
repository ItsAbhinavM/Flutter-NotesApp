import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notetwo/pages/createPage.dart';
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

  Future<void> _deleteItem(int itemkey) async {
    await _noteBox.delete(itemkey);
    _refreshItems();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An item has been deleted ")));
  }

  @override
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxisScrolled) => [appBar()],
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final currenIndex = _items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              //editPage(currenIndex['key'])._showForm(context, currenIndex['key'])));
                              createPage(
                                content: context,
                                itemIndex: currenIndex['key'],
                              )));
                },
                child: SizedBox(
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
                              onPressed: () {
                                _deleteItem(currenIndex['key']);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      createPage(content: context, itemIndex: 0)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
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
