import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

T useRead<T>() {
  final context = useContext();
  final provider = context.read<T>();
  if (provider == null) {
    throw Exception("No provider found for type $T");
  }
  return provider;
}

T useWatch<T>() {
  final context = useContext();
  final provider = context.watch<T>();
  if (provider == null) {
    throw Exception("No provider found for type $T");
  }
  return provider;
}

R useSelect<T, R>(R Function(T) selector) {
  final context = useContext();
  final provider = context.select<T, R>(selector);
  if (provider == null) {
    throw Exception("No provider found for type $T");
  }
  return provider;
}
