import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return (ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null)
            ? builderWidget(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel,
                context,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget builderWidget(
      HomeModel? model, CategoriesModel? categoriesModel, context) {
    bool oren = MediaQuery.of(context).orientation == Orientation.landscape;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map(
                  (banner) => Image(
                    image: NetworkImage(banner.image),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 150.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(
                        categoriesModel.data!.data[index], context),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5.0),
                    itemCount: categoriesModel!.data!.data.length,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / (oren ? 1.1 : 1.85),
              children: List.generate(
                model.data!.products.length,
                (index) => buildListProduct(
                  model.data!.products[index],
                  context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model, context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 160.0,
            width: (MediaQuery.of(context).size.width - 20) / 2,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 150.0,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
}
