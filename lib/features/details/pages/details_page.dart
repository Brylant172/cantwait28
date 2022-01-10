import 'package:cantwait28/features/details/cubit/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.itemID,
  }) : super(key: key);

  final String itemID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getItemWithID(itemID),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state.removingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to remove the item'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.loadingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Couldn\'t load data :('),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.itemModel?.title ?? ''),
            ),
            body: const _DetailsPageBody(),
            backgroundColor: Colors.grey[200],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
          );
        },
      ),
    );
  }
}

class _DetailsPageBody extends StatelessWidget {
  const _DetailsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final itemModel = state.itemModel;
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (itemModel == null) {
          return const SizedBox.shrink();
        }
        return ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    itemModel.imageURL,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          itemModel.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(itemModel.releaseDateFormatted),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        '${itemModel.daysLeft}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('days left'),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                  '''),
            ),
          ],
        );
      },
    );
  }
}
