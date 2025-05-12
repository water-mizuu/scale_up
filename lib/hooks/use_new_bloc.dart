import "package:bloc/bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

BLOC useCreateBloc<BLOC extends BlocBase<Object?>>(
  BLOC Function() factory, [
  List<Object?> keys = const [],
]) {
  var state = useMemoized<BLOC>(factory, keys);
  useEffect(() {
    return state.close;
  }, keys);

  return state;
}
