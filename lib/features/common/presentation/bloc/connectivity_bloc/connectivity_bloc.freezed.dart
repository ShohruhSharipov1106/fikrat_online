// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConnectivityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setup,
    required TResult Function(bool status) changeStatus,
    required TResult Function(VoidCallback? onSuccess) checkConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setup,
    TResult? Function(bool status)? changeStatus,
    TResult? Function(VoidCallback? onSuccess)? checkConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setup,
    TResult Function(bool status)? changeStatus,
    TResult Function(VoidCallback? onSuccess)? checkConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Setup value) setup,
    required TResult Function(_ChangeStatus value) changeStatus,
    required TResult Function(_CheckConnection value) checkConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Setup value)? setup,
    TResult? Function(_ChangeStatus value)? changeStatus,
    TResult? Function(_CheckConnection value)? checkConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Setup value)? setup,
    TResult Function(_ChangeStatus value)? changeStatus,
    TResult Function(_CheckConnection value)? checkConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectivityEventCopyWith<$Res> {
  factory $ConnectivityEventCopyWith(
          ConnectivityEvent value, $Res Function(ConnectivityEvent) then) =
      _$ConnectivityEventCopyWithImpl<$Res, ConnectivityEvent>;
}

/// @nodoc
class _$ConnectivityEventCopyWithImpl<$Res, $Val extends ConnectivityEvent>
    implements $ConnectivityEventCopyWith<$Res> {
  _$ConnectivityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SetupCopyWith<$Res> {
  factory _$$_SetupCopyWith(_$_Setup value, $Res Function(_$_Setup) then) =
      __$$_SetupCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SetupCopyWithImpl<$Res>
    extends _$ConnectivityEventCopyWithImpl<$Res, _$_Setup>
    implements _$$_SetupCopyWith<$Res> {
  __$$_SetupCopyWithImpl(_$_Setup _value, $Res Function(_$_Setup) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Setup implements _Setup {
  const _$_Setup();

  @override
  String toString() {
    return 'ConnectivityEvent.setup()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Setup);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setup,
    required TResult Function(bool status) changeStatus,
    required TResult Function(VoidCallback? onSuccess) checkConnection,
  }) {
    return setup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setup,
    TResult? Function(bool status)? changeStatus,
    TResult? Function(VoidCallback? onSuccess)? checkConnection,
  }) {
    return setup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setup,
    TResult Function(bool status)? changeStatus,
    TResult Function(VoidCallback? onSuccess)? checkConnection,
    required TResult orElse(),
  }) {
    if (setup != null) {
      return setup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Setup value) setup,
    required TResult Function(_ChangeStatus value) changeStatus,
    required TResult Function(_CheckConnection value) checkConnection,
  }) {
    return setup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Setup value)? setup,
    TResult? Function(_ChangeStatus value)? changeStatus,
    TResult? Function(_CheckConnection value)? checkConnection,
  }) {
    return setup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Setup value)? setup,
    TResult Function(_ChangeStatus value)? changeStatus,
    TResult Function(_CheckConnection value)? checkConnection,
    required TResult orElse(),
  }) {
    if (setup != null) {
      return setup(this);
    }
    return orElse();
  }
}

abstract class _Setup implements ConnectivityEvent {
  const factory _Setup() = _$_Setup;
}

/// @nodoc
abstract class _$$_ChangeStatusCopyWith<$Res> {
  factory _$$_ChangeStatusCopyWith(
          _$_ChangeStatus value, $Res Function(_$_ChangeStatus) then) =
      __$$_ChangeStatusCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$_ChangeStatusCopyWithImpl<$Res>
    extends _$ConnectivityEventCopyWithImpl<$Res, _$_ChangeStatus>
    implements _$$_ChangeStatusCopyWith<$Res> {
  __$$_ChangeStatusCopyWithImpl(
      _$_ChangeStatus _value, $Res Function(_$_ChangeStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$_ChangeStatus(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChangeStatus implements _ChangeStatus {
  const _$_ChangeStatus(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'ConnectivityEvent.changeStatus(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeStatus &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeStatusCopyWith<_$_ChangeStatus> get copyWith =>
      __$$_ChangeStatusCopyWithImpl<_$_ChangeStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setup,
    required TResult Function(bool status) changeStatus,
    required TResult Function(VoidCallback? onSuccess) checkConnection,
  }) {
    return changeStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setup,
    TResult? Function(bool status)? changeStatus,
    TResult? Function(VoidCallback? onSuccess)? checkConnection,
  }) {
    return changeStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setup,
    TResult Function(bool status)? changeStatus,
    TResult Function(VoidCallback? onSuccess)? checkConnection,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Setup value) setup,
    required TResult Function(_ChangeStatus value) changeStatus,
    required TResult Function(_CheckConnection value) checkConnection,
  }) {
    return changeStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Setup value)? setup,
    TResult? Function(_ChangeStatus value)? changeStatus,
    TResult? Function(_CheckConnection value)? checkConnection,
  }) {
    return changeStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Setup value)? setup,
    TResult Function(_ChangeStatus value)? changeStatus,
    TResult Function(_CheckConnection value)? checkConnection,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(this);
    }
    return orElse();
  }
}

abstract class _ChangeStatus implements ConnectivityEvent {
  const factory _ChangeStatus(final bool status) = _$_ChangeStatus;

