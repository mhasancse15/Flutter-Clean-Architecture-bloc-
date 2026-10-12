import 'package:cleanarch/core/usecases/usecase.dart';
import 'package:cleanarch/features/post/domain/entities/post_entity.dart';
import 'package:cleanarch/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostUseCase implements UseCase<List<PostEntity>, NoParams> {
  final PostRepository postRepository;
  GetPostUseCase(this.postRepository);

  @override
  Future<Either<Exception, List<PostEntity>>> call(NoParams params) {
    return postRepository.getPosts();
  }
}