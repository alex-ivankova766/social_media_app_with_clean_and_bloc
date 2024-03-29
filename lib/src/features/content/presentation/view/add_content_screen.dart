import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/content/presentation/cubit/add_content_cubit.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/presentation/widgets/widgets.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Content',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddContentCubit>().reset();
            },
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AddContentCubit, AddContentState>(
        buildWhen: ((previous, current) => previous.video != current.video),
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  _handleVideo().then((video) {
                    if (video != null) {
                      context.read<AddContentCubit>().videoChanged(video);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Select a Video',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          } else if (state.video != null) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomVideoPlayer(
                  assetPath: state.video!.path,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          _addCaption(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(56.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Text(
                          'Share',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Future<dynamic> _addCaption(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (newContext) {
        return Container(
          color: Colors.white.withAlpha(175),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add your caption',
                style: Theme.of(newContext)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Expanded(child: 
                  TextFormField(
                    minLines: 3,
                    maxLines: 3,
                    onChanged: (value) {
                      context.read<AddContentCubit>().captionChanged(value);
                    },
                    keyboardType: TextInputType.multiline,
                    style: Theme.of(newContext).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    decoration: InputDecoration(fillColor: Colors.white, filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                    ),
                  ),)
                ],
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                        onPressed: () {
                          context.read<AddContentCubit>().submit();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(56.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Text(
                          'Share',
                          style: Theme.of(newContext).textTheme.bodyMedium,
                        ),
                      )
            ],
          ),
        );
      },
    );
  }

  Future<File?> _handleVideo() async {
    XFile? uploadedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (uploadedVideo == null) {
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    return savedVideo;
  }
}
