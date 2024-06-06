import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Данные кнопок навигационной панели
const Map<String, IconData> navItems = {
  'Лента': Icons.home,
  'Обзор': Icons.search,
  'Контент': Icons.add_circle,
  'Люди': Icons.person,
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
