import 'dart:convert';
import 'package:cleanarch/core/networking/api_client.dart';
import 'package:cleanarch/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PostRemoteDataSource {
  Future<Either<Exception, List<PostModel>>> getPosts();
  Future<Either<Exception, PostModel>> createPost(PostModel post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiClient apiClient;
  PostRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Exception, List<PostModel>>> getPosts() async {
    try {
      final response = await apiClient.sendRequest.get("/posts");
      if(response.statusCode == 200) {
        final List<PostModel> posts = (response.data as List)
            .map((post) => PostModel.fromJson(post))
            .toList();
        return Right(posts);
      } else {
        return Left(Exception("Failed to fetch posts"));
      }
    }
    on DioException catch (ex) {
      return Left(Exception(ex.message));
    }
    catch(ex) {
      return Left(Exception(ex.toString()));
    }
  }

  @override
  Future<Either<Exception, PostModel>> createPost(PostModel post) async {
    try {
      final response = await apiClient.sendRequest.post("/posts", data: jsonEncode(post.toJson()));
      if(response.statusCode == 201) {
        final PostModel createdPost = PostModel.fromJson(response.data);
        return Right(createdPost);
      } else {
        return Left(Exception("Failed to create post"));
      }
    }
    on DioException catch (ex) {
      return Left(Exception(ex.message));
    }
    catch(ex) {
      return Left(Exception(ex.toString()));
    }
  }
}