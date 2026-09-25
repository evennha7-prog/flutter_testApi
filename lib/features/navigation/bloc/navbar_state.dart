import 'package:equatable/equatable.dart';

enum NavbarTab { home, search, cart, profile }

class NavbarState extends Equatable {
  final NavbarTab currentTab;
  final int currentIndex;

  const NavbarState({
    this.currentTab = NavbarTab.home,
    this.currentIndex = 0,
  });

  NavbarState copyWith({
    NavbarTab? currentTab,
    int? currentIndex,
  }) {
    final newIndex = currentIndex ?? (currentTab?.index ?? this.currentIndex);
    final clampedIndex =
        newIndex.clamp(0, NavbarTab.values.length - 1);
    return NavbarState(
      currentTab: currentTab ?? NavbarTab.values[clampedIndex],
      currentIndex: clampedIndex,
    );
  }

  @override
  List<Object?> get props => [currentTab, currentIndex];
}
