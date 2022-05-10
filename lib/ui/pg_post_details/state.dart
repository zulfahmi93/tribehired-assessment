import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../api/api.dart';
import '../../di/di.dart';
import '../../models/models.dart';

class PostDetailsPageState extends ChangeNotifier {
  // ------------------------------- CONSTRUCTORS ------------------------------
  PostDetailsPageState({
    required this.post,
  });

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;
  final _commentClient = getIt.get<CommentsApiClient>();

  // -------------------------------- PROPERTIES -------------------------------
  // IS BUSY ////////////////////////////////////
  bool _isBusy = true;

  bool get isBusy => _isBusy;

  // IS BUSY ////////////////////////////////////
  bool _isError = false;

  bool get isError => _isError;

  // COMMENTS ///////////////////////////////////
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  // FILTERED COMMENTS //////////////////////////
  List<Comment> _filteredComments = [];

  List<Comment> get filteredComments => _filteredComments;

  // SEARCH QUERY ///////////////////////////////
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  // --------------------------------- METHODS ---------------------------------
  Future<void> initialise() async {
    _isBusy = true;
    notifyListeners();

    try {
      _comments = await _commentClient.getAllComments(postId: post.id);
      _filteredComments = List.from(_comments);
    } on DioError catch (e, s) {
      _isError = true;
      notifyListeners();
      Logger.root.severe('Failed to get all comments!', e, s);
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  void search({required String query}) {
    if (query.isNotEmpty) {
      _filteredComments = _comments.where((c) {
        return c.name.toLowerCase().contains(query) ||
            c.email.toLowerCase().contains(query) ||
            c.body.toLowerCase().contains(query);
      }).toList();
    } else {
      _filteredComments = List.from(_comments);
    }

    _searchQuery = query;
    notifyListeners();
  }
}
