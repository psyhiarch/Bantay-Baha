// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Station {

 String get stationId; String get stationName; double get latitude; double get longitude; double get rain10min; double get rain1h; double get rain3h; double get rain24h; double get waterLevel; String get riskLevel; double get temperatureC; double get heatIndexC; double get humidityPercent;
/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationCopyWith<Station> get copyWith => _$StationCopyWithImpl<Station>(this as Station, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Station;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Station&&(identical(other.stationId, _this.stationId) || other.stationId == _this.stationId)&&(identical(other.stationName, _this.stationName) || other.stationName == _this.stationName)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.rain10min, _this.rain10min) || other.rain10min == _this.rain10min)&&(identical(other.rain1h, _this.rain1h) || other.rain1h == _this.rain1h)&&(identical(other.rain3h, _this.rain3h) || other.rain3h == _this.rain3h)&&(identical(other.rain24h, _this.rain24h) || other.rain24h == _this.rain24h)&&(identical(other.waterLevel, _this.waterLevel) || other.waterLevel == _this.waterLevel)&&(identical(other.riskLevel, _this.riskLevel) || other.riskLevel == _this.riskLevel)&&(identical(other.temperatureC, _this.temperatureC) || other.temperatureC == _this.temperatureC)&&(identical(other.heatIndexC, _this.heatIndexC) || other.heatIndexC == _this.heatIndexC)&&(identical(other.humidityPercent, _this.humidityPercent) || other.humidityPercent == _this.humidityPercent));
}


@override
int get hashCode {
  final _this = this as Station;
  return Object.hash(runtimeType,_this.stationId,_this.stationName,_this.latitude,_this.longitude,_this.rain10min,_this.rain1h,_this.rain3h,_this.rain24h,_this.waterLevel,_this.riskLevel,_this.temperatureC,_this.heatIndexC,_this.humidityPercent);
}

@override
String toString() {
  final _this = this as Station;
  return 'Station(stationId: ${_this.stationId}, stationName: ${_this.stationName}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, rain10min: ${_this.rain10min}, rain1h: ${_this.rain1h}, rain3h: ${_this.rain3h}, rain24h: ${_this.rain24h}, waterLevel: ${_this.waterLevel}, riskLevel: ${_this.riskLevel}, temperatureC: ${_this.temperatureC}, heatIndexC: ${_this.heatIndexC}, humidityPercent: ${_this.humidityPercent})';
}


}

/// @nodoc
abstract mixin class $StationCopyWith<$Res>  {
  factory $StationCopyWith(Station value, $Res Function(Station) _then) = _$StationCopyWithImpl;
@useResult
$Res call({
 String stationId, String stationName, double latitude, double longitude, double rain10min, double rain1h, double rain3h, double rain24h, double waterLevel, String riskLevel, double temperatureC, double heatIndexC, double humidityPercent
});




}
/// @nodoc
class _$StationCopyWithImpl<$Res>
    implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._self, this._then);

  final Station _self;
  final $Res Function(Station) _then;

/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationId = null,Object? stationName = null,Object? latitude = null,Object? longitude = null,Object? rain10min = null,Object? rain1h = null,Object? rain3h = null,Object? rain24h = null,Object? waterLevel = null,Object? riskLevel = null,Object? temperatureC = null,Object? heatIndexC = null,Object? humidityPercent = null,}) {
  return _then(Station(
stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rain10min: null == rain10min ? _self.rain10min : rain10min // ignore: cast_nullable_to_non_nullable
as double,rain1h: null == rain1h ? _self.rain1h : rain1h // ignore: cast_nullable_to_non_nullable
as double,rain3h: null == rain3h ? _self.rain3h : rain3h // ignore: cast_nullable_to_non_nullable
as double,rain24h: null == rain24h ? _self.rain24h : rain24h // ignore: cast_nullable_to_non_nullable
as double,waterLevel: null == waterLevel ? _self.waterLevel : waterLevel // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double,heatIndexC: null == heatIndexC ? _self.heatIndexC : heatIndexC // ignore: cast_nullable_to_non_nullable
as double,humidityPercent: null == humidityPercent ? _self.humidityPercent : humidityPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Station].
extension StationPatterns on Station {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Station value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Station() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Station value)  $default,){
final _that = this;
switch (_that) {
case _Station():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Station value)?  $default,){
final _that = this;
switch (_that) {
case _Station() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stationId,  String stationName,  double latitude,  double longitude,  double rain10min,  double rain1h,  double rain3h,  double rain24h,  double waterLevel,  String riskLevel,  double temperatureC,  double heatIndexC,  double humidityPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Station() when $default != null:
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.rain10min,_that.rain1h,_that.rain3h,_that.rain24h,_that.waterLevel,_that.riskLevel,_that.temperatureC,_that.heatIndexC,_that.humidityPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stationId,  String stationName,  double latitude,  double longitude,  double rain10min,  double rain1h,  double rain3h,  double rain24h,  double waterLevel,  String riskLevel,  double temperatureC,  double heatIndexC,  double humidityPercent)  $default,) {final _that = this;
switch (_that) {
case _Station():
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.rain10min,_that.rain1h,_that.rain3h,_that.rain24h,_that.waterLevel,_that.riskLevel,_that.temperatureC,_that.heatIndexC,_that.humidityPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stationId,  String stationName,  double latitude,  double longitude,  double rain10min,  double rain1h,  double rain3h,  double rain24h,  double waterLevel,  String riskLevel,  double temperatureC,  double heatIndexC,  double humidityPercent)?  $default,) {final _that = this;
switch (_that) {
case _Station() when $default != null:
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.rain10min,_that.rain1h,_that.rain3h,_that.rain24h,_that.waterLevel,_that.riskLevel,_that.temperatureC,_that.heatIndexC,_that.humidityPercent);case _:
  return null;

}
}

}

