import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

class Paginator extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget? errorWidget;
  final EdgeInsets? padding;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Axis scrollDirection;
  final Widget? loadingWidget;
  final ScrollPhysics physics;
  final ScrollController? scrollController;
  final VoidCallback? onRefresh;
  final double? height;
  final Widget? fetchMoreWidget;
  final bool notificationPredicate;
  final bool useLoadingForError;
  final bool useLoadingForBuilder;

  const Paginator({
    required this.paginatorStatus,
    required this.itemBuilder,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    this.onRefresh,
    this.errorWidget,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.separatorBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.scrollController,
    this.physics = const BouncingScrollPhysics(),
    this.height,
    this.useLoadingForError = true,
    this.useLoadingForBuilder = false,
    this.fetchMoreWidget,
    this.notificationPredicate = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.success ||
        (useLoadingForBuilder && paginatorStatus == FormzSubmissionStatus.inProgress)) {
      if (itemCount == 0) {
        return emptyWidget ?? const SizedBox();
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            if (onRefresh != null) {
              onRefresh!();
            }
            return Future.delayed(const Duration(milliseconds: 500));
          },
          color: mainColor,
          backgroundColor: whiteSmoke,
          notificationPredicate: (notification) => notificationPredicate,
          child: SizedBox(
            height: height,
            child: ListView.separated(
              scrollDirection: scrollDirection,
              controller: scrollController,
              physics: physics,
              padding: padding,
              itemBuilder: (context, index) {
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
              separatorBuilder: separatorBuilder ?? (context, index) => const SizedBox.shrink(),
              itemCount: itemCount + 1,
              shrinkWrap: true,
            ),
          ),
        );
      }
    } else {
      if (useLoadingForError) {
        return loadingWidget ?? const Center(child: CircularProgressIndicator.adaptive());
      } else {
        if (paginatorStatus == FormzSubmissionStatus.inProgress) {
          return loadingWidget ?? const Center(child: CupertinoActivityIndicator());
        } else if (paginatorStatus == FormzSubmissionStatus.failure) {
          return errorWidget ?? const Center(child: Text('Something went wrong!'));
        } else {
          return const SizedBox();
        }
      }
    }
  }
}
