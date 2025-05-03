import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

typedef BlocComparativeBuilderCondition<S> = bool Function(S previous, S current);

S useBlocBuilder<C extends BlocBase, S>(
  BlocBase<S> bloc, {
  BlocComparativeBuilderCondition<S>? buildWhen,
}) {
  // The stream doesn't support filtering with the previous and current value
  // We have to manually store previous value, especially for initial state
  final currentState = useRef(bloc.state);

  final state = useMemoized(
    () => bloc.stream.where((nextState) {
      final shouldRebuild = buildWhen?.call(currentState.value, nextState) ?? true;
      currentState.value = nextState;
      return shouldRebuild;
    }),
    [bloc],
  );

  return useStream(state, initialData: bloc.state, preserveState: false).requireData!;
}
