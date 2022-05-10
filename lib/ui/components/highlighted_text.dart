import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const HighlightedText({
    required this.text,
    required this.textToHighlight,
    this.style,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final String text;
  final String textToHighlight;
  final TextStyle? style;

  // -------------------------------- PROPERTIES -------------------------------
  List<String> get _tokenisedTexts {
    final matches = RegExp(
      textToHighlight,
      caseSensitive: false,
    ).allMatches(text).toList();
    if (matches.isEmpty) {
      return [text];
    }

    final texts = <String>[];

    final firstMatch = matches.first;
    texts.add(text.substring(0, firstMatch.start));

    for (var i = 0; i < matches.length; i++) {
      final match = matches[i];
      texts.add(text.substring(match.start, match.end));

      final nextMatch = i < matches.length - 1 ? matches[i + 1] : null;
      if (nextMatch != null) {
        texts.add(text.substring(match.end, nextMatch.start));
      }
    }

    if (matches.length < 2) {
      if (firstMatch.end != text.length) {
        texts.add(text.substring(firstMatch.end));
      }
      return texts;
    }

    final lastMatch = matches.last;
    if (lastMatch.end != text.length) {
      texts.add(text.substring(lastMatch.end));
    }

    return texts;
  }

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final texts = _tokenisedTexts;
    return Text.rich(
      TextSpan(
        children: [
          for (var i = 0; i < texts.length; i++)
            if (i % 2 == 0)
              TextSpan(text: texts[i])
            else
              TextSpan(
                text: texts[i],
                style: style?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
        ],
      ),
      style: style,
    );
  }
}
