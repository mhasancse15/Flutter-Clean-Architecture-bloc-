import 'package:cleanarch/features/post/data/datasources/post_remote_data_source.dart';
import 'package:cleanarch/features/post/data/models/post_model.dart';
import 'package:cleanarch/features/post/domain/entities/post_entity.dart';
import 'package:cleanarch/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource datasource;
  PostRepositoryImpl(this.datasource);

  @override
  Future<Either<Exception, List<PostEntity>>> getPosts() {
    return datasource.getPosts();
  }
  
  @override
  Future<Either<Exception, PostEntity>> createPost(PostEntity post) {
    return datasource.createPost(PostModel.fromEntity(post));
  }
}