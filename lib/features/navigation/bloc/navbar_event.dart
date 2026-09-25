import 'package:equatable/equatable.dart';

sealed class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeNavbarTabEvent extends NavbarEvent {
  final int index;

  const ChangeNavbarTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}
