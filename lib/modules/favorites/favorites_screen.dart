import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopLoadingGetFavoritesState
            ? ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                  ShopCubit.get(context)
                      .favoritesModel!
                      .data
                      .data[index]
                      .product,
                  context,
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
