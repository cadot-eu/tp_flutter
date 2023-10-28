import 'package:flutter/material.dart';
import 'package:tp/gen/assets.gen.dart';

import '../styles/login.dart';
import 'app_bar_widget.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: emailStyle,
                          ),
                        ),
                        TextFormField(
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
                                onPressed: () {},
                                child: const Text('Login'),
                              ),
                              const Divider(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
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
