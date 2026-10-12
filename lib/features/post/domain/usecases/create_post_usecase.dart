import 'package:cleanarch/core/usecases/usecase.dart';
import 'package:cleanarch/features/post/domain/entities/post_entity.dart';
import 'package:cleanarch/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePostUseCase implements UseCase<PostEntity, PostEntity> {
  final PostRepository postRepository;
  CreatePostUseCase(this.postRepository);
  
  @override
  Future<Either<Exception, PostEntity>> call(PostEntity params) {
    return postRepository.createPost(params);
  }
}