/// @nodoc


class _Station implements Station {
  const _Station({required this.stationId, required this.stationName, required this.latitude, required this.longitude, required this.rain10min, required this.rain1h, required this.rain3h, required this.rain24h, required this.waterLevel, required this.riskLevel, required this.temperatureC, required this.heatIndexC, required this.humidityPercent});
  

@override final  String stationId;
@override final  String stationName;
@override final  double latitude;
@override final  double longitude;
@override final  double rain10min;
@override final  double rain1h;
@override final  double rain3h;
@override final  double rain24h;
@override final  double waterLevel;
@override final  String riskLevel;
@override final  double temperatureC;
@override final  double heatIndexC;
@override final  double humidityPercent;

/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationCopyWith<_Station> get copyWith => __$StationCopyWithImpl<_Station>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Station&&(identical(other.stationId, stationId) || other.stationId == stationId)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.rain10min, rain10min) || other.rain10min == rain10min)&&(identical(other.rain1h, rain1h) || other.rain1h == rain1h)&&(identical(other.rain3h, rain3h) || other.rain3h == rain3h)&&(identical(other.rain24h, rain24h) || other.rain24h == rain24h)&&(identical(other.waterLevel, waterLevel) || other.waterLevel == waterLevel)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.heatIndexC, heatIndexC) || other.heatIndexC == heatIndexC)&&(identical(other.humidityPercent, humidityPercent) || other.humidityPercent == humidityPercent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,stationId,stationName,latitude,longitude,rain10min,rain1h,rain3h,rain24h,waterLevel,riskLevel,temperatureC,heatIndexC,humidityPercent);
}

@override
String toString() {
    return 'Station(stationId: $stationId, stationName: $stationName, latitude: $latitude, longitude: $longitude, rain10min: $rain10min, rain1h: $rain1h, rain3h: $rain3h, rain24h: $rain24h, waterLevel: $waterLevel, riskLevel: $riskLevel, temperatureC: $temperatureC, heatIndexC: $heatIndexC, humidityPercent: $humidityPercent)';
}


}

/// @nodoc
abstract mixin class _$StationCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$StationCopyWith(_Station value, $Res Function(_Station) _then) = __$StationCopyWithImpl;
@override @useResult
$Res call({
 String stationId, String stationName, double latitude, double longitude, double rain10min, double rain1h, double rain3h, double rain24h, double waterLevel, String riskLevel, double temperatureC, double heatIndexC, double humidityPercent
});




}
/// @nodoc
class __$StationCopyWithImpl<$Res>
    implements _$StationCopyWith<$Res> {
  __$StationCopyWithImpl(this._self, this._then);

  final _Station _self;
  final $Res Function(_Station) _then;

/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationId = null,Object? stationName = null,Object? latitude = null,Object? longitude = null,Object? rain10min = null,Object? rain1h = null,Object? rain3h = null,Object? rain24h = null,Object? waterLevel = null,Object? riskLevel = null,Object? temperatureC = null,Object? heatIndexC = null,Object? humidityPercent = null,}) {
  return _then(_Station(
stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rain10min: null == rain10min ? _self.rain10min : rain10min // ignore: cast_nullable_to_non_nullable
as double,rain1h: null == rain1h ? _self.rain1h : rain1h // ignore: cast_nullable_to_non_nullable
as double,rain3h: null == rain3h ? _self.rain3h : rain3h // ignore: cast_nullable_to_non_nullable
as double,rain24h: null == rain24h ? _self.rain24h : rain24h // ignore: cast_nullable_to_non_nullable
as double,waterLevel: null == waterLevel ? _self.waterLevel : waterLevel // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as double,heatIndexC: null == heatIndexC ? _self.heatIndexC : heatIndexC // ignore: cast_nullable_to_non_nullable
as double,humidityPercent: null == humidityPercent ? _self.humidityPercent : humidityPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
