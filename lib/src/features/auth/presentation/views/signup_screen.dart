import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../cubits/signup/signup_cubit.dart';
import '../widgets/login_snack_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(flex: 3),
            _Username(),
            SizedBox(
              height: 10,
            ),
            _Email(),
            SizedBox(
              height: 10,
            ),
            _Password(),
            SizedBox(
              height: 10,
            ),
            _SignupButton(),
            Spacer(flex: 2),
            _LoginRedirect()
          ],
        ),
      )),
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          textInputType: TextInputType.name,
          onChanged: (username) {
            context.read<SignupCubit>().usernameChanged(username);
          },
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'E-mail',
          textInputType: TextInputType.emailAddress,
          errorText: state.email.invalid ? 'The email is invalid' : null,
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          obscureText: true,
          textInputType: TextInputType.text,
          errorText: state.password.invalid ? 'The password is invalid' : null,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(color: Colors.white)
            : ElevatedButton(
                onPressed: () {
                  if (state.status == FormzStatus.valid) {
                    context.read<SignupCubit>().signupWithCredentials();
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(authSnackBar(
                        'Check your username, email and password: ${state.status}'));
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(100, 50)),
                child: Text(
                  'Sign up',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ));
      },
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.goNamed('login');
        },
        child: RichText(
            text: TextSpan(children: [
          const TextSpan(text: 'Already have an account? '),
          TextSpan(
              text: 'Login',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        ])));
  }
}
