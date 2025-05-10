import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";

/// A [HookWidget] that provides a [Provider] to its descendants.
/// This is a [StatelessWidget] that uses the [HookWidget] mixin.
/// It is used to provide a [Provider] to its descendants.
abstract class ProvidingHookWidget extends StatelessWidget {
  /// Initializes [key] for subclasses.
  const ProvidingHookWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  createElement() => _StatelessHookElement(this);
}

class _StatelessHookElement extends StatelessElement with _ProvidingElement, HookElement {
  _StatelessHookElement(ProvidingHookWidget super.hooks);
}

/// A [StatefulWidget] that provides a [Provider] to its descendants.
/// This is a [StatefulWidget] that uses the [HookWidget] mixin.
/// It is used to provide a [Provider] to its descendants.
abstract class StatefulProvidingHookWidget extends StatefulWidget {
  /// Initializes [key] for subclasses.
  const StatefulProvidingHookWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  createElement() => _StatefulHookElement(this);
}

class _StatefulHookElement extends StatefulElement with _ProvidingElement, HookElement {
  _StatefulHookElement(StatefulProvidingHookWidget super.hooks);
}

void _provide(SingleChildWidget provider) {
  var element = _ProvidingElement._currentProvidingElement;
  if (element == null) {
    throw Exception("_provide() can only be used in a ProvidingHookWidget");
  }
  element._provided.add(_Entry(provider));
}

/// A hook that manages a disposable resource.
/// It creates the resource when the hook is first used and disposes of it
T useDisposable<T extends Object>(
  T Function() create,
  void Function(T) dispose, [
  List<Object> dependencies = const [],
]) {
  var ref = useRef(null as T?);
  useEffect(() {
    ref.value = create();

    return () => dispose(ref.value!);
  }, dependencies);

  return ref.value!;
}

/// A hook that provides a value to its descendants.
/// It utilizes the [InheritedProvider] to provide the value.
///
/// See [InheritedProvider] for more information.
T useInheritedProvide<T extends Object>(T object) {
  useEffect(() {
    _provide(InheritedProvider<T>.value(value: object));
  }, null);

  return object;
}

T useProvide<T extends Object>(T object, {List<Object> dependencies = const []}) {
  useEffect(() {
    _provide(Provider<T>.value(value: object));
  }, null);

  return object;
}

/// A hook that provides a [Bloc] to its descendants.
/// It utilizes the [BlocProvider] to provide the [Bloc].
/// It is a wrapper around [useInheritedProvide] that provides a [Bloc].
///
/// See [BlocProvider] for more information.
T useProvidedBloc<T extends BlocBase>(
  T Function() blocFactory, {
  List<Object> dependencies = const [],
  Key? key,
}) {
  var local = useDisposable(blocFactory, (b) => b.close(), dependencies);
  useEffect(() {
    _provide(BlocProvider<T>.value(value: local, key: key));
  }, null);

  return local;
}

/// A [ProvidingHookWidget] that delegates its `build` to a callback.
class ProvidingHookBuilder extends ProvidingHookWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const ProvidingHookBuilder({required this.builder, super.key});

  /// The callback used by [HookBuilder] to create a [Widget].
  ///
  /// If a [Hook] requests a rebuild, [builder] will be called again.
  /// [builder] must not return `null`.
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

extension UseProvideExtension<T extends Object> on T {
  /// Provides the value to its descendants.
  /// It utilizes the [InheritedProvider] to provide the value.
  /// See [InheritedProvider] for more information.
  O useProvide<O>([O Function(T)? map]) {
    var value = (map ?? ((e) => e as O)).call(this);
    _provide(InheritedProvider<O>.value(value: value));

    return value;
  }
}

final class _Entry<T> extends LinkedListEntry<_Entry<T>> {
  _Entry(this.value);
  T value;
}

/// An [Element] that uses a [ProvidingHookWidget] as its configuration.
mixin _ProvidingElement on ComponentElement {
  static _ProvidingElement? _currentProvidingElement;

  final _provided = LinkedList<_Entry<SingleChildWidget>>();

  @override
  Widget build() {
    _ProvidingElement._currentProvidingElement = this;

    var child = super.build();
    var widget =
        _provided.isEmpty
            ? child
            : MultiProvider(
              providers: _provided.map<SingleChildWidget>((entry) => entry.value).toList(),
              child: child,
            );

    _ProvidingElement._currentProvidingElement = null;
    _provided.clear();

    return widget;
  }
}
