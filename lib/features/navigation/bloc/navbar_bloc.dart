import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_event.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_state.dart';

export 'navbar_event.dart';
export 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    on<ChangeNavbarTabEvent>(_onChangeNavbarTab);
  }

  void _onChangeNavbarTab(
    ChangeNavbarTabEvent event,
    Emitter<NavbarState> emit,
  ) {
    final validIndex = event.index.clamp(0, NavbarTab.values.length - 1);
    emit(state.copyWith(
      currentIndex: validIndex,
      currentTab: NavbarTab.values[validIndex],
    ));
  }
}
