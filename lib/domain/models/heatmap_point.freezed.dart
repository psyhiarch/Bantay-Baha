// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heatmap_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeatmapPoint {

 double get lat; double get lng; double get intensity; double get depthCm; String get category; double get radius; bool get isFlooded;
/// Create a copy of HeatmapPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeatmapPointCopyWith<HeatmapPoint> get copyWith => _$HeatmapPointCopyWithImpl<HeatmapPoint>(this as HeatmapPoint, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HeatmapPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeatmapPoint&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.intensity, _this.intensity) || other.intensity == _this.intensity)&&(identical(other.depthCm, _this.depthCm) || other.depthCm == _this.depthCm)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.radius, _this.radius) || other.radius == _this.radius)&&(identical(other.isFlooded, _this.isFlooded) || other.isFlooded == _this.isFlooded));
}


@override
int get hashCode {
  final _this = this as HeatmapPoint;
  return Object.hash(runtimeType,_this.lat,_this.lng,_this.intensity,_this.depthCm,_this.category,_this.radius,_this.isFlooded);
}

@override
String toString() {
  final _this = this as HeatmapPoint;
  return 'HeatmapPoint(lat: ${_this.lat}, lng: ${_this.lng}, intensity: ${_this.intensity}, depthCm: ${_this.depthCm}, category: ${_this.category}, radius: ${_this.radius}, isFlooded: ${_this.isFlooded})';
}


}

/// @nodoc
abstract mixin class $HeatmapPointCopyWith<$Res>  {
  factory $HeatmapPointCopyWith(HeatmapPoint value, $Res Function(HeatmapPoint) _then) = _$HeatmapPointCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, double intensity, double depthCm, String category, double radius, bool isFlooded
});




}
/// @nodoc
class _$HeatmapPointCopyWithImpl<$Res>
    implements $HeatmapPointCopyWith<$Res> {
  _$HeatmapPointCopyWithImpl(this._self, this._then);

  final HeatmapPoint _self;
  final $Res Function(HeatmapPoint) _then;

/// Create a copy of HeatmapPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,Object? intensity = null,Object? depthCm = null,Object? category = null,Object? radius = null,Object? isFlooded = null,}) {
  return _then(HeatmapPoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,depthCm: null == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HeatmapPoint].
extension HeatmapPointPatterns on HeatmapPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeatmapPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeatmapPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeatmapPoint value)  $default,){
final _that = this;
switch (_that) {
case _HeatmapPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeatmapPoint value)?  $default,){
final _that = this;
switch (_that) {
case _HeatmapPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng,  double intensity,  double depthCm,  String category,  double radius,  bool isFlooded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeatmapPoint() when $default != null:
return $default(_that.lat,_that.lng,_that.intensity,_that.depthCm,_that.category,_that.radius,_that.isFlooded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng,  double intensity,  double depthCm,  String category,  double radius,  bool isFlooded)  $default,) {final _that = this;
switch (_that) {
case _HeatmapPoint():
return $default(_that.lat,_that.lng,_that.intensity,_that.depthCm,_that.category,_that.radius,_that.isFlooded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng,  double intensity,  double depthCm,  String category,  double radius,  bool isFlooded)?  $default,) {final _that = this;
switch (_that) {
case _HeatmapPoint() when $default != null:
return $default(_that.lat,_that.lng,_that.intensity,_that.depthCm,_that.category,_that.radius,_that.isFlooded);case _:
  return null;

}
}

}

/// @nodoc


class _HeatmapPoint implements HeatmapPoint {
  const _HeatmapPoint({required this.lat, required this.lng, required this.intensity, required this.depthCm, required this.category, required this.radius, required this.isFlooded});
  

@override final  double lat;
@override final  double lng;
@override final  double intensity;
@override final  double depthCm;
@override final  String category;
@override final  double radius;
@override final  bool isFlooded;

/// Create a copy of HeatmapPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeatmapPointCopyWith<_HeatmapPoint> get copyWith => __$HeatmapPointCopyWithImpl<_HeatmapPoint>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeatmapPoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.category, category) || other.category == category)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.isFlooded, isFlooded) || other.isFlooded == isFlooded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,lat,lng,intensity,depthCm,category,radius,isFlooded);
}

@override
String toString() {
    return 'HeatmapPoint(lat: $lat, lng: $lng, intensity: $intensity, depthCm: $depthCm, category: $category, radius: $radius, isFlooded: $isFlooded)';
}


}

/// @nodoc
abstract mixin class _$HeatmapPointCopyWith<$Res> implements $HeatmapPointCopyWith<$Res> {
  factory _$HeatmapPointCopyWith(_HeatmapPoint value, $Res Function(_HeatmapPoint) _then) = __$HeatmapPointCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng, double intensity, double depthCm, String category, double radius, bool isFlooded
});




}
/// @nodoc
class __$HeatmapPointCopyWithImpl<$Res>
    implements _$HeatmapPointCopyWith<$Res> {
  __$HeatmapPointCopyWithImpl(this._self, this._then);

  final _HeatmapPoint _self;
  final $Res Function(_HeatmapPoint) _then;

/// Create a copy of HeatmapPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? intensity = null,Object? depthCm = null,Object? category = null,Object? radius = null,Object? isFlooded = null,}) {
  return _then(_HeatmapPoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,depthCm: null == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
