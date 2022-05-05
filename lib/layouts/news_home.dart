import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/cubit/app_cubit.dart';
import 'package:news_app_api/modules/search_screen.dart';
import 'package:news_app_api/shared/components.dart';

import '../cubit/app_state.dart';

class news_home extends StatelessWidget {
  List titels = ["Business News", "Sport News" ,"Science News" ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) => {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:Text(titels[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, searchScreen());
                    },
                    icon: Icon(Icons.search , )
                ) ,
                IconButton(
                    onPressed: () {
                      cubit.changeAppMode() ;
                      },
                    icon: Icon(Icons.brightness_4_outlined ,)
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        });
  }
}




