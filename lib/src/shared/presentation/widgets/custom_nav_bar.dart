import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/config/app_router/routes/index.dart';

import '../../../features/feed/presentation/bloc/feed/feed_bloc.dart';

/// Данные кнопок навигационной панели
const Map<String, IconData> navItems = {
  'Лента': Icons.home,
  'Обзор': Icons.search,
  'Контент': Icons.add_circle,
  'Люди': Icons.person,
};

final Map<String, Function(BuildContext)> screensCallbacks = {
  FeedRoute().location: (BuildContext context) =>
      context.read<FeedBloc>().add(FeedGetPosts()),
};

class BottomNavigationWrapper extends StatefulWidget {
  final StatefulNavigationShell child;

  /// Навигационная панель
  const BottomNavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  late GoRouter goRouter;

  @override
  void initState() {
    super.initState();
    goRouter = GoRouter.of(context);
    goRouter.routerDelegate.addListener(_onListen);
  }

  _onListen() {
    String currentPath = goRouter.routerDelegate.currentConfiguration.fullPath;
    for (var entry in screensCallbacks.entries) {
      if (currentPath == entry.key) {
        entry.value(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: navItems.entries.map((entry) {
          final label = entry.key;
          final iconData = entry.value;
          final int index = navItems.entries
              .toList()
              .indexWhere((entry) => entry.key == label);
          return BottomNavigationBarItem(
            label: '',
            icon: _CustomNavBarItem(
              label: label,
              iconData: iconData,
              isSelected: widget.child.currentIndex == index,
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Элемент навигационной панели
class _CustomNavBarItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isSelected;

  /// Элемент навигационной панели
  const _CustomNavBarItem({
    required this.label,
    required this.iconData,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: isSelected ? Colors.white : Colors.blueGrey,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.white : Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
