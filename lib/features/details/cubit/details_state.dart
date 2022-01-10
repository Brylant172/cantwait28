part of 'details_cubit.dart';

class DetailsState {
  const DetailsState({
    this.itemModel,
    this.isLoading = false,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
  final ItemModel? itemModel;
  final bool isLoading;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
