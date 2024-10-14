import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.insert(0, {'task': task, 'isDone': false});
    });
    _controller.clear();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
      var task = _tasks.removeAt(index);
      if (task['isDone']) {
        _tasks.add(task); // Move to end if completed
      } else {
        _tasks.insert(0, task); // Move to start if unchecked
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Tarefa',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addTask(_controller.text);
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      _tasks[index]['task'],
                      style: TextStyle(
                        decoration: _tasks[index]['isDone']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    value: _tasks[index]['isDone'],
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index);
                    },
                    controlAffinity: ListTileControlAffinity.trailing, // Checkbox on the right
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
