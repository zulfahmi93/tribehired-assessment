import 'package:injectable/injectable.dart';

import '../models/models.dart';
import 'http.dart';

@injectable
class CommentsApiClient {
  // ------------------------------- CONSTRUCTORS ------------------------------
  CommentsApiClient({required HttpClient client}) : _client = client;

  // ---------------------------------- FIELDS ---------------------------------
  final HttpClient _client;

  // --------------------------------- METHODS ---------------------------------
  Future<List<Comment>> getAllComments({required int postId}) async {
    const uri = 'https://jsonplaceholder.typicode.com/comments';
    final queries = {'postId': postId};
    final response = await _client.send<void, List<Comment>>(
      path: uri,
      queryParameters: queries,
    );
    return response.data ?? [];
  }
}
