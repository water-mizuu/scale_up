import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

T? useMaybeRead<T extends Object>() {
  final context = useContext();

  try {
    final provider = context.read<T>();
    return provider;
  } on Object {
    return null;
  }
}
