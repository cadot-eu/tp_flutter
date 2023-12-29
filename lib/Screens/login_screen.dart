import 'package:flutter/material.dart';
import 'package:tp/gen/assets.gen.dart';
import 'package:tp/helpers/database_helper.dart';
import 'package:cool_alert/cool_alert.dart';

import '../styles/login.dart';
import 'app_bar_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
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
                                  CoolAlert.show(
                                    context: scaffoldContext,
                                    type: CoolAlertType.success,
                                    title: "Success",
                                    text: successMessage,
                                  );
                                } else {
                                  CoolAlert.show(
                                    context: scaffoldContext,
                                    type: CoolAlertType.error,
                                    title: "Error",
                                    text: "Identifiants incorrects",
                                  );
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
          ],
        ),
      ),
    );
  }
}
