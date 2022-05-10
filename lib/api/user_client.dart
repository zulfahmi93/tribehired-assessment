import 'package:injectable/injectable.dart';

import '../models/models.dart';
import 'http.dart';

@injectable
class UsersApiClient {
  // ------------------------------- CONSTRUCTORS ------------------------------
  UsersApiClient({required HttpClient client}) : _client = client;

  // ---------------------------------- FIELDS ---------------------------------
  final HttpClient _client;

  // --------------------------------- METHODS ---------------------------------
  Future<List<User>> getAllUsers() async {
    const uri = 'https://jsonplaceholder.typicode.com/users';
    final response = await _client.send<void, List<dynamic>>(path: uri);
    final payload = <User>[];
    if (response.data != null) {
      for (final d in response.data!) {
        payload.add(User.fromJson(d));
      }
    }
    return payload;
  }
}
