import 'package:flutter/material.dart';
import 'package:frontend/functions.dart';

import 'package:frontend/taskform.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {super.key,
      required String title,
      required String content,
      required this.buttonCallback})
      : _title = title,
        _content = content,
        super();

  final String _title;
  final String _content;
  final Function buttonCallback;

  String get title => _title;
  String get content => _content;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late TextEditingController t1;
  late TextEditingController t2;
  @override
  void initState() {
    t1 = TextEditingController(text: widget._title);
    t2 = TextEditingController(text: widget._content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(widget._title),
              subtitle: Text(widget._content),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Delete Task'),
                  onPressed: () async {
                    var response = await deleteTask(
                        widget._title, await getTokenFromStorage());
                    print(response.body);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Task deletada com sucesso.")),
                    );
                    widget.buttonCallback();
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Update Task'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                    body: CreateTaskForm(
                                  buttonCallback: () async {
                                    var response = await updateTask(t1.text,
                                        t2.text, await getTokenFromStorage());
                                    print(response.body);
                                    widget.buttonCallback();
                                    Navigator.pop(context);
                                  },
                                  firstController: t1,
                                  secondController: t2,
                                  title: "Atualizar Task",
                                  firstText: "Titulo",
                                  secondText: "Conteudo",
                                  buttonText: "Atualizar",
                                  pressedSuccessText:
                                      "Task atualizada com sucesso.",
                                ))));
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
