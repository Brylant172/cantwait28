part of 'home_cubit.dart';

@immutable
class HomeState {
  const HomeState({
    this.items = const [],
  });
  final List<ItemModel> items;
}
