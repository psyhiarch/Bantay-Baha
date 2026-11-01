// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coordinates_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoordinatesRaw {

 double get lat; double get lng;
/// Create a copy of CoordinatesRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordinatesRawCopyWith<CoordinatesRaw> get copyWith => _$CoordinatesRawCopyWithImpl<CoordinatesRaw>(this as CoordinatesRaw, _$identity);

  /// Serializes this CoordinatesRaw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CoordinatesRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoordinatesRaw&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CoordinatesRaw;
  return Object.hash(runtimeType,_this.lat,_this.lng);
}

@override
String toString() {
  final _this = this as CoordinatesRaw;
  return 'CoordinatesRaw(lat: ${_this.lat}, lng: ${_this.lng})';
}


}

/// @nodoc
abstract mixin class $CoordinatesRawCopyWith<$Res>  {
  factory $CoordinatesRawCopyWith(CoordinatesRaw value, $Res Function(CoordinatesRaw) _then) = _$CoordinatesRawCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$CoordinatesRawCopyWithImpl<$Res>
    implements $CoordinatesRawCopyWith<$Res> {
  _$CoordinatesRawCopyWithImpl(this._self, this._then);

  final CoordinatesRaw _self;
  final $Res Function(CoordinatesRaw) _then;

/// Create a copy of CoordinatesRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(CoordinatesRaw(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CoordinatesRaw].
extension CoordinatesRawPatterns on CoordinatesRaw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoordinatesRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoordinatesRaw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoordinatesRaw value)  $default,){
final _that = this;
switch (_that) {
case _CoordinatesRaw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoordinatesRaw value)?  $default,){
final _that = this;
switch (_that) {
case _CoordinatesRaw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoordinatesRaw() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _CoordinatesRaw():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _CoordinatesRaw() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoordinatesRaw implements CoordinatesRaw {
   _CoordinatesRaw({required this.lat, required this.lng});
  factory _CoordinatesRaw.fromJson(Map<String, dynamic> json) => _$CoordinatesRawFromJson(json);

@override final  double lat;
@override final  double lng;

/// Create a copy of CoordinatesRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoordinatesRawCopyWith<_CoordinatesRaw> get copyWith => __$CoordinatesRawCopyWithImpl<_CoordinatesRaw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordinatesRawToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoordinatesRaw&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,lat,lng);
}

@override
String toString() {
    return 'CoordinatesRaw(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$CoordinatesRawCopyWith<$Res> implements $CoordinatesRawCopyWith<$Res> {
  factory _$CoordinatesRawCopyWith(_CoordinatesRaw value, $Res Function(_CoordinatesRaw) _then) = __$CoordinatesRawCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$CoordinatesRawCopyWithImpl<$Res>
    implements _$CoordinatesRawCopyWith<$Res> {
  __$CoordinatesRawCopyWithImpl(this._self, this._then);

  final _CoordinatesRaw _self;
  final $Res Function(_CoordinatesRaw) _then;

/// Create a copy of CoordinatesRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_CoordinatesRaw(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
