import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

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
            _SignUp(),
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
    return const CustomTextField(
      labelText: 'Username',
      textInputType: TextInputType.name,
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: 'E-mail',
      textInputType: TextInputType.emailAddress,
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: 'Password',
      obscureText: true,
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
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
