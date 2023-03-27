part of 'splash_screen.dart';

extension SplashAction on SplashScreenState {
  void initial() async {
    bloc.add(SplashInitialEvent());
  }

  void _blocListener(_, SplashState state) {
    if (state is SplashFinishState) {
      final nextScreen = state.nextScreen;
      _launchApp(nextScreen ?? RouteList.homePage);
    }
  }

  void _launchApp(String route) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
    );
  }
}
