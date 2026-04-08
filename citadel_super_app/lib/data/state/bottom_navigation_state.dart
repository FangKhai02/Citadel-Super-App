import 'package:citadel_super_app/data/model/bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationState, BottomNavigation>((ref) {
  return BottomNavigationState();
});

class BottomNavigationState extends StateNotifier<BottomNavigation> {
  BottomNavigationState()
      : super(BottomNavigation(
          loginAs: LoginAs.guest,
          selectedIndex: 0,
        ));

  void setLoginAs(LoginAs loginAs) {
    state = state.copyWith(loginAs: loginAs);
  }

  void setSelectedIndex(int selectedIndex) {
    state = state.copyWith(selectedIndex: selectedIndex);
  }
}
