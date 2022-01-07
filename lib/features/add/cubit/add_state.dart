part of 'add_cubit.dart';

@immutable
class AddState {
  const AddState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}
