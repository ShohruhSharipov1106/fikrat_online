import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/features/common/presentation/widgets/bottom_sheet_header.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({required this.url, required this.title, Key? key})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            BottomSheetHeader(title: widget.title, hasArrowLeft: false),
            const Divider(color: tabGrey, thickness: 1, height: 1),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    onWebViewCreated: (controller) async {
                      _controller = controller;
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true),
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptEnabled: true,
                      ),
                    ),
                    gestureRecognizers: Set()
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(widget.url),
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedCrossFade(
                      firstChild: const Offstage(offstage: true),
                      secondChild: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                      crossFadeState: _isLoading
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
