import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import '../shared/components.dart';

class scienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit , NewsState >(
        listener: (context , state) {} ,
        builder:(context , state){
          var list = NewsCubit.get(context).science;

          return articalBuilder(list , context);
        });
  }

}