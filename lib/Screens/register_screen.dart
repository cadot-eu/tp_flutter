import 'package:flutter/material.dart';
import 'package:tp/Screens/app_bar_widget.dart';

import '../Validators/email_validator.dart';
import '../Validators/name_validator.dart';
import '../Validators/password_validator.dart';

import '../helpers/database_helper.dart';

import '../styles/login.dart';
import '../texts.dart';
import 'decorations/field_decoration.dart';

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

  Icon? suffixicon;

  final errorIcon = const Icon(Icons.error);
  final doneIcon = const Icon(Icons.done);

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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final email = EmailValidator().validate(value);
                    if (email != true) {
                      setState(() {
                        suffixicon = errorIcon;
                      });
                      return email;
                    }
                    setState(() {
                      suffixicon = doneIcon;
                    });
                    return null;
                  },
                  controller: emailController,
                  decoration: TextFieldDecoration.fieldDecoration(
                    suffixicon: suffixicon,
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    final password = PasswordValidator()
                        .validate(value, repeatPasswordController.text);
                    if (password != true) {
                      setState(() {
                        suffixicon = errorIcon;
                      });
                      return password;
                    }
                    setState(() {
                      suffixicon = doneIcon;
                    });
                    return null;
                  },
                  controller: passwordController,
                  decoration: TextFieldDecoration.fieldDecoration(
                    suffixicon: suffixicon,
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Password',
                    hintText: '8 characters and one letter and one number',
                    style: passwordStyle,
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        suffixicon = errorIcon;
                      });
                      return fieldHint;
                    }
                    setState(() {
                      suffixicon = doneIcon;
                    });
                    return null;
                  },
                  controller: repeatPasswordController,
                  decoration: TextFieldDecoration.fieldDecoration(
                    suffixicon: suffixicon,
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Repeat Password',
                    hintText: passwordHint,
                    style: passwordStyle,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    final name = NameValidator().validate(value);
                    if (name != true) {
                      setState(() {
                        suffixicon = errorIcon;
                      });
                      return name;
                    }
                    setState(() {
                      suffixicon = doneIcon;
                    });
                    return null;
                  },
                  controller: firstNameController,
                  decoration: TextFieldDecoration.fieldDecoration(
                    suffixicon: suffixicon,
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'First Name',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    final name = NameValidator().validate(value);
                    if (name != true) {
                      setState(() {
                        suffixicon = errorIcon;
                      });
                      return name;
                    }
                    setState(() {
                      suffixicon = doneIcon;
                    });
                    return null;
                  },
                  controller: lastNameController,
                  decoration: TextFieldDecoration.fieldDecoration(
                    suffixicon: suffixicon,
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Last Name',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //on enregistre les données dans la base et on affiche un message
                      final db = DatabaseHelper();
                      db
                          .saveToDatabase(
                              emailController.text,
                              passwordController.text,
                              firstNameController.text,
                              lastNameController.text)
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                'Registered successfully',
                              ))))
                          .catchError((error) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                'Error',
                              ))));
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
