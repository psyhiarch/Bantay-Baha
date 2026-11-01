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

 String get stationId; String get stationName; double get latitude; double get longitude; String get geohash; double get rain10m; double get rain1h; double get rain24h; double get waterLevel; double get waterLevelDelta1h; String get waterRiskLevel; String get rainRiskLevel; String get riskLevel; DateTime get lastUpdated;
/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationCopyWith<Station> get copyWith => _$StationCopyWithImpl<Station>(this as Station, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Station;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Station&&(identical(other.stationId, _this.stationId) || other.stationId == _this.stationId)&&(identical(other.stationName, _this.stationName) || other.stationName == _this.stationName)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.geohash, _this.geohash) || other.geohash == _this.geohash)&&(identical(other.rain10m, _this.rain10m) || other.rain10m == _this.rain10m)&&(identical(other.rain1h, _this.rain1h) || other.rain1h == _this.rain1h)&&(identical(other.rain24h, _this.rain24h) || other.rain24h == _this.rain24h)&&(identical(other.waterLevel, _this.waterLevel) || other.waterLevel == _this.waterLevel)&&(identical(other.waterLevelDelta1h, _this.waterLevelDelta1h) || other.waterLevelDelta1h == _this.waterLevelDelta1h)&&(identical(other.waterRiskLevel, _this.waterRiskLevel) || other.waterRiskLevel == _this.waterRiskLevel)&&(identical(other.rainRiskLevel, _this.rainRiskLevel) || other.rainRiskLevel == _this.rainRiskLevel)&&(identical(other.riskLevel, _this.riskLevel) || other.riskLevel == _this.riskLevel)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated));
}


@override
int get hashCode {
  final _this = this as Station;
  return Object.hash(runtimeType,_this.stationId,_this.stationName,_this.latitude,_this.longitude,_this.geohash,_this.rain10m,_this.rain1h,_this.rain24h,_this.waterLevel,_this.waterLevelDelta1h,_this.waterRiskLevel,_this.rainRiskLevel,_this.riskLevel,_this.lastUpdated);
}

@override
String toString() {
  final _this = this as Station;
  return 'Station(stationId: ${_this.stationId}, stationName: ${_this.stationName}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, geohash: ${_this.geohash}, rain10m: ${_this.rain10m}, rain1h: ${_this.rain1h}, rain24h: ${_this.rain24h}, waterLevel: ${_this.waterLevel}, waterLevelDelta1h: ${_this.waterLevelDelta1h}, waterRiskLevel: ${_this.waterRiskLevel}, rainRiskLevel: ${_this.rainRiskLevel}, riskLevel: ${_this.riskLevel}, lastUpdated: ${_this.lastUpdated})';
}


}

