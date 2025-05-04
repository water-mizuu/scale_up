import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

typedef BlocComparativeListenerCondition<S> = bool Function(S previous, S current);

void useBlocListener<S>(
  BlocBase<S> bloc,
  void Function(S current) listener, {
  BlocComparativeListenerCondition<S>? listenWhen,
  List<Object?>? keys,
}) {
  var currentState = useRef(bloc.state);
  var context = useContext();

  useEffect(() {
    return bloc.stream
        .where((nextState) {
          var shouldInvokeAction = listenWhen?.call(currentState.value, nextState) ?? true;
          currentState.value = nextState;
          return shouldInvokeAction;
        })
        .listen((state) {
          if (context.mounted) {
            return listener(state);
          }
        })
        .cancel;
  }, [bloc, ...keys ?? []]);
}
