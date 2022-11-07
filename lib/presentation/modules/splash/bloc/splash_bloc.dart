import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/presentation/route/route_list.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashInitialEvent>(initial);
  }

  FutureOr<void> initial(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) {
    emit(SplashFinishState(
      RouteList.homePage,
    ));
  }
}
