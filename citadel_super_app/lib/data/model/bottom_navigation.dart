enum LoginAs { guest, client, agent }

class BottomNavigation {
  LoginAs loginAs;
  int? selectedIndex;

  int get getSelectedIndex => selectedIndex ?? 0;

  bool get isLoginAsGuest => loginAs == LoginAs.guest;
  bool get isLoginAsClient => loginAs == LoginAs.client;
  bool get isLoginAsAgent => loginAs == LoginAs.agent;

  bool get isClientHomePage =>
      loginAs == LoginAs.client && getSelectedIndex == 0;
  bool get isCorporatePage =>
      loginAs == LoginAs.client && getSelectedIndex == 1;
  bool get isClientOtherPage =>
      loginAs == LoginAs.client && getSelectedIndex == 3;

  bool get isAgentHomePage => loginAs == LoginAs.agent && getSelectedIndex == 0;
  bool get isAgentOtherPage =>
      loginAs == LoginAs.agent && getSelectedIndex == 3;

  BottomNavigation({
    required this.loginAs,
    this.selectedIndex,
  });

  BottomNavigation copyWith({
    LoginAs? loginAs,
    int? selectedIndex,
  }) {
    return BottomNavigation(
      loginAs: loginAs ?? this.loginAs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
