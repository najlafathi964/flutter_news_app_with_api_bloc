import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/cubit/app_cubit.dart';
import 'package:news_app_api/cubit/app_state.dart';
import 'package:news_app_api/shared/components.dart';

class businessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit , NewsState >(
         listener: (context , state) {} ,
      builder:(context , state){
           var list = NewsCubit.get(context).business;

           return articalBuilder(list, context);
      });
  }

}