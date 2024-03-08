import 'dart:async';

import 'package:cat_facts/cubit/breed/breed_cubit.dart';
import 'package:cat_facts/data/models/breeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedScreen extends StatelessWidget {
  BreedScreen({super.key});

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          final breedBloc = BlocProvider.of<BreedCubit>(context);
          if (breedBloc.page <= breedBloc.lastPage) {
            breedBloc.loadBreeds();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<BreedCubit>(context).loadBreeds();

    return Scaffold(
      body: _breedsList(),
    );
  }

  Widget _breedsList() {
    return BlocBuilder<BreedCubit, BreedState>(builder: (ctx, state) {
      if (state is BreedLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Breed> breeds = [];
      bool isLoading = false;

      if (state is BreedLoading) {
        breeds = state.oldBreeds.data;
        isLoading = true;
      } else if (state is BreedLoaded) {
        breeds = state.breeds.data;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1),
            itemBuilder: (context, index) {
              if (index < breeds.length) {
                return _breeds(breeds[index], context);
              } else {
                Timer(const Duration(microseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return _loadingIndicator();
              }
            },
            itemCount: breeds.length + (isLoading ? 1 : 0)),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _breeds(Breed breed, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            breed.breed,
            style:
                TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600),
          ),
          Text(
            breed.country,
            style:
                TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
          ),
          Text(breed.coat),
          Text(breed.origin),
          Text(breed.pattern),
        ]),
      ),
    );
  }
}
