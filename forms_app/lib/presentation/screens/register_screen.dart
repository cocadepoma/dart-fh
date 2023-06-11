import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New user'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              FlutterLogo(size: 100),
              SizedBox(height: 20),
              _RegisterForm(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
              CustomTextFormField(
                label: 'Username',
                icon: const Icon(Icons.supervised_user_circle),
                onChanged: (value) => username = value,
                validator: (value) {
                  if(value == null || value.isEmpty || value.trim().isEmpty) return 'Required field';
                  if(value.length < 6) return 'The username should have at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              CustomTextFormField(
                label: 'Email',
                icon: const Icon(Icons.email),
                onChanged: (value) => email = value,
                validator: (value) {
                  if(value == null || value.isEmpty || value.trim().isEmpty) return 'Required field';
                  
                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if(!emailRegExp.hasMatch(value)) return 'Email not valid';

                  return null;
                },
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                label: 'Password',
                icon: const Icon(Icons.key),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) {
                  if(value == null || value.isEmpty || value.trim().isEmpty) return 'Required field';
                  if(value.length < 6) return 'The username should have at least 6 characters';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              FilledButton.tonalIcon(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();

                  if(!isValid) return;
                },
                label: const Text('Create User'),
              ),
        ],
      ),
    );
  }
}