import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/cubit/cubit.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefixIcon: Icons.search,
                      ),
                      const SizedBox(height: 15.0),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 15.0),
                      if (state is SearchSuccessState)
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data[index],
                            context,
                            isSearch: true,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data
                              .length,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
