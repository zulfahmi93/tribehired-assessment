import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../components/components.dart';
import 'state.dart';

class PostListPage extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const PostListPage({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostListPageState(),
      child: const Scaffold(body: _Content()),
    );
  }
}

class _Content extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Content({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostListPageState>();
    return ListView(
      children: [
        const _Header(),
        if (state.isError) const Error() else const _List(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Header({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        'COMMENTS\nMANAGER',
        style: Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 32.0,
              letterSpacing: 8.0,
            ),
      ),
    );
  }
}

class _List extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _List({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  // --------------------------------- METHODS ---------------------------------
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      context.read<PostListPageState>().initialise();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostListPageState>(
      builder: (context, state, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            bottom: 48.0,
          ),
          itemCount: state.isBusy ? 10 : state.posts.length,
          itemBuilder: (context, i) => _Card(
            post: state.isBusy ? null : state.posts[i],
          ),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Card({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post? post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            _CardImage(post: post),
            const SizedBox(width: 32.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CardTitle(post: post),
                  const SizedBox(height: 4.0),
                  _CardSubTitle(post: post),
                  const SizedBox(height: 24.0),
                  _CardAuthor(post: post),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CardImage({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post? post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    if (post != null) {
      return Image.network(
        'https://picsum.photos/200',
        width: 140.0,
        height: 140.0,
      );
    }

    return const Skeleton(
      width: 140.0,
      height: 140.0,
      radius: 4.0,
    );
  }
}

class _CardTitle extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CardTitle({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post? post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    if (post != null) {
      return Text(
        post!.title,
        style: Theme.of(context).textTheme.titleLarge,
      );
    }

    return const Align(
      alignment: Alignment.centerLeft,
      child: Skeleton(
        width: 200.0,
        height: 24.0,
        radius: 4.0,
      ),
    );
  }
}

class _CardSubTitle extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CardSubTitle({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post? post;

  // -------------------------------- PROPERTIES -------------------------------
  String get _postBody {
    final body = post!.body;
    final cut = post!.body.substring(0, body.indexOf(RegExp('\n')));
    return cut.length < body.length ? '$cut...' : cut;
  }

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    if (post != null) {
      return Text(
        _postBody,
        style: Theme.of(context).textTheme.bodyText2,
      );
    }

    return const Align(
      alignment: Alignment.centerLeft,
      child: Skeleton(
        width: 400.0,
        height: 16.0,
        radius: 2.0,
      ),
    );
  }
}

class _CardAuthor extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CardAuthor({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post? post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final state = context.read<PostListPageState>();
    if (post != null) {
      return Text(
        state.users[post!.userId]!.name,
        style: Theme.of(context).textTheme.caption,
      );
    }

    return const Align(
      alignment: Alignment.centerLeft,
      child: Skeleton(
        width: 100.0,
        height: 14.0,
        radius: 2.0,
      ),
    );
  }
}
