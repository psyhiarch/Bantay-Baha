// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Metrics {

 int get totalStations; int get highRiskStationsCount; double get peakWaterLevel; String get peakWaterStation; String get peakWaterStationId; double get maxRain1h; String get maxRain1hStation; String get maxRain1hStationId; double get maxRain24h; String get maxRain24hStation; String get maxRain24hStationId;
/// Create a copy of Metrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetricsCopyWith<Metrics> get copyWith => _$MetricsCopyWithImpl<Metrics>(this as Metrics, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Metrics;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Metrics&&(identical(other.totalStations, _this.totalStations) || other.totalStations == _this.totalStations)&&(identical(other.highRiskStationsCount, _this.highRiskStationsCount) || other.highRiskStationsCount == _this.highRiskStationsCount)&&(identical(other.peakWaterLevel, _this.peakWaterLevel) || other.peakWaterLevel == _this.peakWaterLevel)&&(identical(other.peakWaterStation, _this.peakWaterStation) || other.peakWaterStation == _this.peakWaterStation)&&(identical(other.peakWaterStationId, _this.peakWaterStationId) || other.peakWaterStationId == _this.peakWaterStationId)&&(identical(other.maxRain1h, _this.maxRain1h) || other.maxRain1h == _this.maxRain1h)&&(identical(other.maxRain1hStation, _this.maxRain1hStation) || other.maxRain1hStation == _this.maxRain1hStation)&&(identical(other.maxRain1hStationId, _this.maxRain1hStationId) || other.maxRain1hStationId == _this.maxRain1hStationId)&&(identical(other.maxRain24h, _this.maxRain24h) || other.maxRain24h == _this.maxRain24h)&&(identical(other.maxRain24hStation, _this.maxRain24hStation) || other.maxRain24hStation == _this.maxRain24hStation)&&(identical(other.maxRain24hStationId, _this.maxRain24hStationId) || other.maxRain24hStationId == _this.maxRain24hStationId));
}


@override
int get hashCode {
  final _this = this as Metrics;
  return Object.hash(runtimeType,_this.totalStations,_this.highRiskStationsCount,_this.peakWaterLevel,_this.peakWaterStation,_this.peakWaterStationId,_this.maxRain1h,_this.maxRain1hStation,_this.maxRain1hStationId,_this.maxRain24h,_this.maxRain24hStation,_this.maxRain24hStationId);
}

@override
String toString() {
  final _this = this as Metrics;
  return 'Metrics(totalStations: ${_this.totalStations}, highRiskStationsCount: ${_this.highRiskStationsCount}, peakWaterLevel: ${_this.peakWaterLevel}, peakWaterStation: ${_this.peakWaterStation}, peakWaterStationId: ${_this.peakWaterStationId}, maxRain1h: ${_this.maxRain1h}, maxRain1hStation: ${_this.maxRain1hStation}, maxRain1hStationId: ${_this.maxRain1hStationId}, maxRain24h: ${_this.maxRain24h}, maxRain24hStation: ${_this.maxRain24hStation}, maxRain24hStationId: ${_this.maxRain24hStationId})';
}


}

