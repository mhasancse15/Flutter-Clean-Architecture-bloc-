import 'package:cleanarch/core/networking/api_client.dart';
import 'package:cleanarch/features/post/data/datasources/post_remote_data_source.dart';
import 'package:cleanarch/features/post/data/repositories/post_repository_impl.dart';
import 'package:cleanarch/features/post/domain/usecases/create_post_usecase.dart';
import 'package:cleanarch/features/post/domain/usecases/get_post_usecase.dart';
import 'package:cleanarch/features/post/presentation/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List initializePostDependencies() {
  return [
    // Datasources
    RepositoryProvider(
      create: (context) => PostRemoteDataSourceImpl(
        context.read<ApiClient>()
      ),
    ),
    
    // Repositories
    RepositoryProvider(
      create: (context) => PostRepositoryImpl(
        context.read<PostRemoteDataSourceImpl>()
      ),
    ),
    
    // Usecases
    RepositoryProvider(
      create: (context) => GetPostUseCase(
        context.read<PostRepositoryImpl>()
      )
    ),
    RepositoryProvider(
      create: (context) => CreatePostUseCase(
        context.read<PostRepositoryImpl>()
      )
    ),
  ];
}

List initializePostBlocs() {
  return [
    BlocProvider(
      create: (context) => PostBloc(
        createPostUseCase: context.read<CreatePostUseCase>(),
        getPostUseCase: context.read<GetPostUseCase>()
      ),
    )
  ];
}