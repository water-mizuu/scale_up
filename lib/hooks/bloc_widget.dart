import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";

abstract base class StatelessBlocWidget<B extends BlocBase> extends StatelessWidget {
  const StatelessBlocWidget({required this.factory, super.key});

  final B Function(BuildContext context) factory;

  @override
  createElement() => _StatelessProvidingElement(this);
}

class _StatelessProvidingElement extends StatelessElement with _BlocElement {
  _StatelessProvidingElement(StatelessBlocWidget super.widget);
}

mixin _BlocElement on ComponentElement {
  @override
  Widget build() {
    if (widget case StatelessBlocWidget(:var factory)) {
      return BlocProvider(create: factory, child: super.build());
    }
    return super.build();
  }
}
