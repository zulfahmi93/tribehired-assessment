import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../components/components.dart';
import 'state.dart';

class PostDetailsPage extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const PostDetailsPage({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailsPageState(post: post),
      child: Scaffold(body: _Content(post: post)),
    );
  }
}

class _Content extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Content({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 48.0),
      children: [
        const SizedBox(height: 32.0),
        _Header(post: post),
        const SizedBox(height: 32.0),
        _PostImage(post: post),
        const SizedBox(height: 32.0),
        _PostTitle(post: post),
        const SizedBox(height: 32.0),
        _PostBody(post: post),
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'comments',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 32.0),
        const _CommentSearchBox(),
        const SizedBox(height: 32.0),
        const _CommentList(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Header({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: BackButton(),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _PostImage({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Hero(
        tag: post.id,
        child: Container(
          height: 300.0,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/600/300'),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(6.0, 6.0),
                blurRadius: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostTitle extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _PostTitle({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        post.title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _PostBody({
    required this.post,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Post post;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        post.body,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _CommentSearchBox extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CommentSearchBox({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  State<_CommentSearchBox> createState() => _CommentSearchBoxState();
}

class _CommentSearchBoxState extends State<_CommentSearchBox>
    with AutomaticKeepAliveClientMixin {
  // -------------------------------- PROPERTIES -------------------------------
  @override
  bool get wantKeepAlive => true;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = context.watch<PostDetailsPageState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'search comments...',
        ),
        onChanged: (t) => state.search(query: t),
      ),
    );
  }
}

class _CommentList extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CommentList({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  State<_CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<_CommentList>
    with AutomaticKeepAliveClientMixin {
  // -------------------------------- PROPERTIES -------------------------------
  @override
  bool get wantKeepAlive => true;

  // --------------------------------- METHODS ---------------------------------
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      context.read<PostDetailsPageState>().initialise();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<PostDetailsPageState>(
      builder: (context, state, _) {
        if (state.isBusy) {
          return const CircularProgressIndicator();
        }

        if (state.isError) {
          return const Error();
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            bottom: 48.0,
          ),
          itemCount: state.filteredComments.length,
          itemBuilder: (context, i) => _Comment(
            comment: state.filteredComments[i],
          ),
        );
      },
    );
  }
}

class _Comment extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Comment({
    required this.comment,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Comment comment;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CommentAuthorImage(),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CommentAuthor(comment: comment),
                const SizedBox(height: 16.0),
                _CommentText(comment: comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentAuthorImage extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CommentAuthorImage({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/200',
      width: 32.0,
      height: 32.0,
    );
  }
}

class _CommentAuthor extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CommentAuthor({
    required this.comment,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Comment comment;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostDetailsPageState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HighlightedText(
          text: comment.name,
          textToHighlight: state.searchQuery,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        HighlightedText(
          text: comment.email,
          textToHighlight: state.searchQuery,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _CommentText extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _CommentText({
    required this.comment,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final Comment comment;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostDetailsPageState>();
    return HighlightedText(
      text: comment.body,
      textToHighlight: state.searchQuery,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
