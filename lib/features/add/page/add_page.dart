import 'package:cantwait28/features/add/cubit/add_cubit.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatelessWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.saved == true) {
            Navigator.of(context).pop();
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An error occured: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Dodaj nową premierę'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AddCubit>().add(
                            ItemModel(
                              imageURL:
                                  'https://playsiders.com/wp-content/uploads/2021/12/Horizon-Forbidden-West_PS4.jpg',
                              title: 'Horizon Forbidden West',
                              releaseDate: DateTime(2022, 2, 18),
                            ),
                          );
                    },
                    icon: const Icon(
                      Icons.check,
                    ),
                  ),
                ],
              ),
              body: const _AddPageBody(),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: const [],
    );
  }
}
