import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc_states.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class NewsDarkCubit extends Cubit<NewsDarkStates> {
  NewsDarkCubit() : super(NewsDarkModeInitialState());

  static NewsDarkCubit get(context) => BlocProvider.of(context);



  bool  isDark = false;
  void changeModeOfApp({bool fromShared}){
    if(fromShared != null){
      isDark = fromShared;

      emit(NewsDarkModeSuccessState());
    }else{
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(NewsDarkModeSuccessState());
      });
    }
  }
}