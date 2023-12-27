import 'package:flutter/material.dart';
import 'package:tp/Screens/app_bar_widget.dart';
import 'package:tp/Screens/login_screen.dart';

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
  final _emailController = TextEditingController(text: 'a@cadot.eu');
  final _passwordController = TextEditingController(text: 'aaaaaaaa1');
  final _repeatpasswordController = TextEditingController(text: 'aaaaaaaa1');
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doedoe');

  Icon? suffixicon;

  final errorIcon = const Icon(Icons.error);
  final doneIcon = const Icon(Icons.done);

  static const String _successMessage = 'Registered successfully';
  static const String _errorMessage = 'Error creating account';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
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
                    controller: _emailController,
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
                          .validate(value, _repeatpasswordController.text);
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
                    controller: _passwordController,
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
                    controller: _repeatpasswordController,
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
                    controller: _firstNameController,
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
                    controller: _lastNameController,
                    decoration: TextFieldDecoration.fieldDecoration(
                      suffixicon: suffixicon,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Last Name',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final db = DatabaseHelper();
                        final user = {
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'firstName': _firstNameController.text,
                          'lastName': _lastNameController.text
                        };
                        db.insertUser(user).then((id) async {
                          // L'opération d'insertion a réussi
                          const snackBar = SnackBar(
                            content: Text(_successMessage),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          await Future.delayed(const Duration(seconds: 2));
                          //redirect to login
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }).catchError((error) {
                          // Une erreur s'est produite lors de l'insertion
                          const snackBar = SnackBar(
                            content: Text(_errorMessage),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
