import 'package:cleanarch/features/post/domain/entities/post_entity.dart';

abstract class PostEvent {}

class PostFetchEvent extends PostEvent {}

class PostCreateEvent extends PostEvent {
  final PostEntity post;
  PostCreateEvent(this.post);
}