import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

final int __int64MaxValue = double.maxFinite.toInt();

class HighlightedText extends StatelessWidget {
  const HighlightedText({
    this.caseSensitive = false,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.highlightedText,
    this.terms,
    required this.allText,
    this.textAlign = TextAlign.left,
    this.textStyle = const TextStyle(color: aubergine, fontSize: 16, fontWeight: FontWeight.w400),
    this.textStyleHighlight = const TextStyle(color: aubergine, fontSize: 16, fontWeight: FontWeight.w400),
    this.wordDelimiters = ' .,;?!<>[]~`@#\$%^&*()+-=|/_',
    this.words = false,
    this.highlightColor = sunglow,
    Key? key,
  })  : assert(highlightedText != null || terms != null),
        super(key: key);
  final bool caseSensitive;
  final TextOverflow overflow;
  final int? maxLines;
  final String? highlightedText;
  final List<String>? terms;
  final String allText;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final TextStyle textStyleHighlight;
  final String wordDelimiters;
  final bool words;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    final String textLC = caseSensitive ? allText : allText.toLowerCase();
    final List<String> termList = [highlightedText ?? '', ...(terms ?? [])];
    final List<String> termListLC =
        termList.where((s) => s.isNotEmpty).map((s) => caseSensitive ? s : s.toLowerCase()).toList();
    List<InlineSpan> children = [];
    int start = 0;
    int idx = 0;
    while (idx < textLC.length) {
      nonHighlightAdd(int end) => children.add(TextSpan(text: allText.substring(start, end), style: textStyle));
      int iNearest = -1;
      int idxNearest = __int64MaxValue;
      for (int i = 0; i < termListLC.length; i++) {
        int at;
        if ((at = textLC.indexOf(termListLC[i], idx)) >= 0) {
          if (words) {
            if (at > 0 && !wordDelimiters.contains(textLC[at - 1])) {
              continue;
            }
            int followingIdx = at + termListLC[i].length;
            if (followingIdx < textLC.length && !wordDelimiters.contains(textLC[followingIdx])) {
              continue;
            }
          }
          if (at < idxNearest) {
            iNearest = i;
            idxNearest = at;
          }
        }
      }

      if (iNearest >= 0) {
        if (start < idxNearest) {
          nonHighlightAdd(idxNearest);
          start = idxNearest;
        }
        int termLen = termListLC[iNearest].length;
        children.add(
          WidgetSpan(
            child: Container(
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                allText.substring(start, idxNearest + termLen),
                style: textStyleHighlight,
                maxLines: maxLines,
                textAlign: textAlign,
                overflow: overflow,
              ),
            ),
          ),
        );
        start = idx = idxNearest + termLen;
      } else {
        if (words) {
          idx++;
          nonHighlightAdd(idx);
          start = idx;
        } else {
          nonHighlightAdd(textLC.length);
          break;
        }
      }
    }

    return RichText(
        maxLines: maxLines,
        overflow: overflow,
        text: TextSpan(children: children, style: textStyle),
        textAlign: textAlign,
        textScaleFactor: MediaQuery.of(context).textScaleFactor);
  }
}
