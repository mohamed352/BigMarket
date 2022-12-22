import 'package:app/shared/componets/compontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/search_cubit.dart';

// ignore: camel_case_types, must_be_immutable
class Search_Screen extends StatelessWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchControelr = TextEditingController();
    final fromkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(appBar: AppBar(),
          body: Form(
            key: fromkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textfromfielde(
                      label: 'Search',
                      controller: searchControelr,
                      type: TextInputType.text,
                      prefix: Icons.search,
                      vildate: (String value) {
                        if (value.isEmpty) {
                          return 'Search is Empty';
                        }
                      },
                      onsubmaited: (String text) {
                        SearchCubit.get(context).searchdata(text);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SearchInitialLoadData)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SearchInitialScsfulltData)
                    Expanded(
                      child: ListView.separated(
                      
                           physics:const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context)
                                .searchmodel!
                                .data!
                                .data![index],
                            context,
                            isOldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchmodel!
                            .data!
                            .data!
                            .length,
                      ),
                    )
                ],
              ),
            ),
          )
           ,);

         
        },
      ),
    );
  }
}
