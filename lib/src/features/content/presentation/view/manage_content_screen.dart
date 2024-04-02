import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/presentation/widgets/widgets.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get the currently loggen-in user.
    User user = const User(
        id: '_',
        username: Username.dirty('Alex'),
        imagePath: 'assets/images/image_1.jpg');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            user.username.value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            body: TabBarView(
              children: [
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 16,
                    ),
                    itemBuilder: (context, index) {
                      Post post = Post(
                        id: 'id',
                        user: user,
                        caption: 'Test',
                        assetPath: 'assets/videos/video_1.mp4',
                      );
                      return CustomVideoPlayer(
                        assetPath: post.assetPath,
                      );
                    }),
                Center(child: Text('Second tab')),
              ],
            ),
            headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      CustomUserInformation(
                        user: user,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.goNamed('add_content');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF006E),
                              fixedSize: const Size(170, 50),
                            ),
                            child: Text(
                              'Add a video',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF006E),
                              fixedSize: const Size(170, 50),
                            ),
                            child: Text(
                              'Update picture',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            icon: Icon(Icons.grid_view_rounded),
                          ),
                          Tab(
                            icon: Icon(Icons.favorite_sharp),
                          ),
                        ],
                      )
                    ],
                  )),
                ]),
          ),
        ));
  }
}
