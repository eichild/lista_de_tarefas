import 'package:flutter/material.dart';

import 'models/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          primaryColor: Colors.teal[400]),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Lavar as mãos", done: false));
    items.add(Item(title: "Dar banho no cachorro", done: false));
    items.add(Item(title: "Jogar League of Legends", done: true));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controla o texto no input
  var newTaskController = TextEditingController();

  void add() {
    if (newTaskController.text.isEmpty) return;
    setState(() {
      widget.items.add(Item(
        title: newTaskController.text,
        done: false,
      ));
      newTaskController.clear();
    });
  }

  void delete(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskController,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 22),
          decoration: InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, int index) {
            final item = widget.items[index];

            return Dismissible(
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                  });
                },
              ),
              onDismissed: (directional) {
                delete(index);
              },
              key: Key(item.title),
              background: Container(
                color: Colors.red.withOpacity(0.9),
                child: Icon(Icons.delete, size: 27, color: Colors.white),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
