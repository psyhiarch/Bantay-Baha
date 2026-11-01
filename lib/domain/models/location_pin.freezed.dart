// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationPin {

 String get id; String get road; String get landmark; Coordinates get coordinates; String get depthCategory; String get passability; dynamic get severity;
/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationPinCopyWith<LocationPin> get copyWith => _$LocationPinCopyWithImpl<LocationPin>(this as LocationPin, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationPin;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPin&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.road, _this.road) || other.road == _this.road)&&(identical(other.landmark, _this.landmark) || other.landmark == _this.landmark)&&(identical(other.coordinates, _this.coordinates) || other.coordinates == _this.coordinates)&&(identical(other.depthCategory, _this.depthCategory) || other.depthCategory == _this.depthCategory)&&(identical(other.passability, _this.passability) || other.passability == _this.passability)&&const DeepCollectionEquality().equals(other.severity, _this.severity));
}


@override
int get hashCode {
  final _this = this as LocationPin;
  return Object.hash(runtimeType,_this.id,_this.road,_this.landmark,_this.coordinates,_this.depthCategory,_this.passability,const DeepCollectionEquality().hash(_this.severity));
}

@override
String toString() {
  final _this = this as LocationPin;
  return 'LocationPin(id: ${_this.id}, road: ${_this.road}, landmark: ${_this.landmark}, coordinates: ${_this.coordinates}, depthCategory: ${_this.depthCategory}, passability: ${_this.passability}, severity: ${_this.severity})';
}


}

/// @nodoc
abstract mixin class $LocationPinCopyWith<$Res>  {
  factory $LocationPinCopyWith(LocationPin value, $Res Function(LocationPin) _then) = _$LocationPinCopyWithImpl;
@useResult
$Res call({
 String id, String road, String landmark, Coordinates coordinates, String depthCategory, String passability, dynamic severity
});


$CoordinatesCopyWith<$Res> get coordinates;

}
/// @nodoc
class _$LocationPinCopyWithImpl<$Res>
    implements $LocationPinCopyWith<$Res> {
  _$LocationPinCopyWithImpl(this._self, this._then);

  final LocationPin _self;
  final $Res Function(LocationPin) _then;

/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? road = null,Object? landmark = null,Object? coordinates = null,Object? depthCategory = null,Object? passability = null,Object? severity = freezed,}) {
  return _then(LocationPin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,road: null == road ? _self.road : road // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinates,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinatesCopyWith<$Res> get coordinates {
  
  return $CoordinatesCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationPin].
extension LocationPinPatterns on LocationPin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationPin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationPin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationPin value)  $default,){
final _that = this;
switch (_that) {
case _LocationPin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationPin value)?  $default,){
final _that = this;
switch (_that) {
case _LocationPin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String road,  String landmark,  Coordinates coordinates,  String depthCategory,  String passability,  dynamic severity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationPin() when $default != null:
return $default(_that.id,_that.road,_that.landmark,_that.coordinates,_that.depthCategory,_that.passability,_that.severity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String road,  String landmark,  Coordinates coordinates,  String depthCategory,  String passability,  dynamic severity)  $default,) {final _that = this;
switch (_that) {
case _LocationPin():
return $default(_that.id,_that.road,_that.landmark,_that.coordinates,_that.depthCategory,_that.passability,_that.severity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String road,  String landmark,  Coordinates coordinates,  String depthCategory,  String passability,  dynamic severity)?  $default,) {final _that = this;
switch (_that) {
case _LocationPin() when $default != null:
return $default(_that.id,_that.road,_that.landmark,_that.coordinates,_that.depthCategory,_that.passability,_that.severity);case _:
  return null;

}
}

}

/// @nodoc


class _LocationPin implements LocationPin {
  const _LocationPin({required this.id, required this.road, required this.landmark, required this.coordinates, required this.depthCategory, required this.passability, required this.severity});
  

@override final  String id;
@override final  String road;
@override final  String landmark;
@override final  Coordinates coordinates;
@override final  String depthCategory;
@override final  String passability;
@override final  dynamic severity;

/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationPinCopyWith<_LocationPin> get copyWith => __$LocationPinCopyWithImpl<_LocationPin>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationPin&&(identical(other.id, id) || other.id == id)&&(identical(other.road, road) || other.road == road)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.depthCategory, depthCategory) || other.depthCategory == depthCategory)&&(identical(other.passability, passability) || other.passability == passability)&&const DeepCollectionEquality().equals(other.severity, severity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,road,landmark,coordinates,depthCategory,passability,const DeepCollectionEquality().hash(severity));
}

@override
String toString() {
    return 'LocationPin(id: $id, road: $road, landmark: $landmark, coordinates: $coordinates, depthCategory: $depthCategory, passability: $passability, severity: $severity)';
}


}

/// @nodoc
abstract mixin class _$LocationPinCopyWith<$Res> implements $LocationPinCopyWith<$Res> {
  factory _$LocationPinCopyWith(_LocationPin value, $Res Function(_LocationPin) _then) = __$LocationPinCopyWithImpl;
@override @useResult
$Res call({
 String id, String road, String landmark, Coordinates coordinates, String depthCategory, String passability, dynamic severity
});


@override $CoordinatesCopyWith<$Res> get coordinates;

}
/// @nodoc
class __$LocationPinCopyWithImpl<$Res>
    implements _$LocationPinCopyWith<$Res> {
  __$LocationPinCopyWithImpl(this._self, this._then);

  final _LocationPin _self;
  final $Res Function(_LocationPin) _then;

/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? road = null,Object? landmark = null,Object? coordinates = null,Object? depthCategory = null,Object? passability = null,Object? severity = freezed,}) {
  return _then(_LocationPin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,road: null == road ? _self.road : road // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinates,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of LocationPin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinatesCopyWith<$Res> get coordinates {
  
  return $CoordinatesCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}

// dart format on
