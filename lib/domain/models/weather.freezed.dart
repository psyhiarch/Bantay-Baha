// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Weather {

 double get metroManilaRainMmHr; double get metroManilaRain24hMm; double get forecast3hTotalMm; String get trend; String get conditionLabel;
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCopyWith<Weather> get copyWith => _$WeatherCopyWithImpl<Weather>(this as Weather, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Weather;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Weather&&(identical(other.metroManilaRainMmHr, _this.metroManilaRainMmHr) || other.metroManilaRainMmHr == _this.metroManilaRainMmHr)&&(identical(other.metroManilaRain24hMm, _this.metroManilaRain24hMm) || other.metroManilaRain24hMm == _this.metroManilaRain24hMm)&&(identical(other.forecast3hTotalMm, _this.forecast3hTotalMm) || other.forecast3hTotalMm == _this.forecast3hTotalMm)&&(identical(other.trend, _this.trend) || other.trend == _this.trend)&&(identical(other.conditionLabel, _this.conditionLabel) || other.conditionLabel == _this.conditionLabel));
}


@override
int get hashCode {
  final _this = this as Weather;
  return Object.hash(runtimeType,_this.metroManilaRainMmHr,_this.metroManilaRain24hMm,_this.forecast3hTotalMm,_this.trend,_this.conditionLabel);
}

@override
String toString() {
  final _this = this as Weather;
  return 'Weather(metroManilaRainMmHr: ${_this.metroManilaRainMmHr}, metroManilaRain24hMm: ${_this.metroManilaRain24hMm}, forecast3hTotalMm: ${_this.forecast3hTotalMm}, trend: ${_this.trend}, conditionLabel: ${_this.conditionLabel})';
}


}

/// @nodoc
abstract mixin class $WeatherCopyWith<$Res>  {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) _then) = _$WeatherCopyWithImpl;
@useResult
$Res call({
 double metroManilaRainMmHr, double metroManilaRain24hMm, double forecast3hTotalMm, String trend, String conditionLabel
});




}
/// @nodoc
class _$WeatherCopyWithImpl<$Res>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._self, this._then);

  final Weather _self;
  final $Res Function(Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metroManilaRainMmHr = null,Object? metroManilaRain24hMm = null,Object? forecast3hTotalMm = null,Object? trend = null,Object? conditionLabel = null,}) {
  return _then(Weather(
metroManilaRainMmHr: null == metroManilaRainMmHr ? _self.metroManilaRainMmHr : metroManilaRainMmHr // ignore: cast_nullable_to_non_nullable
as double,metroManilaRain24hMm: null == metroManilaRain24hMm ? _self.metroManilaRain24hMm : metroManilaRain24hMm // ignore: cast_nullable_to_non_nullable
as double,forecast3hTotalMm: null == forecast3hTotalMm ? _self.forecast3hTotalMm : forecast3hTotalMm // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,conditionLabel: null == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Weather].
extension WeatherPatterns on Weather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Weather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Weather value)  $default,){
final _that = this;
switch (_that) {
case _Weather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Weather value)?  $default,){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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
case _Weather() when $default != null:
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
case _Weather():
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
case _Weather() when $default != null:
return $default(_that.metroManilaRainMmHr,_that.metroManilaRain24hMm,_that.forecast3hTotalMm,_that.trend,_that.conditionLabel);case _:
  return null;

}
}

}

/// @nodoc


class _Weather implements Weather {
  const _Weather({required this.metroManilaRainMmHr, required this.metroManilaRain24hMm, required this.forecast3hTotalMm, required this.trend, required this.conditionLabel});
  

@override final  double metroManilaRainMmHr;
@override final  double metroManilaRain24hMm;
@override final  double forecast3hTotalMm;
@override final  String trend;
@override final  String conditionLabel;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCopyWith<_Weather> get copyWith => __$WeatherCopyWithImpl<_Weather>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Weather&&(identical(other.metroManilaRainMmHr, metroManilaRainMmHr) || other.metroManilaRainMmHr == metroManilaRainMmHr)&&(identical(other.metroManilaRain24hMm, metroManilaRain24hMm) || other.metroManilaRain24hMm == metroManilaRain24hMm)&&(identical(other.forecast3hTotalMm, forecast3hTotalMm) || other.forecast3hTotalMm == forecast3hTotalMm)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel));
}


@override
int get hashCode {
    return Object.hash(runtimeType,metroManilaRainMmHr,metroManilaRain24hMm,forecast3hTotalMm,trend,conditionLabel);
}

@override
String toString() {
    return 'Weather(metroManilaRainMmHr: $metroManilaRainMmHr, metroManilaRain24hMm: $metroManilaRain24hMm, forecast3hTotalMm: $forecast3hTotalMm, trend: $trend, conditionLabel: $conditionLabel)';
}


}

/// @nodoc
abstract mixin class _$WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$WeatherCopyWith(_Weather value, $Res Function(_Weather) _then) = __$WeatherCopyWithImpl;
@override @useResult
$Res call({
 double metroManilaRainMmHr, double metroManilaRain24hMm, double forecast3hTotalMm, String trend, String conditionLabel
});




}
/// @nodoc
class __$WeatherCopyWithImpl<$Res>
    implements _$WeatherCopyWith<$Res> {
  __$WeatherCopyWithImpl(this._self, this._then);

  final _Weather _self;
  final $Res Function(_Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metroManilaRainMmHr = null,Object? metroManilaRain24hMm = null,Object? forecast3hTotalMm = null,Object? trend = null,Object? conditionLabel = null,}) {
  return _then(_Weather(
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
