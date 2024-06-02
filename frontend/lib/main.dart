import "dart:convert";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:flutter/material.dart";
import "package:frontend/form.dart";
import "package:frontend/functions.dart";
import "package:frontend/task.dart";

void main() {
  AwesomeNotifications().initialize(
    null, // Replace with your app icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );
  AwesomeNotifications().requestPermissionToSendNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ponderada 2",
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPage = 0;
  final singupNameController = TextEditingController();
  final singupPasswordController = TextEditingController();
  final loginNameController = TextEditingController();
  final loginPasswordController = TextEditingController();
  late LoginSingupForm loginForm;
  late LoginSingupForm singupForm;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();

    singupForm = LoginSingupForm(
        buttonCallback: () async {
          var response = await createUser(
              singupNameController.text, singupPasswordController.text);
          var status = json.decode(response.body)['status'];
          if (status == "success creating user ${singupNameController.text})") {
            print("Usuário criado com sucesso");
          } else {
            print("Erro ao criar usuário");
          }
          print(response.body);
        },
        firstController: singupNameController,
        secondController: singupPasswordController,
        title: "Criar usuário",
        firstText: "Nome",
        secondText: "Senha",
        buttonText: "Criar",
        pressedSuccessText: "Usuário criado com sucesso.");
    loginForm = LoginSingupForm(
      buttonCallback: () async {
        var response =
            await login(loginNameController.text, loginPasswordController.text);

        var token = getToken(response);
        saveToken(token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskPage()),
        );
      },
      firstController: loginNameController,
      secondController: loginPasswordController,
      title: "Login",
      firstText: "Nome",
      secondText: "Senha",
      buttonText: "Logar",
      pressedSuccessText: "Login teve sucesso. Redirecionando",
    );
    pages = [
      singupForm,
      loginForm,
    ];
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
          NavigationDestination(icon: Icon(Icons.add), label: "Criar usuário"),
          NavigationDestination(icon: Icon(Icons.account_box), label: "Login"),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      body: pages[currentPage],
    );
  }
}
