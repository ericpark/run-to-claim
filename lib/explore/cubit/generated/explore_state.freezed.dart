// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExploreState _$ExploreStateFromJson(Map<String, dynamic> json) {
  return _ExploreState.fromJson(json);
}

/// @nodoc
mixin _$ExploreState {
  MapStatus get mapStatus => throw _privateConstructorUsedError;
  LatLng get currentPosition => throw _privateConstructorUsedError;
  Set<LatLng> get pastPositions => throw _privateConstructorUsedError;
  AlignOnUpdate get alignPositionOnUpdate => throw _privateConstructorUsedError;
  @_Uint8ListConverter()
  Uint8List? get fogImageData => throw _privateConstructorUsedError;
  @_ImageConverterPlaceholder()
  ui.Image? get fogImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExploreStateCopyWith<ExploreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreStateCopyWith<$Res> {
  factory $ExploreStateCopyWith(
          ExploreState value, $Res Function(ExploreState) then) =
      _$ExploreStateCopyWithImpl<$Res, ExploreState>;
  @useResult
  $Res call(
      {MapStatus mapStatus,
      LatLng currentPosition,
      Set<LatLng> pastPositions,
      AlignOnUpdate alignPositionOnUpdate,
      @_Uint8ListConverter() Uint8List? fogImageData,
      @_ImageConverterPlaceholder() ui.Image? fogImage});
}

/// @nodoc
class _$ExploreStateCopyWithImpl<$Res, $Val extends ExploreState>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapStatus = null,
    Object? currentPosition = null,
    Object? pastPositions = null,
    Object? alignPositionOnUpdate = null,
    Object? fogImageData = freezed,
    Object? fogImage = freezed,
  }) {
    return _then(_value.copyWith(
      mapStatus: null == mapStatus
          ? _value.mapStatus
          : mapStatus // ignore: cast_nullable_to_non_nullable
              as MapStatus,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as LatLng,
      pastPositions: null == pastPositions
          ? _value.pastPositions
          : pastPositions // ignore: cast_nullable_to_non_nullable
              as Set<LatLng>,
      alignPositionOnUpdate: null == alignPositionOnUpdate
          ? _value.alignPositionOnUpdate
          : alignPositionOnUpdate // ignore: cast_nullable_to_non_nullable
              as AlignOnUpdate,
      fogImageData: freezed == fogImageData
          ? _value.fogImageData
          : fogImageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      fogImage: freezed == fogImage
          ? _value.fogImage
          : fogImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExploreStateImplCopyWith<$Res>
    implements $ExploreStateCopyWith<$Res> {
  factory _$$ExploreStateImplCopyWith(
          _$ExploreStateImpl value, $Res Function(_$ExploreStateImpl) then) =
      __$$ExploreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MapStatus mapStatus,
      LatLng currentPosition,
      Set<LatLng> pastPositions,
      AlignOnUpdate alignPositionOnUpdate,
      @_Uint8ListConverter() Uint8List? fogImageData,
      @_ImageConverterPlaceholder() ui.Image? fogImage});
}

/// @nodoc
class __$$ExploreStateImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreStateImpl>
    implements _$$ExploreStateImplCopyWith<$Res> {
  __$$ExploreStateImplCopyWithImpl(
      _$ExploreStateImpl _value, $Res Function(_$ExploreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapStatus = null,
    Object? currentPosition = null,
    Object? pastPositions = null,
    Object? alignPositionOnUpdate = null,
    Object? fogImageData = freezed,
    Object? fogImage = freezed,
  }) {
    return _then(_$ExploreStateImpl(
      mapStatus: null == mapStatus
          ? _value.mapStatus
          : mapStatus // ignore: cast_nullable_to_non_nullable
              as MapStatus,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as LatLng,
      pastPositions: null == pastPositions
          ? _value._pastPositions
          : pastPositions // ignore: cast_nullable_to_non_nullable
              as Set<LatLng>,
      alignPositionOnUpdate: null == alignPositionOnUpdate
          ? _value.alignPositionOnUpdate
          : alignPositionOnUpdate // ignore: cast_nullable_to_non_nullable
              as AlignOnUpdate,
      fogImageData: freezed == fogImageData
          ? _value.fogImageData
          : fogImageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      fogImage: freezed == fogImage
          ? _value.fogImage
          : fogImage // ignore: cast_nullable_to_non_nullable
              as ui.Image?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExploreStateImpl implements _ExploreState {
  _$ExploreStateImpl(
      {this.mapStatus = MapStatus.initial,
      this.currentPosition = const LatLng(40.7128, -74.0060),
      final Set<LatLng> pastPositions = const {},
      this.alignPositionOnUpdate = AlignOnUpdate.once,
      @_Uint8ListConverter() this.fogImageData,
      @_ImageConverterPlaceholder() this.fogImage = null})
      : _pastPositions = pastPositions;

  factory _$ExploreStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExploreStateImplFromJson(json);

  @override
  @JsonKey()
  final MapStatus mapStatus;
  @override
  @JsonKey()
  final LatLng currentPosition;
  final Set<LatLng> _pastPositions;
  @override
  @JsonKey()
  Set<LatLng> get pastPositions {
    if (_pastPositions is EqualUnmodifiableSetView) return _pastPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pastPositions);
  }

  @override
  @JsonKey()
  final AlignOnUpdate alignPositionOnUpdate;
  @override
  @_Uint8ListConverter()
  final Uint8List? fogImageData;
  @override
  @JsonKey()
  @_ImageConverterPlaceholder()
  final ui.Image? fogImage;

  @override
  String toString() {
    return 'ExploreState(mapStatus: $mapStatus, currentPosition: $currentPosition, pastPositions: $pastPositions, alignPositionOnUpdate: $alignPositionOnUpdate, fogImageData: $fogImageData, fogImage: $fogImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreStateImpl &&
            (identical(other.mapStatus, mapStatus) ||
                other.mapStatus == mapStatus) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            const DeepCollectionEquality()
                .equals(other._pastPositions, _pastPositions) &&
            (identical(other.alignPositionOnUpdate, alignPositionOnUpdate) ||
                other.alignPositionOnUpdate == alignPositionOnUpdate) &&
            const DeepCollectionEquality()
                .equals(other.fogImageData, fogImageData) &&
            (identical(other.fogImage, fogImage) ||
                other.fogImage == fogImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mapStatus,
      currentPosition,
      const DeepCollectionEquality().hash(_pastPositions),
      alignPositionOnUpdate,
      const DeepCollectionEquality().hash(fogImageData),
      fogImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreStateImplCopyWith<_$ExploreStateImpl> get copyWith =>
      __$$ExploreStateImplCopyWithImpl<_$ExploreStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExploreStateImplToJson(
      this,
    );
  }
}

abstract class _ExploreState implements ExploreState {
  factory _ExploreState(
          {final MapStatus mapStatus,
          final LatLng currentPosition,
          final Set<LatLng> pastPositions,
          final AlignOnUpdate alignPositionOnUpdate,
          @_Uint8ListConverter() final Uint8List? fogImageData,
          @_ImageConverterPlaceholder() final ui.Image? fogImage}) =
      _$ExploreStateImpl;

  factory _ExploreState.fromJson(Map<String, dynamic> json) =
      _$ExploreStateImpl.fromJson;

  @override
  MapStatus get mapStatus;
  @override
  LatLng get currentPosition;
  @override
  Set<LatLng> get pastPositions;
  @override
  AlignOnUpdate get alignPositionOnUpdate;
  @override
  @_Uint8ListConverter()
  Uint8List? get fogImageData;
  @override
  @_ImageConverterPlaceholder()
  ui.Image? get fogImage;
  @override
  @JsonKey(ignore: true)
  _$$ExploreStateImplCopyWith<_$ExploreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
