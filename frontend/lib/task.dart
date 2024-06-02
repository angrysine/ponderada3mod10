import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/functions.dart';
import 'package:frontend/taskcard.dart';
import 'package:frontend/taskform.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  int currentPage = 0;
  final createTitleController = TextEditingController();
  final createContentController = TextEditingController();
  late Column updateTaskForm;
  late CreateTaskForm createTaskForm;
  final updateTitleController = TextEditingController();
  final updateContentController = TextEditingController();
  List<Widget> pages = []; // Initialize with an empty list
  bool isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      await initializePage();
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> updatePages() async {
    await initializePage();
    setState(() {
      pages = [
        createTaskForm,
        SingleChildScrollView(child: updateTaskForm),
      ];
    });
  }

  Future<void> initializePage() async {
    var response = await getTasks(await getTokenFromStorage());
    print(response.body);
    var tasks = json.decode(response.body)["tasks"];
    List<TaskCard> taskCards = [];

    for (var task in tasks) {
      taskCards.add(
        TaskCard(
          title: task["title"],
          content: task["content"],
          buttonCallback: updatePages,
        ),
      );
    }

    createTaskForm = CreateTaskForm(
      buttonCallback: () async {
        var response = await addTask(createTitleController.text,
            createContentController.text, await getTokenFromStorage());
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task criada com sucesso.")),
        );
        updatePages();
      },
      firstController: createTitleController,
      secondController: createContentController,
      title: "Criar Task",
      firstText: "Titulo",
      secondText: "Conteudo",
      buttonText: "Criar",
      pressedSuccessText: "Task criada com sucesso.",
    );

    updateTaskForm = Column(children: taskCards);
    setState(() {
      pages = [
        createTaskForm,
        SingleChildScrollView(child: updateTaskForm),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ponderada 2"),
        backgroundColor: Colors.lightBlue,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.add), label: "Criar task"),
          NavigationDestination(
              icon: Icon(Icons.account_box), label: "Editar task"),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      body: isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : pages[currentPage],
    );
  }
}