/// @nodoc
abstract mixin class $MetricsCopyWith<$Res>  {
  factory $MetricsCopyWith(Metrics value, $Res Function(Metrics) _then) = _$MetricsCopyWithImpl;
@useResult
$Res call({
 int totalStations, int highRiskStationsCount, double peakWaterLevel, String peakWaterStation, String peakWaterStationId, double maxRain1h, String maxRain1hStation, String maxRain1hStationId, double maxRain24h, String maxRain24hStation, String maxRain24hStationId
});




}
/// @nodoc
class _$MetricsCopyWithImpl<$Res>
    implements $MetricsCopyWith<$Res> {
  _$MetricsCopyWithImpl(this._self, this._then);

  final Metrics _self;
  final $Res Function(Metrics) _then;

/// Create a copy of Metrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalStations = null,Object? highRiskStationsCount = null,Object? peakWaterLevel = null,Object? peakWaterStation = null,Object? peakWaterStationId = null,Object? maxRain1h = null,Object? maxRain1hStation = null,Object? maxRain1hStationId = null,Object? maxRain24h = null,Object? maxRain24hStation = null,Object? maxRain24hStationId = null,}) {
  return _then(Metrics(
totalStations: null == totalStations ? _self.totalStations : totalStations // ignore: cast_nullable_to_non_nullable
as int,highRiskStationsCount: null == highRiskStationsCount ? _self.highRiskStationsCount : highRiskStationsCount // ignore: cast_nullable_to_non_nullable
as int,peakWaterLevel: null == peakWaterLevel ? _self.peakWaterLevel : peakWaterLevel // ignore: cast_nullable_to_non_nullable
as double,peakWaterStation: null == peakWaterStation ? _self.peakWaterStation : peakWaterStation // ignore: cast_nullable_to_non_nullable
as String,peakWaterStationId: null == peakWaterStationId ? _self.peakWaterStationId : peakWaterStationId // ignore: cast_nullable_to_non_nullable
as String,maxRain1h: null == maxRain1h ? _self.maxRain1h : maxRain1h // ignore: cast_nullable_to_non_nullable
as double,maxRain1hStation: null == maxRain1hStation ? _self.maxRain1hStation : maxRain1hStation // ignore: cast_nullable_to_non_nullable
as String,maxRain1hStationId: null == maxRain1hStationId ? _self.maxRain1hStationId : maxRain1hStationId // ignore: cast_nullable_to_non_nullable
as String,maxRain24h: null == maxRain24h ? _self.maxRain24h : maxRain24h // ignore: cast_nullable_to_non_nullable
as double,maxRain24hStation: null == maxRain24hStation ? _self.maxRain24hStation : maxRain24hStation // ignore: cast_nullable_to_non_nullable
as String,maxRain24hStationId: null == maxRain24hStationId ? _self.maxRain24hStationId : maxRain24hStationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Metrics].
extension MetricsPatterns on Metrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Metrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Metrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Metrics value)  $default,){
final _that = this;
switch (_that) {
case _Metrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Metrics value)?  $default,){
final _that = this;
switch (_that) {
case _Metrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalStations,  int highRiskStationsCount,  double peakWaterLevel,  String peakWaterStation,  String peakWaterStationId,  double maxRain1h,  String maxRain1hStation,  String maxRain1hStationId,  double maxRain24h,  String maxRain24hStation,  String maxRain24hStationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Metrics() when $default != null:
return $default(_that.totalStations,_that.highRiskStationsCount,_that.peakWaterLevel,_that.peakWaterStation,_that.peakWaterStationId,_that.maxRain1h,_that.maxRain1hStation,_that.maxRain1hStationId,_that.maxRain24h,_that.maxRain24hStation,_that.maxRain24hStationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalStations,  int highRiskStationsCount,  double peakWaterLevel,  String peakWaterStation,  String peakWaterStationId,  double maxRain1h,  String maxRain1hStation,  String maxRain1hStationId,  double maxRain24h,  String maxRain24hStation,  String maxRain24hStationId)  $default,) {final _that = this;
switch (_that) {
case _Metrics():
return $default(_that.totalStations,_that.highRiskStationsCount,_that.peakWaterLevel,_that.peakWaterStation,_that.peakWaterStationId,_that.maxRain1h,_that.maxRain1hStation,_that.maxRain1hStationId,_that.maxRain24h,_that.maxRain24hStation,_that.maxRain24hStationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalStations,  int highRiskStationsCount,  double peakWaterLevel,  String peakWaterStation,  String peakWaterStationId,  double maxRain1h,  String maxRain1hStation,  String maxRain1hStationId,  double maxRain24h,  String maxRain24hStation,  String maxRain24hStationId)?  $default,) {final _that = this;
switch (_that) {
case _Metrics() when $default != null:
return $default(_that.totalStations,_that.highRiskStationsCount,_that.peakWaterLevel,_that.peakWaterStation,_that.peakWaterStationId,_that.maxRain1h,_that.maxRain1hStation,_that.maxRain1hStationId,_that.maxRain24h,_that.maxRain24hStation,_that.maxRain24hStationId);case _:
  return null;

}
}

}

/// @nodoc


class _Metrics implements Metrics {
  const _Metrics({required this.totalStations, required this.highRiskStationsCount, required this.peakWaterLevel, required this.peakWaterStation, required this.peakWaterStationId, required this.maxRain1h, required this.maxRain1hStation, required this.maxRain1hStationId, required this.maxRain24h, required this.maxRain24hStation, required this.maxRain24hStationId});
  

@override final  int totalStations;
@override final  int highRiskStationsCount;
@override final  double peakWaterLevel;
@override final  String peakWaterStation;
@override final  String peakWaterStationId;
@override final  double maxRain1h;
@override final  String maxRain1hStation;
@override final  String maxRain1hStationId;
@override final  double maxRain24h;
@override final  String maxRain24hStation;
@override final  String maxRain24hStationId;

/// Create a copy of Metrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetricsCopyWith<_Metrics> get copyWith => __$MetricsCopyWithImpl<_Metrics>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Metrics&&(identical(other.totalStations, totalStations) || other.totalStations == totalStations)&&(identical(other.highRiskStationsCount, highRiskStationsCount) || other.highRiskStationsCount == highRiskStationsCount)&&(identical(other.peakWaterLevel, peakWaterLevel) || other.peakWaterLevel == peakWaterLevel)&&(identical(other.peakWaterStation, peakWaterStation) || other.peakWaterStation == peakWaterStation)&&(identical(other.peakWaterStationId, peakWaterStationId) || other.peakWaterStationId == peakWaterStationId)&&(identical(other.maxRain1h, maxRain1h) || other.maxRain1h == maxRain1h)&&(identical(other.maxRain1hStation, maxRain1hStation) || other.maxRain1hStation == maxRain1hStation)&&(identical(other.maxRain1hStationId, maxRain1hStationId) || other.maxRain1hStationId == maxRain1hStationId)&&(identical(other.maxRain24h, maxRain24h) || other.maxRain24h == maxRain24h)&&(identical(other.maxRain24hStation, maxRain24hStation) || other.maxRain24hStation == maxRain24hStation)&&(identical(other.maxRain24hStationId, maxRain24hStationId) || other.maxRain24hStationId == maxRain24hStationId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalStations,highRiskStationsCount,peakWaterLevel,peakWaterStation,peakWaterStationId,maxRain1h,maxRain1hStation,maxRain1hStationId,maxRain24h,maxRain24hStation,maxRain24hStationId);
}

@override
String toString() {
    return 'Metrics(totalStations: $totalStations, highRiskStationsCount: $highRiskStationsCount, peakWaterLevel: $peakWaterLevel, peakWaterStation: $peakWaterStation, peakWaterStationId: $peakWaterStationId, maxRain1h: $maxRain1h, maxRain1hStation: $maxRain1hStation, maxRain1hStationId: $maxRain1hStationId, maxRain24h: $maxRain24h, maxRain24hStation: $maxRain24hStation, maxRain24hStationId: $maxRain24hStationId)';
}


}

