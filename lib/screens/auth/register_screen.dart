import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/bloc/login/login_bloc.dart';
import 'package:hero_dex_go/bloc/login/login_event.dart';
import 'package:hero_dex_go/bloc/login/login_state.dart';
import 'package:hero_dex_go/repositories/auth_repository.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeColors? themeColors = Theme.of(context).extension<ThemeColors>();
    final Color primaryColor = themeColors?.primaryColor ?? Colors.blue;
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const _RegisterForm(),
    );
  }
}


class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).extension<ThemeColors>();
    final Color primaryColor = themeColors?.primaryColor ?? Colors.blue;

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          }
        ),
        title: const Text(
          "HeroDex GO",
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 18,
          )
        ),

        actions: [
          TextButton(
            onPressed: () {
              // TODO: Logic
              debugPrint("Help pressed");
            },
            child: Text(
              "Help",
              style: TextStyle(
                color: primaryColor,
                fontWeight: .bold,
                fontSize: 16,
              )
            )
          )
        ],
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Authentication failed')),
            );
          }
          if (state.status == LoginStatus.success) {
            context.go('/home');
          }
        },
        child: Padding(
          padding: const .all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome Back!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 30),
              
              // Email Input
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: state.status == LoginStatus.failure ? 'Check your email' : null,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value)),
                  );
                },
              ),

              const SizedBox(height: 20),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                  );
                },
              ),

              const SizedBox(height: 30),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status == LoginStatus.loading) {
                    return const CircularProgressIndicator();
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const .symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(RegisterSubmitted());
                      },
                      child: const Text('Register'),
                    ),
                  );
                }
              )
            ]
          ),
        ),
      )
    );
  }
}