/// @nodoc
abstract mixin class $StationCopyWith<$Res>  {
  factory $StationCopyWith(Station value, $Res Function(Station) _then) = _$StationCopyWithImpl;
@useResult
$Res call({
 String stationId, String stationName, double latitude, double longitude, String geohash, double rain10m, double rain1h, double rain24h, double waterLevel, double waterLevelDelta1h, String waterRiskLevel, String rainRiskLevel, String riskLevel, DateTime lastUpdated
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
@pragma('vm:prefer-inline') @override $Res call({Object? stationId = null,Object? stationName = null,Object? latitude = null,Object? longitude = null,Object? geohash = null,Object? rain10m = null,Object? rain1h = null,Object? rain24h = null,Object? waterLevel = null,Object? waterLevelDelta1h = null,Object? waterRiskLevel = null,Object? rainRiskLevel = null,Object? riskLevel = null,Object? lastUpdated = null,}) {
  return _then(Station(
stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,geohash: null == geohash ? _self.geohash : geohash // ignore: cast_nullable_to_non_nullable
as String,rain10m: null == rain10m ? _self.rain10m : rain10m // ignore: cast_nullable_to_non_nullable
as double,rain1h: null == rain1h ? _self.rain1h : rain1h // ignore: cast_nullable_to_non_nullable
as double,rain24h: null == rain24h ? _self.rain24h : rain24h // ignore: cast_nullable_to_non_nullable
as double,waterLevel: null == waterLevel ? _self.waterLevel : waterLevel // ignore: cast_nullable_to_non_nullable
as double,waterLevelDelta1h: null == waterLevelDelta1h ? _self.waterLevelDelta1h : waterLevelDelta1h // ignore: cast_nullable_to_non_nullable
as double,waterRiskLevel: null == waterRiskLevel ? _self.waterRiskLevel : waterRiskLevel // ignore: cast_nullable_to_non_nullable
as String,rainRiskLevel: null == rainRiskLevel ? _self.rainRiskLevel : rainRiskLevel // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stationId,  String stationName,  double latitude,  double longitude,  String geohash,  double rain10m,  double rain1h,  double rain24h,  double waterLevel,  double waterLevelDelta1h,  String waterRiskLevel,  String rainRiskLevel,  String riskLevel,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Station() when $default != null:
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.geohash,_that.rain10m,_that.rain1h,_that.rain24h,_that.waterLevel,_that.waterLevelDelta1h,_that.waterRiskLevel,_that.rainRiskLevel,_that.riskLevel,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stationId,  String stationName,  double latitude,  double longitude,  String geohash,  double rain10m,  double rain1h,  double rain24h,  double waterLevel,  double waterLevelDelta1h,  String waterRiskLevel,  String rainRiskLevel,  String riskLevel,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _Station():
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.geohash,_that.rain10m,_that.rain1h,_that.rain24h,_that.waterLevel,_that.waterLevelDelta1h,_that.waterRiskLevel,_that.rainRiskLevel,_that.riskLevel,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stationId,  String stationName,  double latitude,  double longitude,  String geohash,  double rain10m,  double rain1h,  double rain24h,  double waterLevel,  double waterLevelDelta1h,  String waterRiskLevel,  String rainRiskLevel,  String riskLevel,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _Station() when $default != null:
return $default(_that.stationId,_that.stationName,_that.latitude,_that.longitude,_that.geohash,_that.rain10m,_that.rain1h,_that.rain24h,_that.waterLevel,_that.waterLevelDelta1h,_that.waterRiskLevel,_that.rainRiskLevel,_that.riskLevel,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _Station implements Station {
  const _Station({required this.stationId, required this.stationName, required this.latitude, required this.longitude, required this.geohash, required this.rain10m, required this.rain1h, required this.rain24h, required this.waterLevel, required this.waterLevelDelta1h, required this.waterRiskLevel, required this.rainRiskLevel, required this.riskLevel, required this.lastUpdated});
  

@override final  String stationId;
@override final  String stationName;
@override final  double latitude;
@override final  double longitude;
@override final  String geohash;
@override final  double rain10m;
@override final  double rain1h;
@override final  double rain24h;
@override final  double waterLevel;
@override final  double waterLevelDelta1h;
@override final  String waterRiskLevel;
@override final  String rainRiskLevel;
@override final  String riskLevel;
@override final  DateTime lastUpdated;

/// Create a copy of Station
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationCopyWith<_Station> get copyWith => __$StationCopyWithImpl<_Station>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Station&&(identical(other.stationId, stationId) || other.stationId == stationId)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.geohash, geohash) || other.geohash == geohash)&&(identical(other.rain10m, rain10m) || other.rain10m == rain10m)&&(identical(other.rain1h, rain1h) || other.rain1h == rain1h)&&(identical(other.rain24h, rain24h) || other.rain24h == rain24h)&&(identical(other.waterLevel, waterLevel) || other.waterLevel == waterLevel)&&(identical(other.waterLevelDelta1h, waterLevelDelta1h) || other.waterLevelDelta1h == waterLevelDelta1h)&&(identical(other.waterRiskLevel, waterRiskLevel) || other.waterRiskLevel == waterRiskLevel)&&(identical(other.rainRiskLevel, rainRiskLevel) || other.rainRiskLevel == rainRiskLevel)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode {
    return Object.hash(runtimeType,stationId,stationName,latitude,longitude,geohash,rain10m,rain1h,rain24h,waterLevel,waterLevelDelta1h,waterRiskLevel,rainRiskLevel,riskLevel,lastUpdated);
}

@override
String toString() {
    return 'Station(stationId: $stationId, stationName: $stationName, latitude: $latitude, longitude: $longitude, geohash: $geohash, rain10m: $rain10m, rain1h: $rain1h, rain24h: $rain24h, waterLevel: $waterLevel, waterLevelDelta1h: $waterLevelDelta1h, waterRiskLevel: $waterRiskLevel, rainRiskLevel: $rainRiskLevel, riskLevel: $riskLevel, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$StationCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$StationCopyWith(_Station value, $Res Function(_Station) _then) = __$StationCopyWithImpl;
@override @useResult
$Res call({
 String stationId, String stationName, double latitude, double longitude, String geohash, double rain10m, double rain1h, double rain24h, double waterLevel, double waterLevelDelta1h, String waterRiskLevel, String rainRiskLevel, String riskLevel, DateTime lastUpdated
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
@override @pragma('vm:prefer-inline') $Res call({Object? stationId = null,Object? stationName = null,Object? latitude = null,Object? longitude = null,Object? geohash = null,Object? rain10m = null,Object? rain1h = null,Object? rain24h = null,Object? waterLevel = null,Object? waterLevelDelta1h = null,Object? waterRiskLevel = null,Object? rainRiskLevel = null,Object? riskLevel = null,Object? lastUpdated = null,}) {
  return _then(_Station(
stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,geohash: null == geohash ? _self.geohash : geohash // ignore: cast_nullable_to_non_nullable
as String,rain10m: null == rain10m ? _self.rain10m : rain10m // ignore: cast_nullable_to_non_nullable
as double,rain1h: null == rain1h ? _self.rain1h : rain1h // ignore: cast_nullable_to_non_nullable
as double,rain24h: null == rain24h ? _self.rain24h : rain24h // ignore: cast_nullable_to_non_nullable
as double,waterLevel: null == waterLevel ? _self.waterLevel : waterLevel // ignore: cast_nullable_to_non_nullable
as double,waterLevelDelta1h: null == waterLevelDelta1h ? _self.waterLevelDelta1h : waterLevelDelta1h // ignore: cast_nullable_to_non_nullable
as double,waterRiskLevel: null == waterRiskLevel ? _self.waterRiskLevel : waterRiskLevel // ignore: cast_nullable_to_non_nullable
as String,rainRiskLevel: null == rainRiskLevel ? _self.rainRiskLevel : rainRiskLevel // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
