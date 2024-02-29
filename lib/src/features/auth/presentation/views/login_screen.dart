import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/auth/presentation/widgets/login_snack_bar.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../cubits/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(authSnackBar(state.errorText ?? 'Auth failure'));
          }
        },
        child: const SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(flex: 3),
              _Username(),
              SizedBox(
                height: 10,
              ),
              _Password(),
              SizedBox(
                height: 10,
              ),
              _LoginButton(),
              Spacer(flex: 2),
              _SignUpRedirect()
            ],
          ),
        )),
      ),
    );
  }
}

class _SignUpRedirect extends StatelessWidget {
  const _SignUpRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.goNamed('signup');
        },
        child: RichText(
            text: TextSpan(children: [
          const TextSpan(text: 'Don\'t you have an account? '),
          TextSpan(
              text: 'Signup',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        ])));
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          onChanged: (username) {
            context.read<LoginCubit>().usernameChanged(username);
          },
          textInputType: TextInputType.name,
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          obscureText: true,
          errorText: state.password.invalid ? 'The password is invalid' : null,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(color: Colors.white)
            : ElevatedButton(
                onPressed: () {
                  state.status == FormzStatus.valid
                      ? context.read<LoginCubit>().logInWithCredentials()
                      : ScaffoldMessenger.of(context).showSnackBar(authSnackBar(
                          'Check your username and password: ${state.status}'));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(100, 50)),
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}
