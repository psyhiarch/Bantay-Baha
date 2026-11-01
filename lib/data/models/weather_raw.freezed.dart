// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherRaw {

 double get metroManilaRainMmHr; double get metroManilaRain24hMm; double get forecast3hTotalMm; String get trend; String get conditionLabel;
/// Create a copy of WeatherRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherRawCopyWith<WeatherRaw> get copyWith => _$WeatherRawCopyWithImpl<WeatherRaw>(this as WeatherRaw, _$identity);

  /// Serializes this WeatherRaw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WeatherRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherRaw&&(identical(other.metroManilaRainMmHr, _this.metroManilaRainMmHr) || other.metroManilaRainMmHr == _this.metroManilaRainMmHr)&&(identical(other.metroManilaRain24hMm, _this.metroManilaRain24hMm) || other.metroManilaRain24hMm == _this.metroManilaRain24hMm)&&(identical(other.forecast3hTotalMm, _this.forecast3hTotalMm) || other.forecast3hTotalMm == _this.forecast3hTotalMm)&&(identical(other.trend, _this.trend) || other.trend == _this.trend)&&(identical(other.conditionLabel, _this.conditionLabel) || other.conditionLabel == _this.conditionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeatherRaw;
  return Object.hash(runtimeType,_this.metroManilaRainMmHr,_this.metroManilaRain24hMm,_this.forecast3hTotalMm,_this.trend,_this.conditionLabel);
}

@override
String toString() {
  final _this = this as WeatherRaw;
  return 'WeatherRaw(metroManilaRainMmHr: ${_this.metroManilaRainMmHr}, metroManilaRain24hMm: ${_this.metroManilaRain24hMm}, forecast3hTotalMm: ${_this.forecast3hTotalMm}, trend: ${_this.trend}, conditionLabel: ${_this.conditionLabel})';
}


}

/// @nodoc
abstract mixin class $WeatherRawCopyWith<$Res>  {
  factory $WeatherRawCopyWith(WeatherRaw value, $Res Function(WeatherRaw) _then) = _$WeatherRawCopyWithImpl;
@useResult
$Res call({
 double metroManilaRainMmHr, double metroManilaRain24hMm, double forecast3hTotalMm, String trend, String conditionLabel
});




}
/// @nodoc
class _$WeatherRawCopyWithImpl<$Res>
    implements $WeatherRawCopyWith<$Res> {
  _$WeatherRawCopyWithImpl(this._self, this._then);

  final WeatherRaw _self;
  final $Res Function(WeatherRaw) _then;

/// Create a copy of WeatherRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metroManilaRainMmHr = null,Object? metroManilaRain24hMm = null,Object? forecast3hTotalMm = null,Object? trend = null,Object? conditionLabel = null,}) {
  return _then(WeatherRaw(
metroManilaRainMmHr: null == metroManilaRainMmHr ? _self.metroManilaRainMmHr : metroManilaRainMmHr // ignore: cast_nullable_to_non_nullable
as double,metroManilaRain24hMm: null == metroManilaRain24hMm ? _self.metroManilaRain24hMm : metroManilaRain24hMm // ignore: cast_nullable_to_non_nullable
as double,forecast3hTotalMm: null == forecast3hTotalMm ? _self.forecast3hTotalMm : forecast3hTotalMm // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,conditionLabel: null == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherRaw].
extension WeatherRawPatterns on WeatherRaw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherRaw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherRaw value)  $default,){
final _that = this;
switch (_that) {
case _WeatherRaw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherRaw value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherRaw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double metroManilaRainMmHr,  double metroManilaRain24hMm,  double forecast3hTotalMm,  String trend,  String conditionLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherRaw() when $default != null:
return $default(_that.metroManilaRainMmHr,_that.metroManilaRain24hMm,_that.forecast3hTotalMm,_that.trend,_that.conditionLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double metroManilaRainMmHr,  double metroManilaRain24hMm,  double forecast3hTotalMm,  String trend,  String conditionLabel)  $default,) {final _that = this;
switch (_that) {
case _WeatherRaw():
return $default(_that.metroManilaRainMmHr,_that.metroManilaRain24hMm,_that.forecast3hTotalMm,_that.trend,_that.conditionLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double metroManilaRainMmHr,  double metroManilaRain24hMm,  double forecast3hTotalMm,  String trend,  String conditionLabel)?  $default,) {final _that = this;
switch (_that) {
case _WeatherRaw() when $default != null:
return $default(_that.metroManilaRainMmHr,_that.metroManilaRain24hMm,_that.forecast3hTotalMm,_that.trend,_that.conditionLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherRaw implements WeatherRaw {
  const _WeatherRaw({required this.metroManilaRainMmHr, required this.metroManilaRain24hMm, required this.forecast3hTotalMm, required this.trend, required this.conditionLabel});
  factory _WeatherRaw.fromJson(Map<String, dynamic> json) => _$WeatherRawFromJson(json);

@override final  double metroManilaRainMmHr;
@override final  double metroManilaRain24hMm;
@override final  double forecast3hTotalMm;
@override final  String trend;
@override final  String conditionLabel;

/// Create a copy of WeatherRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherRawCopyWith<_WeatherRaw> get copyWith => __$WeatherRawCopyWithImpl<_WeatherRaw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherRawToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherRaw&&(identical(other.metroManilaRainMmHr, metroManilaRainMmHr) || other.metroManilaRainMmHr == metroManilaRainMmHr)&&(identical(other.metroManilaRain24hMm, metroManilaRain24hMm) || other.metroManilaRain24hMm == metroManilaRain24hMm)&&(identical(other.forecast3hTotalMm, forecast3hTotalMm) || other.forecast3hTotalMm == forecast3hTotalMm)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,metroManilaRainMmHr,metroManilaRain24hMm,forecast3hTotalMm,trend,conditionLabel);
}

@override
String toString() {
    return 'WeatherRaw(metroManilaRainMmHr: $metroManilaRainMmHr, metroManilaRain24hMm: $metroManilaRain24hMm, forecast3hTotalMm: $forecast3hTotalMm, trend: $trend, conditionLabel: $conditionLabel)';
}


}

/// @nodoc
abstract mixin class _$WeatherRawCopyWith<$Res> implements $WeatherRawCopyWith<$Res> {
  factory _$WeatherRawCopyWith(_WeatherRaw value, $Res Function(_WeatherRaw) _then) = __$WeatherRawCopyWithImpl;
@override @useResult
$Res call({
 double metroManilaRainMmHr, double metroManilaRain24hMm, double forecast3hTotalMm, String trend, String conditionLabel
});




}
/// @nodoc
class __$WeatherRawCopyWithImpl<$Res>
    implements _$WeatherRawCopyWith<$Res> {
  __$WeatherRawCopyWithImpl(this._self, this._then);

  final _WeatherRaw _self;
  final $Res Function(_WeatherRaw) _then;

/// Create a copy of WeatherRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metroManilaRainMmHr = null,Object? metroManilaRain24hMm = null,Object? forecast3hTotalMm = null,Object? trend = null,Object? conditionLabel = null,}) {
  return _then(_WeatherRaw(
metroManilaRainMmHr: null == metroManilaRainMmHr ? _self.metroManilaRainMmHr : metroManilaRainMmHr // ignore: cast_nullable_to_non_nullable
as double,metroManilaRain24hMm: null == metroManilaRain24hMm ? _self.metroManilaRain24hMm : metroManilaRain24hMm // ignore: cast_nullable_to_non_nullable
as double,forecast3hTotalMm: null == forecast3hTotalMm ? _self.forecast3hTotalMm : forecast3hTotalMm // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,conditionLabel: null == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
