// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Telemetry {

 bool get success; DateTime get scrapedAt; DateTime get cachedAt; Metrics get metrics; List<Station> get stations;
/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryCopyWith<Telemetry> get copyWith => _$TelemetryCopyWithImpl<Telemetry>(this as Telemetry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Telemetry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Telemetry&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.scrapedAt, _this.scrapedAt) || other.scrapedAt == _this.scrapedAt)&&(identical(other.cachedAt, _this.cachedAt) || other.cachedAt == _this.cachedAt)&&(identical(other.metrics, _this.metrics) || other.metrics == _this.metrics)&&const DeepCollectionEquality().equals(other.stations, _this.stations));
}


@override
int get hashCode {
  final _this = this as Telemetry;
  return Object.hash(runtimeType,_this.success,_this.scrapedAt,_this.cachedAt,_this.metrics,const DeepCollectionEquality().hash(_this.stations));
}

@override
String toString() {
  final _this = this as Telemetry;
  return 'Telemetry(success: ${_this.success}, scrapedAt: ${_this.scrapedAt}, cachedAt: ${_this.cachedAt}, metrics: ${_this.metrics}, stations: ${_this.stations})';
}


}

/// @nodoc
abstract mixin class $TelemetryCopyWith<$Res>  {
  factory $TelemetryCopyWith(Telemetry value, $Res Function(Telemetry) _then) = _$TelemetryCopyWithImpl;
@useResult
$Res call({
 bool success, DateTime scrapedAt, DateTime cachedAt, Metrics metrics, List<Station> stations
});


$MetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$TelemetryCopyWithImpl<$Res>
    implements $TelemetryCopyWith<$Res> {
  _$TelemetryCopyWithImpl(this._self, this._then);

  final Telemetry _self;
  final $Res Function(Telemetry) _then;

/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? scrapedAt = null,Object? cachedAt = null,Object? metrics = null,Object? stations = null,}) {
  return _then(Telemetry(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Metrics,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<Station>,
  ));
}
/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricsCopyWith<$Res> get metrics {
  
  return $MetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [Telemetry].
extension TelemetryPatterns on Telemetry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Telemetry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Telemetry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Telemetry value)  $default,){
final _that = this;
switch (_that) {
case _Telemetry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Telemetry value)?  $default,){
final _that = this;
switch (_that) {
case _Telemetry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  DateTime scrapedAt,  DateTime cachedAt,  Metrics metrics,  List<Station> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Telemetry() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  DateTime scrapedAt,  DateTime cachedAt,  Metrics metrics,  List<Station> stations)  $default,) {final _that = this;
switch (_that) {
case _Telemetry():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  DateTime scrapedAt,  DateTime cachedAt,  Metrics metrics,  List<Station> stations)?  $default,) {final _that = this;
switch (_that) {
case _Telemetry() when $default != null:
return $default(_that.success,_that.scrapedAt,_that.cachedAt,_that.metrics,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _Telemetry implements Telemetry {
  const _Telemetry({required this.success, required this.scrapedAt, required this.cachedAt, required this.metrics, required  List<Station> stations}): _stations = stations;
  

@override final  bool success;
@override final  DateTime scrapedAt;
@override final  DateTime cachedAt;
@override final  Metrics metrics;
 final  List<Station> _stations;
@override List<Station> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryCopyWith<_Telemetry> get copyWith => __$TelemetryCopyWithImpl<_Telemetry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Telemetry&&(identical(other.success, success) || other.success == success)&&(identical(other.scrapedAt, scrapedAt) || other.scrapedAt == scrapedAt)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.stations, _stations));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,scrapedAt,cachedAt,metrics,const DeepCollectionEquality().hash(_stations));
}

@override
String toString() {
    return 'Telemetry(success: $success, scrapedAt: $scrapedAt, cachedAt: $cachedAt, metrics: $metrics, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TelemetryCopyWith<$Res> implements $TelemetryCopyWith<$Res> {
  factory _$TelemetryCopyWith(_Telemetry value, $Res Function(_Telemetry) _then) = __$TelemetryCopyWithImpl;
@override @useResult
$Res call({
 bool success, DateTime scrapedAt, DateTime cachedAt, Metrics metrics, List<Station> stations
});


@override $MetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$TelemetryCopyWithImpl<$Res>
    implements _$TelemetryCopyWith<$Res> {
  __$TelemetryCopyWithImpl(this._self, this._then);

  final _Telemetry _self;
  final $Res Function(_Telemetry) _then;

/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? scrapedAt = null,Object? cachedAt = null,Object? metrics = null,Object? stations = null,}) {
  return _then(_Telemetry(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Metrics,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<Station>,
  ));
}

/// Create a copy of Telemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricsCopyWith<$Res> get metrics {
  
  return $MetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}

// dart format on