/// @nodoc
abstract mixin class _$MetricsCopyWith<$Res> implements $MetricsCopyWith<$Res> {
  factory _$MetricsCopyWith(_Metrics value, $Res Function(_Metrics) _then) = __$MetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalStations, int highRiskStationsCount, double peakWaterLevel, String peakWaterStation, String peakWaterStationId, double maxRain1h, String maxRain1hStation, String maxRain1hStationId, double maxRain24h, String maxRain24hStation, String maxRain24hStationId
});




}
/// @nodoc
class __$MetricsCopyWithImpl<$Res>
    implements _$MetricsCopyWith<$Res> {
  __$MetricsCopyWithImpl(this._self, this._then);

  final _Metrics _self;
  final $Res Function(_Metrics) _then;

/// Create a copy of Metrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalStations = null,Object? highRiskStationsCount = null,Object? peakWaterLevel = null,Object? peakWaterStation = null,Object? peakWaterStationId = null,Object? maxRain1h = null,Object? maxRain1hStation = null,Object? maxRain1hStationId = null,Object? maxRain24h = null,Object? maxRain24hStation = null,Object? maxRain24hStationId = null,}) {
  return _then(_Metrics(
totalStations: null == totalStations ? _self.totalStations : totalStations // ignore: cast_nullable_to_non_nullable
as int,highRiskStationsCount: null == highRiskStationsCount ? _self.highRiskStationsCount : highRiskStationsCount // ignore: cast_nullable_to_non_nullable
as int,peakWaterLevel: null == peakWaterLevel ? _self.peakWaterLevel : peakWaterLevel // ignore: cast_nullable_to_non_nullable
as double,peakWaterStation: null == peakWaterStation ? _self.peakWaterStation : peakWaterStation // ignore: cast_nullable_to_non_nullable
as String,peakWaterStationId: null == peakWaterStationId ? _self.peakWaterStationId : peakWaterStationId // ignore: cast_nullable_to_non_nullable
as String,maxRain1h: null == maxRain1h ? _self.maxRain1h : maxRain1h // ignore: cast_nullable_to_non_nullable
as double,maxRain1hStation: null == maxRain1hStation ? _self.maxRain1hStation : maxRain1hStation // ignore: cast_nullable_to_non_nullable
as String,maxRain1hStationId: null == maxRain1hStationId ? _self.maxRain1hStationId : maxRain1hStationId // ignore: cast_nullable_to_non_nullable
as String,maxRain24h: null == maxRain24h ? _self.maxRain24h : maxRain24h // ignore: cast_nullable_to_non_nullable
as double,maxRain24hStation: null == maxRain24hStation ? _self.maxRain24hStation : maxRain24hStation // ignore: cast_nullable_to_non_nullable
as String,maxRain24hStationId: null == maxRain24hStationId ? _self.maxRain24hStationId : maxRain24hStationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
