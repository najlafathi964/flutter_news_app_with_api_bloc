import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/cubit/app_cubit.dart';
import 'package:news_app_api/cubit/app_state.dart';
import 'package:news_app_api/shared/components.dart';

class searchScreen extends StatelessWidget{
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder:(context , state ) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return " search musnt be empty ";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Sraech ',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()
                  ),
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);

                  },
                ),
              ),
              Expanded(child: articalBuilder(list, context , isSearch: true))
            ],
          ),
        );
      }
    );
  }

}