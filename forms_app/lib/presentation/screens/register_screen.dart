import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New user'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      child: Column(
        children: [
              CustomTextFormField(
                label: 'Username',
                icon: const Icon(Icons.supervised_user_circle),
                onChanged: registerCubit.usernameChanged,
                errorMessage: username.errorMessage
              ),
              const SizedBox(height: 20),
              
              CustomTextFormField(
                label: 'Email',
                icon: const Icon(Icons.email),
                onChanged: (value) {
                  registerCubit.emailChanged(value);
                },
                errorMessage: email.errorMessage,
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                label: 'Password',
                icon: const Icon(Icons.key),
                obscureText: true,
                onChanged: (value) {
                  registerCubit.passwordChanged(value);
                },
                errorMessage: password.errorMessage,
              ),

              const SizedBox(height: 20),

              FilledButton.tonalIcon(
                icon: const Icon(Icons.save),
                onPressed: registerCubit.state.isValid
                ? () {
                  registerCubit.onSubmit();
                }
                : null,
                label: const Text('Create User'),
              ),
        ],
      ),
    );
  }
}