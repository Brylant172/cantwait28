import 'package:cantwait28/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Can\'t Wait 🤩'),
      ),
      body: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..start(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            children: const [
              _ListViewItem(
                imageURL:
                    'https://www.imore.com/sites/imore.com/files/styles/xlarge/public/field/image/2021/08/pokemon-legends-arceus-fighting-growlithe.jpg',
                title: 'Pokémon Legends: Arceus',
                releaseDate: '2022-01-28',
                daysLeft: 28,
              ),
              _ListViewItem(
                imageURL:
                    'https://media.altchar.com/prod/images/940_530/gm-b45b4ee3-8212-415e-8640-bd6814933428-gta-vi.jpg',
                title: 'GTA VI',
                releaseDate: '2023-06-27',
                daysLeft: 450,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.releaseDate,
    required this.daysLeft,
  }) : super(key: key);

  final String imageURL;
  final String title;
  final String releaseDate;
  final int daysLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.black12,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(
                  imageURL,
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
                        title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(releaseDate),
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
                      '$daysLeft',
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
        ],
      ),
    );
  }
}
