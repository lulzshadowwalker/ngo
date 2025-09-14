sealed class MainNavState {}

final class MainNavInitial extends MainNavState {}

final class MainNavIndexChanged extends MainNavState {
  final int currentIndex;

  MainNavIndexChanged(this.currentIndex);
}
