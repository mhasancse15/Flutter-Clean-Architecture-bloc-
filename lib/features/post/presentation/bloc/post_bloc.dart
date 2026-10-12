import 'package:cleanarch/core/usecases/usecase.dart';
import 'package:cleanarch/features/post/domain/usecases/create_post_usecase.dart';
import 'package:cleanarch/features/post/domain/usecases/get_post_usecase.dart';
import 'package:cleanarch/features/post/presentation/bloc/post_event.dart';
import 'package:cleanarch/features/post/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUseCase getPostUseCase;
  final CreatePostUseCase createPostUseCase;

  PostBloc({required this.getPostUseCase, required this.createPostUseCase}) : super(PostInitialState()) {

    on<PostFetchEvent>((event, emit) async {
      emit(PostLoadingState(posts: state.posts));
      final result = await getPostUseCase.call(NoParams());
      result.fold(
        (failure) => emit(
          PostErrorState(posts: state.posts, message: failure.toString()),
        ),
        (posts) => emit(PostLoadedState(posts: posts)),
      );
    });

    on<PostCreateEvent>((event, emit) async {
      emit(PostLoadingState(posts: state.posts));
      final result = await createPostUseCase.call(event.post);
      result.fold(
        (failure) => emit(
          PostErrorState(posts: state.posts, message: failure.toString()),
        ),
        (post) => emit(PostLoadedState(posts: [post, ...state.posts])),
      );
    });
  }
}
