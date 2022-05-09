import 'package:injectable/injectable.dart';

import '../models/models.dart';
import 'http.dart';

@injectable
class PostsApiClient {
  // ------------------------------- CONSTRUCTORS ------------------------------
  PostsApiClient({required HttpClient client}) : _client = client;

  // ---------------------------------- FIELDS ---------------------------------
  final HttpClient _client;

  // --------------------------------- METHODS ---------------------------------
  Future<List<Post>> getAllPosts() async {
    const uri = 'https://jsonplaceholder.typicode.com/posts';
    final response = await _client.send<void, List<Post>>(path: uri);
    return response.data ?? [];
  }

  Future<Post?> getPostById({required int postId}) async {
    final uri = 'https://jsonplaceholder.typicode.com/posts/$postId';
    final response = await _client.send<void, Post>(path: uri);
    return response.data;
  }
}
