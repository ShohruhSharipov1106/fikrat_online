import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/assets/constants/app_constants.dart';

part 'deep_link_event.dart';

part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  static const dlStream = EventChannel('io.commeta.hissa/events');

  static const platform = MethodChannel('io.commeta.hissa/channel');

  final StreamController<String> _stateController = StreamController();

  Stream<String> get dlState => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  DeepLinkBloc() : super(DeepLinkInitial()) {
    startUri().then(_onRedirected);
    dlStream.receiveBroadcastStream().listen((d) => _onRedirected(d));
    on<DeepLinkChanged>((event, emit) {
      emit(DeepLinkInitial());
      String? parsedSlug;
      if (event.uri.contains(AppConstants.BASE_SHARE_URL)) {
        parsedSlug = event.uri.replaceAll(AppConstants.BASE_SHARE_URL, '');
        final List<String> pathParams = parsedSlug.split('/');
        emit(DeepLinkTriggeredState(
            link: pathParams.last, type: pathParams.first));
        // if (pathParams.first == 'course') {
        //   emit(CourseLinkTriggered(int.tryParse(pathParams[1]) ?? 0));
        // } else if (pathParams.first == 'webinar') {
        //   emit(WebinarLinkTriggered(int.tryParse(pathParams[1]) ?? 0));
        // } else if (pathParams.first == 'news') {
        //   emit(NewsLinkTriggered(int.tryParse(pathParams[1]) ?? 0));
        // } else if (pathParams.first == 'events') {
        //   emit(EventsLinkTriggered(int.tryParse(pathParams[1]) ?? 0));
        // } else if (pathParams.first == 'poll') {
        //   emit(PollLinkTriggered(int.tryParse(pathParams[1]) ?? 0));
        // }
      } else if (event.uri.contains(AppConstants.BASE_SHARE_REDIRECT_URL)) {
        parsedSlug =
            event.uri.replaceAll(AppConstants.BASE_SHARE_REDIRECT_URL, '');
        final List<String> pathParams = parsedSlug.split('/');
        emit(DeepLinkTriggeredState(
            link: pathParams.last, type: pathParams.first));
      }
    });
  }

  void _onRedirected(String uri) {
    add(DeepLinkChanged(uri: uri));
    stateSink.add(uri);
  }

  Future<String> startUri() async {
    try {
      final link = await platform.invokeMethod('initialLink');
      add(DeepLinkChanged(uri: link));
      return link;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  void dispose() {
    _stateController.close();
  }
}
