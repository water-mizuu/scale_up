import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";
import "package:scale_up/data/repositories/authentication/authentication_repository.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";

class App extends StatefulWidget {
  // Singleton
  const App._internal();
  static final App instance = App._internal();
  factory App() => instance;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        BlocProvider(create: (_) => AuthenticationBloc(repository: _authenticationRepository)),
      ],
      child: MaterialApp.router(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigoAccent,
            brightness: Brightness.light,
          ),
        ),
      ),
    );
  }
}
