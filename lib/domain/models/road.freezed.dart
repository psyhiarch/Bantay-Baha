// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'road.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Road {

 String get id; String get name; String get riskLevel; double get depthCm; bool get isFlooded; String get severity; String get passability;
/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadCopyWith<Road> get copyWith => _$RoadCopyWithImpl<Road>(this as Road, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Road;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Road&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.riskLevel, _this.riskLevel) || other.riskLevel == _this.riskLevel)&&(identical(other.depthCm, _this.depthCm) || other.depthCm == _this.depthCm)&&(identical(other.isFlooded, _this.isFlooded) || other.isFlooded == _this.isFlooded)&&(identical(other.severity, _this.severity) || other.severity == _this.severity)&&(identical(other.passability, _this.passability) || other.passability == _this.passability));
}


@override
int get hashCode {
  final _this = this as Road;
  return Object.hash(runtimeType,_this.id,_this.name,_this.riskLevel,_this.depthCm,_this.isFlooded,_this.severity,_this.passability);
}

@override
String toString() {
  final _this = this as Road;
  return 'Road(id: ${_this.id}, name: ${_this.name}, riskLevel: ${_this.riskLevel}, depthCm: ${_this.depthCm}, isFlooded: ${_this.isFlooded}, severity: ${_this.severity}, passability: ${_this.passability})';
}


}

/// @nodoc
abstract mixin class $RoadCopyWith<$Res>  {
  factory $RoadCopyWith(Road value, $Res Function(Road) _then) = _$RoadCopyWithImpl;
@useResult
$Res call({
 String id, String name, String riskLevel, double depthCm, bool isFlooded, String severity, String passability
});




}
/// @nodoc
class _$RoadCopyWithImpl<$Res>
    implements $RoadCopyWith<$Res> {
  _$RoadCopyWithImpl(this._self, this._then);

  final Road _self;
  final $Res Function(Road) _then;

/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? riskLevel = null,Object? depthCm = null,Object? isFlooded = null,Object? severity = null,Object? passability = null,}) {
  return _then(Road(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,depthCm: null == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Road].
extension RoadPatterns on Road {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Road value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Road() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Road value)  $default,){
final _that = this;
switch (_that) {
case _Road():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Road value)?  $default,){
final _that = this;
switch (_that) {
case _Road() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String riskLevel,  double depthCm,  bool isFlooded,  String severity,  String passability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Road() when $default != null:
return $default(_that.id,_that.name,_that.riskLevel,_that.depthCm,_that.isFlooded,_that.severity,_that.passability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String riskLevel,  double depthCm,  bool isFlooded,  String severity,  String passability)  $default,) {final _that = this;
switch (_that) {
case _Road():
return $default(_that.id,_that.name,_that.riskLevel,_that.depthCm,_that.isFlooded,_that.severity,_that.passability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String riskLevel,  double depthCm,  bool isFlooded,  String severity,  String passability)?  $default,) {final _that = this;
switch (_that) {
case _Road() when $default != null:
return $default(_that.id,_that.name,_that.riskLevel,_that.depthCm,_that.isFlooded,_that.severity,_that.passability);case _:
  return null;

}
}

}

/// @nodoc


class _Road implements Road {
  const _Road({required this.id, required this.name, required this.riskLevel, required this.depthCm, required this.isFlooded, required this.severity, required this.passability});
  

@override final  String id;
@override final  String name;
@override final  String riskLevel;
@override final  double depthCm;
@override final  bool isFlooded;
@override final  String severity;
@override final  String passability;

/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadCopyWith<_Road> get copyWith => __$RoadCopyWithImpl<_Road>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Road&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.isFlooded, isFlooded) || other.isFlooded == isFlooded)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.passability, passability) || other.passability == passability));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,riskLevel,depthCm,isFlooded,severity,passability);
}

@override
String toString() {
    return 'Road(id: $id, name: $name, riskLevel: $riskLevel, depthCm: $depthCm, isFlooded: $isFlooded, severity: $severity, passability: $passability)';
}


}

/// @nodoc
abstract mixin class _$RoadCopyWith<$Res> implements $RoadCopyWith<$Res> {
  factory _$RoadCopyWith(_Road value, $Res Function(_Road) _then) = __$RoadCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String riskLevel, double depthCm, bool isFlooded, String severity, String passability
});




}
/// @nodoc
class __$RoadCopyWithImpl<$Res>
    implements _$RoadCopyWith<$Res> {
  __$RoadCopyWithImpl(this._self, this._then);

  final _Road _self;
  final $Res Function(_Road) _then;

/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? riskLevel = null,Object? depthCm = null,Object? isFlooded = null,Object? severity = null,Object? passability = null,}) {
  return _then(_Road(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,depthCm: null == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
