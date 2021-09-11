import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object event) {
  //   print('Event $event');
  //   super.onEvent(bloc, event);
  // }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('Transition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('Error $error');
    super.onError(bloc, error, stackTrace);
  }
}
