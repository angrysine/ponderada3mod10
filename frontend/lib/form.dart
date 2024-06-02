import 'package:flutter/material.dart';

class LoginSingupForm extends StatefulWidget {
  const LoginSingupForm({
    super.key,
    required this.buttonCallback,
    required this.firstController,
    required this.secondController,
    required this.title,
    required this.firstText,
    required this.secondText,
    required this.buttonText,
    required this.pressedSuccessText,
  });

  final Function buttonCallback;
  final TextEditingController firstController;
  final TextEditingController secondController;
  final String firstText;
  final String secondText;
  final String buttonText;
  final String title;
  final String pressedSuccessText;

  @override
  State<LoginSingupForm> createState() => _LoginSingupFormState();
}

class _LoginSingupFormState extends State<LoginSingupForm> {
  final _formKey = GlobalKey<FormState>();
  double formPadding = 16;
  double formPaddingVertical = 16;
  bool _passwordVisible = false;

  // void printController() {
  //   print(_nameController.text);
  //   print(_passwordController.text);
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const TaskMainPage()));
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: formPadding, vertical: formPaddingVertical),
              child: Text(
                widget.title,
                style: const TextStyle(height: 3, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: formPadding, vertical: formPaddingVertical),
              child: NameInput(
                nameController: widget.firstController,
                labelText: widget.firstText,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: formPadding, vertical: formPaddingVertical),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira algum texto';
                  }

                  return null;
                },
                decoration: InputDecoration(
                    labelText: widget.secondText,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
                obscureText: !_passwordVisible,
                controller: widget.secondController,
              ),
            ),
            LoginButton(
              formKey: _formKey,
              pressed: widget.buttonCallback,
              buttonText: widget.buttonText,
              pressedSuccessText: widget.pressedSuccessText,
            ),
          ],
        ));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required Function pressed,
    required String buttonText,
    required String pressedSuccessText,
  })  : _formKey = formKey,
        _pressed = pressed,
        button = buttonText,
        _pressedSuccessText = pressedSuccessText;

  final GlobalKey<FormState> _formKey;
  final Function _pressed;
  final String button;
  final String _pressedSuccessText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          _pressed();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_pressedSuccessText)),
          );
        }
      },
      child: Text(button),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
    required TextEditingController nameController,
    required this.labelText,
  }) : _nameController = nameController;
  final TextEditingController _nameController;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algum texto';
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: labelText, border: const OutlineInputBorder()),
      controller: _nameController,
    );
  }
}
