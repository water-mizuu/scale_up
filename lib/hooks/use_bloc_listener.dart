import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

typedef BlocComparativeListenerCondition<S> = bool Function(S previous, S current);

void useBlocListener<S>(
  BlocBase<S> bloc,
  void Function(S current) listener, {
  BlocComparativeListenerCondition<S>? listenWhen,
  List<Object?>? keys,
}) {
  final currentState = useRef(bloc.state);
  final context = useContext();

  useEffect(() {
    final subscription = bloc.stream
        .where((nextState) {
          final shouldInvokeAction = listenWhen?.call(currentState.value, nextState) ?? true;
          currentState.value = nextState;
          return shouldInvokeAction;
        })
        .listen((state) {
          if (context.mounted) {
            return listener(state);
          }
        });

    return subscription.cancel;
  }, [bloc, ...keys ?? []]);
}
