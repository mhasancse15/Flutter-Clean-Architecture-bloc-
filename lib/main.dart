import 'package:cleanarch/core/app/observer.dart';
import 'package:cleanarch/core/app/routes.dart';
import 'package:cleanarch/core/networking/api_client.dart';
import 'package:cleanarch/features/post/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  
  runApp(
    MultiRepositoryProvider(
      providers: [
        //global Api Client provider
        RepositoryProvider(
          create: (context) => ApiClient(),
        ),

        //List of DI
        ...initializePostDependencies()
      ],
      //list of bloc provider
      child: MultiBlocProvider(
        providers: [
          ...initializePostBlocs()
        ],
        child: const MyApp()
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false
    );
  }
}