import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'bloc/bloc.dart';
import 'modules/seacrh/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){

        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(

            title: Row(
              children: [
                Text(
                    'News App'
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    navigateTo(context, SearchScreen(),);
              }),
              IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: (){
                    //NewsCubit.get(this).changeTheme(ThemeMode.light);
                    //print(NewsCubit.get(context).isDark);
                    //NewsCubit.get(context).isDark = !NewsCubit.get(context).isDark;
                     NewsDarkCubit.get(context).changeModeOfApp();
                    //print(NewsCubit.get(context).isDark);

                    // setState(){
                    //
                    // }
                  }

                  ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
