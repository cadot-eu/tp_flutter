import 'package:flutter/material.dart';
import 'package:tp/Screens/app_bar_widget.dart';

import '../Validators/email_validator.dart';
import '../Validators/name_validator.dart';
import '../Validators/password_validator.dart';

import '../helpers/database_helper.dart';

import '../styles/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Registration', style: titreStyle),
                TextFormField(
                  validator: (value) {
                    final email = EmailValidator().validate(value);
                    if (email != true) {
                      return email;
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: fieldStyle,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    final password = PasswordValidator()
                        .validate(value, repeatPasswordController.text);
                    if (password != true) {
                      return password;
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: passwordStyle,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                  controller: repeatPasswordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Repeat Password',
                    labelStyle: passwordStyle,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    final name = NameValidator().validate(value);
                    if (name != true) {
                      return name;
                    }
                    return null;
                  },
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'First Name',
                    labelStyle: fieldStyle,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    final name = NameValidator().validate(value);
                    if (name != true) {
                      return name;
                    }
                    return null;
                  },
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Last Name',
                    labelStyle: fieldStyle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Hello .')));
                    } else {
                      // The form has some validation errors.
                      // Do Something...
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
