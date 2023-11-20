import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class SliverPaginator extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final EdgeInsetsGeometry? padding;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final Widget? fetchMoreWidget;
  final bool useLoadingForError;
  final bool useLoadingForBuilder;
  final bool addAutomaticKeepAlives;

  const SliverPaginator(
      {required this.paginatorStatus,
      required this.itemBuilder,
      required this.itemCount,
      required this.fetchMoreFunction,
      required this.hasMoreToFetch,
      this.padding,
      this.errorWidget,
      this.emptyWidget,
      this.loadingWidget,
      this.useLoadingForError = true,
      this.useLoadingForBuilder = false,
      this.addAutomaticKeepAlives = true,
      this.fetchMoreWidget,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.success ||
        (useLoadingForBuilder && paginatorStatus == FormzSubmissionStatus.inProgress)) {
      if (itemCount == 0) {
        return SliverToBoxAdapter(child: emptyWidget ?? const SizedBox());
      } else {
        return SliverPadding(
          padding: padding ?? const EdgeInsets.all(0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == itemCount) {
                  if (hasMoreToFetch) {
                    if (fetchMoreWidget != null) {
                      return fetchMoreWidget;
                    } else {
                      fetchMoreFunction();
                      return const Center(child: CupertinoActivityIndicator());
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return itemBuilder(context, index);
              },
              childCount: itemCount + 1,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
            ),
          ),
        );
      }
    } else {
      if (useLoadingForError) {
        return SliverToBoxAdapter(child: loadingWidget ?? const Center(child: CircularProgressIndicator.adaptive()));
      } else {
        if (paginatorStatus == FormzSubmissionStatus.inProgress) {
          return SliverToBoxAdapter(child: loadingWidget ?? const Center(child: CupertinoActivityIndicator()));
        } else if (paginatorStatus == FormzSubmissionStatus.failure) {
          return SliverToBoxAdapter(child: errorWidget ?? const Center(child: Text('Something went wrong!')));
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      }
    }
  }
}
