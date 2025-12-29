import 'package:bloc_state/bloc/counter_events.dart';
import 'package:bloc_state/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterIncrementPressed>((event, emit) {
      // increment the counter
      emit(CounterState(state.count + 1));
    });
    on<CounterDecrementPressed>((event, emit) {
      //decrement the counter
      emit(CounterState(state.count - 1));
    });
  }
}
// emit = kora hoy ui ke jante je event theke  notun state asche 