  bool get status;
  @JsonKey(ignore: true)
  _$$_ChangeStatusCopyWith<_$_ChangeStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CheckConnectionCopyWith<$Res> {
  factory _$$_CheckConnectionCopyWith(
          _$_CheckConnection value, $Res Function(_$_CheckConnection) then) =
      __$$_CheckConnectionCopyWithImpl<$Res>;
  @useResult
  $Res call({VoidCallback? onSuccess});
}

/// @nodoc
class __$$_CheckConnectionCopyWithImpl<$Res>
    extends _$ConnectivityEventCopyWithImpl<$Res, _$_CheckConnection>
    implements _$$_CheckConnectionCopyWith<$Res> {
  __$$_CheckConnectionCopyWithImpl(
      _$_CheckConnection _value, $Res Function(_$_CheckConnection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onSuccess = freezed,
  }) {
    return _then(_$_CheckConnection(
      onSuccess: freezed == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc

class _$_CheckConnection implements _CheckConnection {
  const _$_CheckConnection({this.onSuccess});

  @override
  final VoidCallback? onSuccess;

  @override
  String toString() {
    return 'ConnectivityEvent.checkConnection(onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckConnection &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onSuccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheckConnectionCopyWith<_$_CheckConnection> get copyWith =>
      __$$_CheckConnectionCopyWithImpl<_$_CheckConnection>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() setup,
    required TResult Function(bool status) changeStatus,
    required TResult Function(VoidCallback? onSuccess) checkConnection,
  }) {
    return checkConnection(onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? setup,
    TResult? Function(bool status)? changeStatus,
    TResult? Function(VoidCallback? onSuccess)? checkConnection,
  }) {
    return checkConnection?.call(onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? setup,
    TResult Function(bool status)? changeStatus,
    TResult Function(VoidCallback? onSuccess)? checkConnection,
    required TResult orElse(),
  }) {
    if (checkConnection != null) {
      return checkConnection(onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Setup value) setup,
    required TResult Function(_ChangeStatus value) changeStatus,
    required TResult Function(_CheckConnection value) checkConnection,
  }) {
    return checkConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Setup value)? setup,
    TResult? Function(_ChangeStatus value)? changeStatus,
    TResult? Function(_CheckConnection value)? checkConnection,
  }) {
    return checkConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Setup value)? setup,
    TResult Function(_ChangeStatus value)? changeStatus,
    TResult Function(_CheckConnection value)? checkConnection,
    required TResult orElse(),
  }) {
    if (checkConnection != null) {
      return checkConnection(this);
    }
    return orElse();
  }
}

abstract class _CheckConnection implements ConnectivityEvent {
  const factory _CheckConnection({final VoidCallback? onSuccess}) =
      _$_CheckConnection;

  VoidCallback? get onSuccess;
  @JsonKey(ignore: true)
  _$$_CheckConnectionCopyWith<_$_CheckConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConnectivityState {
  bool get connected => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConnectivityStateCopyWith<ConnectivityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectivityStateCopyWith<$Res> {
  factory $ConnectivityStateCopyWith(
          ConnectivityState value, $Res Function(ConnectivityState) then) =
      _$ConnectivityStateCopyWithImpl<$Res, ConnectivityState>;
  @useResult
  $Res call({bool connected, FormzSubmissionStatus status});
}

/// @nodoc
class _$ConnectivityStateCopyWithImpl<$Res, $Val extends ConnectivityState>
    implements $ConnectivityStateCopyWith<$Res> {
  _$ConnectivityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConnectivityStateCopyWith<$Res>
    implements $ConnectivityStateCopyWith<$Res> {
  factory _$$_ConnectivityStateCopyWith(_$_ConnectivityState value,
          $Res Function(_$_ConnectivityState) then) =
      __$$_ConnectivityStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool connected, FormzSubmissionStatus status});
}

/// @nodoc
class __$$_ConnectivityStateCopyWithImpl<$Res>
    extends _$ConnectivityStateCopyWithImpl<$Res, _$_ConnectivityState>
    implements _$$_ConnectivityStateCopyWith<$Res> {
  __$$_ConnectivityStateCopyWithImpl(
      _$_ConnectivityState _value, $Res Function(_$_ConnectivityState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? status = null,
  }) {
    return _then(_$_ConnectivityState(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ));
  }
}

/// @nodoc

class _$_ConnectivityState implements _ConnectivityState {
  const _$_ConnectivityState(
      {this.connected = false, this.status = FormzSubmissionStatus.initial});

  @override
  @JsonKey()
  final bool connected;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;

  @override
  String toString() {
    return 'ConnectivityState(connected: $connected, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectivityState &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connected, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConnectivityStateCopyWith<_$_ConnectivityState> get copyWith =>
      __$$_ConnectivityStateCopyWithImpl<_$_ConnectivityState>(
          this, _$identity);
}

abstract class _ConnectivityState implements ConnectivityState {
  const factory _ConnectivityState(
      {final bool connected,
      final FormzSubmissionStatus status}) = _$_ConnectivityState;

  @override
  bool get connected;
  @override
  FormzSubmissionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectivityStateCopyWith<_$_ConnectivityState> get copyWith =>
      throw _privateConstructorUsedError;
}
