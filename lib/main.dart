import 'package:flutter/material.dart';
import 'constants.dart';
//https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Constants.title,
        theme: ThemeData(primaryColor: Colors.blue[900]),
        home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text('Cancel')),
              new FlatButton(
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: new Text('Mark as Done'))
            ],
          );
        });
  }

  Widget _buildTodoListItems() {
    return new ListView.builder(itemBuilder: (context, idx) {
      if (idx < _todoItems.length) {
        return ListTile(
          title: new Text(_todoItems[idx]),
          leading: new Icon(Icons.access_time),
          onTap: () => _promptRemoveTodoItem(idx),
        );
      }
      ;
    });
  }

  Widget _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text(' Add Task'),
        ),
        body: new TextField(
          autofocus: true,
          onSubmitted: (val) {
            addTodoItem(val);
            Navigator.pop(context);
          },
          decoration: new InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: const EdgeInsets.all(16.0)),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.title),
      ),
      body: _buildTodoListItems(),
      backgroundColor: Colors.blueAccent,
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Todo',
        child: new Icon(Icons.add),
      ),
    );
  }
}
