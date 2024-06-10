import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/presentation/bloc/shared_states_bloc.dart';

import '../../../config/res_string.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorText;
  const ErrorIndicator({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      backgroundColor: Colors.white,
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      title: Text(
        ResString.error,
        style: appTextTheme.bodyLarge!.copyWith(color: Colors.black),
      ),
      content: Text(
        errorText,
        style: appTextTheme.bodyMedium!.copyWith(color: Colors.black),
      ),
      actions: [
        ElevatedButton(
          child: Text(
            ResString.ok,
            style: appTextTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
          onPressed: () {
            context.read<SharedStatesBloc>().add(GoToInitialStatusEvent());
          },
        ),
      ],
    );
  }
}
