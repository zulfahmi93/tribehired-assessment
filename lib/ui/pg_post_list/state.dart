import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../api/api.dart';
import '../../di/di.dart';
import '../../models/models.dart';

class PostListPageState extends ChangeNotifier {
  // ---------------------------------- FIELDS ---------------------------------
  final _postClient = getIt.get<PostsApiClient>();
  final _userClient = getIt.get<UsersApiClient>();

  // -------------------------------- PROPERTIES -------------------------------
  // IS BUSY ////////////////////////////////////
  bool _isBusy = true;

  bool get isBusy => _isBusy;

  // IS BUSY ////////////////////////////////////
  bool _isError = false;

  bool get isError => _isError;

  // POSTS //////////////////////////////////////
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  // USERS //////////////////////////////////////
  Map<int, User> _users = {};

  Map<int, User> get users => _users;

  // --------------------------------- METHODS ---------------------------------
  Future<void> initialise() async {
    _isBusy = true;
    notifyListeners();

    try {
      _posts = await _postClient.getAllPosts();
      final users = await _userClient.getAllUsers();
      _users = {for (final user in users) user.id: user};
    } on DioError catch (e, s) {
      _isError = true;
      notifyListeners();
      Logger.root.severe('Failed to get all posts!', e, s);
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }
}
