import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/post_repositories.dart';
import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier {

 final PostsRepository postsRepository;
 AuthProvider authProvider;

  PostProvider({required this.authProvider, required this.postsRepository});

    bool initialLoading = false;
    bool isLoading = false;
    bool updateLoading = false;
    List<Post> _posts = [];
    Post? _selectedPost;

   Future<void> loadInitialPostsByCompanyId() async {

    initialLoading = true;
    final companyId = authProvider.user!.companyId!;
    try {
      _posts = await postsRepository.getPosts(companyId);
          print("Result:" + _posts.toString());

    } catch (e) {
      throw Exception('Failed to fetch posts by company with id: $companyId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

   Future<void> getPostById(int postId) async {
    isLoading = true;
    notifyListeners();

    try {
      _selectedPost = await postsRepository.getPostById(postId);
    } catch (e) {
      throw Exception('Failed to fetch post with id: $postId');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewPost(
    String title,
    String subject,
    String description,
    int companyId,
    int userId,
    List<String> images,
  ) async {
     final newPost = Post(
      title: title,
      description: description,
      subject: subject,
      companyId: companyId,
      userId: userId,
      userName: "",
      email: "",
      userImage: "",
      rating: 0,
      images: images,
      commentsList: [],
     );

    isLoading = true;
    notifyListeners();

    try {
      await postsRepository.createPost(newPost);
    } catch (e) {
      throw Exception('Failed to create a new post');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePostById(int id) async {
    try {
      // await postsRepository.deletePostById(id);
    } catch (e) {
      throw Exception('Failed to delete post with id: $id');
    }
  }

  Future<void> updateRating(int id) async {
  
    updateLoading = true;

    try {
      await postsRepository.updatePostById(id);
    } catch (e) {
      throw Exception('Failed to update post with id: $id');
    } finally {
      updateLoading = false;
      notifyListeners();
    }
  }

}