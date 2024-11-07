import 'dart:convert';
import 'dart:io';

import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

import '../../domain/datasources/comment_datasource.dart';
import '../mappers/comment_mapper.dart';

class CommentsDatasourceImpl extends HttpService implements CommentDatasource {
  @override
  Future<Comment> createCommentByPostId(int postId, Comment comment) async {
    final requestBody = CommentMapper.toJson(comment);
    try {
      final response = await dio.post(
        '/posts/$postId/comments',
        data: jsonEncode(requestBody),
      );

      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to create a new Comment: ${response.statusCode}');
      }

      if(response.data == null || response.data.isEmpty)
      {
        throw Exception('Failed to create a new Comment: Response body is empty');
      }

      return CommentMapper.fromJson(response.data);

    } catch (e) {
      throw Exception('Failed to create a new Comment by post id: $postId');
    }
  }

  @override
  Future<void> deleteCommentByPostIdAndCommentId(int postId, int commentId) async {
    try {
      final deleteResponse = await dio.delete('/posts/$postId/comments/$commentId');
      if (deleteResponse.statusCode != HttpStatus.accepted) {
        throw Exception('Failed to delete comment: ${deleteResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete comment by post id: $postId and comment id: $commentId');
    }
  }

  @override
  Future<List<Comment>> getAllCommentsFromPost(int postId) async {
    try {
      final response = await dio.get('/posts/$postId/comments');

      if (response.statusCode == HttpStatus.ok) {

        print("COMMENT LIST: ${response.data}");

        return CommentMapper.fromJsonList(response.data);
      } else {
        throw Exception('Failed to fetch comments data for post ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch comments by post id $postId: $e');
    }
  }
}