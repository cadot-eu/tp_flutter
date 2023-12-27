import 'package:flutter/material.dart';
import 'package:tp/gen/assets.gen.dart';
import 'package:tp/helpers/database_helper.dart';

import '../styles/login.dart';
import 'app_bar_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final db = DatabaseHelper();
    const successMessage = 'Logged in successfully';
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.background.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: titreStyle,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: emailStyle,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: passwordStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  String email = emailController.text;
                                  String password = passwordController.text;

                                  BuildContext scaffoldContext = context;

                                  db
                                      .validateCredentials(email, password)
                                      .then((isValid) {
                                    if (isValid) {
                                      const snackBar = SnackBar(
                                        content: Text(successMessage),
                                      );
                                      ScaffoldMessenger.of(scaffoldContext)
                                          .showSnackBar(snackBar);
                                    } else {
                                      const snackBar = SnackBar(
                                        content:
                                            Text('Identifiants incorrects'),
                                      );
                                      ScaffoldMessenger.of(scaffoldContext)
                                          .showSnackBar(snackBar);
                                    }
                                  });
                                },
                                child: const Text('Login'),
                              ),
                              const Divider(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
