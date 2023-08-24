import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc  bloc, Object? event) {
    super.onEvent(bloc, event);
    // Custom logic to observe events
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
   print('bloc: $bloc , transition: $transition  onTransition OMAR ');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('bloc: $bloc , error: $error , stackTrace: $stackTrace  onError OMAR ' );

  }
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('bloc: $bloc , change: $change  onChange OMAR ' );

  }
}
