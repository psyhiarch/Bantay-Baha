// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TelemetryRaw {

 bool get success; String get scrapedAt; String get cachedAt; Map<String, dynamic> get metrics; List<Map<String, dynamic>> get stations;
/// Create a copy of TelemetryRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryRawCopyWith<TelemetryRaw> get copyWith => _$TelemetryRawCopyWithImpl<TelemetryRaw>(this as TelemetryRaw, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TelemetryRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryRaw&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.scrapedAt, _this.scrapedAt) || other.scrapedAt == _this.scrapedAt)&&(identical(other.cachedAt, _this.cachedAt) || other.cachedAt == _this.cachedAt)&&const DeepCollectionEquality().equals(other.metrics, _this.metrics)&&const DeepCollectionEquality().equals(other.stations, _this.stations));
}


@override
int get hashCode {
  final _this = this as TelemetryRaw;
  return Object.hash(runtimeType,_this.success,_this.scrapedAt,_this.cachedAt,const DeepCollectionEquality().hash(_this.metrics),const DeepCollectionEquality().hash(_this.stations));
}

@override
String toString() {
  final _this = this as TelemetryRaw;
  return 'TelemetryRaw(success: ${_this.success}, scrapedAt: ${_this.scrapedAt}, cachedAt: ${_this.cachedAt}, metrics: ${_this.metrics}, stations: ${_this.stations})';
}


}

/// @nodoc
abstract mixin class $TelemetryRawCopyWith<$Res>  {
  factory $TelemetryRawCopyWith(TelemetryRaw value, $Res Function(TelemetryRaw) _then) = _$TelemetryRawCopyWithImpl;
@useResult
$Res call({
 bool success, String scrapedAt, String cachedAt, Map<String, dynamic> metrics, List<Map<String, dynamic>> stations
});




}
/// @nodoc
class _$TelemetryRawCopyWithImpl<$Res>
    implements $TelemetryRawCopyWith<$Res> {
  _$TelemetryRawCopyWithImpl(this._self, this._then);

  final TelemetryRaw _self;
  final $Res Function(TelemetryRaw) _then;

/// Create a copy of TelemetryRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? scrapedAt = null,Object? cachedAt = null,Object? metrics = null,Object? stations = null,}) {
  return _then(TelemetryRaw(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [TelemetryRaw].
extension TelemetryRawPatterns on TelemetryRaw {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryRaw() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryRaw value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryRaw():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryRaw value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryRaw() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String scrapedAt,  String cachedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryRaw() when $default != null:
return $default(_that.success,_that.scrapedAt,_that.cachedAt,_that.metrics,_that.stations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String scrapedAt,  String cachedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations)  $default,) {final _that = this;
switch (_that) {
case _TelemetryRaw():
return $default(_that.success,_that.scrapedAt,_that.cachedAt,_that.metrics,_that.stations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String scrapedAt,  String cachedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryRaw() when $default != null:
return $default(_that.success,_that.scrapedAt,_that.cachedAt,_that.metrics,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _TelemetryRaw implements TelemetryRaw {
  const _TelemetryRaw({required this.success, required this.scrapedAt, required this.cachedAt, required  Map<String, dynamic> metrics, required  List<Map<String, dynamic>> stations}): _metrics = metrics,_stations = stations;
  

@override final  bool success;
@override final  String scrapedAt;
@override final  String cachedAt;
 final  Map<String, dynamic> _metrics;
@override Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

 final  List<Map<String, dynamic>> _stations;
@override List<Map<String, dynamic>> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of TelemetryRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryRawCopyWith<_TelemetryRaw> get copyWith => __$TelemetryRawCopyWithImpl<_TelemetryRaw>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryRaw&&(identical(other.success, success) || other.success == success)&&(identical(other.scrapedAt, scrapedAt) || other.scrapedAt == scrapedAt)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&const DeepCollectionEquality().equals(other.metrics, _metrics)&&const DeepCollectionEquality().equals(other.stations, _stations));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,scrapedAt,cachedAt,const DeepCollectionEquality().hash(_metrics),const DeepCollectionEquality().hash(_stations));
}

@override
String toString() {
    return 'TelemetryRaw(success: $success, scrapedAt: $scrapedAt, cachedAt: $cachedAt, metrics: $metrics, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TelemetryRawCopyWith<$Res> implements $TelemetryRawCopyWith<$Res> {
  factory _$TelemetryRawCopyWith(_TelemetryRaw value, $Res Function(_TelemetryRaw) _then) = __$TelemetryRawCopyWithImpl;
@override @useResult
$Res call({
 bool success, String scrapedAt, String cachedAt, Map<String, dynamic> metrics, List<Map<String, dynamic>> stations
});




}
/// @nodoc
class __$TelemetryRawCopyWithImpl<$Res>
    implements _$TelemetryRawCopyWith<$Res> {
  __$TelemetryRawCopyWithImpl(this._self, this._then);

  final _TelemetryRaw _self;
  final $Res Function(_TelemetryRaw) _then;

/// Create a copy of TelemetryRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? scrapedAt = null,Object? cachedAt = null,Object? metrics = null,Object? stations = null,}) {
  return _then(_TelemetryRaw(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
