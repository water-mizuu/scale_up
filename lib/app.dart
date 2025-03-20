import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scale_up/data/repositories/authentication/authentication_repository.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart';
import 'package:scale_up/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  // Singleton
  const App._internal();
  static final App instance = App._internal();
  factory App() => instance;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationRepositoryImpl _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
            create: (context) =>
                SignupPageBloc(repository: _authenticationRepository)),
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(repository: _authenticationRepository))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
          brightness: Brightness.light,
        )),
      ),
    );
  }
}
