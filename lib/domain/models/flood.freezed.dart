// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flood.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Flood {

 bool get success; DateTime get calculatedAt; DateTime get scrapedAt; Metrics get metrics; List<Station> get stations; List<Road> get roads; List<HeatmapPoint> get heatmapPoints; Weather get weather;
/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloodCopyWith<Flood> get copyWith => _$FloodCopyWithImpl<Flood>(this as Flood, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Flood;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Flood&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.calculatedAt, _this.calculatedAt) || other.calculatedAt == _this.calculatedAt)&&(identical(other.scrapedAt, _this.scrapedAt) || other.scrapedAt == _this.scrapedAt)&&(identical(other.metrics, _this.metrics) || other.metrics == _this.metrics)&&const DeepCollectionEquality().equals(other.stations, _this.stations)&&const DeepCollectionEquality().equals(other.roads, _this.roads)&&const DeepCollectionEquality().equals(other.heatmapPoints, _this.heatmapPoints)&&(identical(other.weather, _this.weather) || other.weather == _this.weather));
}


@override
int get hashCode {
  final _this = this as Flood;
  return Object.hash(runtimeType,_this.success,_this.calculatedAt,_this.scrapedAt,_this.metrics,const DeepCollectionEquality().hash(_this.stations),const DeepCollectionEquality().hash(_this.roads),const DeepCollectionEquality().hash(_this.heatmapPoints),_this.weather);
}

@override
String toString() {
  final _this = this as Flood;
  return 'Flood(success: ${_this.success}, calculatedAt: ${_this.calculatedAt}, scrapedAt: ${_this.scrapedAt}, metrics: ${_this.metrics}, stations: ${_this.stations}, roads: ${_this.roads}, heatmapPoints: ${_this.heatmapPoints}, weather: ${_this.weather})';
}


}

/// @nodoc
abstract mixin class $FloodCopyWith<$Res>  {
  factory $FloodCopyWith(Flood value, $Res Function(Flood) _then) = _$FloodCopyWithImpl;
@useResult
$Res call({
 bool success, DateTime calculatedAt, DateTime scrapedAt, Metrics metrics, List<Station> stations, List<Road> roads, List<HeatmapPoint> heatmapPoints, Weather weather
});


$MetricsCopyWith<$Res> get metrics;$WeatherCopyWith<$Res> get weather;

}
/// @nodoc
class _$FloodCopyWithImpl<$Res>
    implements $FloodCopyWith<$Res> {
  _$FloodCopyWithImpl(this._self, this._then);

  final Flood _self;
  final $Res Function(Flood) _then;

/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? calculatedAt = null,Object? scrapedAt = null,Object? metrics = null,Object? stations = null,Object? roads = null,Object? heatmapPoints = null,Object? weather = null,}) {
  return _then(Flood(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Metrics,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<Station>,roads: null == roads ? _self.roads : roads // ignore: cast_nullable_to_non_nullable
as List<Road>,heatmapPoints: null == heatmapPoints ? _self.heatmapPoints : heatmapPoints // ignore: cast_nullable_to_non_nullable
as List<HeatmapPoint>,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as Weather,
  ));
}
/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricsCopyWith<$Res> get metrics {
  
  return $MetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherCopyWith<$Res> get weather {
  
  return $WeatherCopyWith<$Res>(_self.weather, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}


/// Adds pattern-matching-related methods to [Flood].
extension FloodPatterns on Flood {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Flood value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Flood() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Flood value)  $default,){
final _that = this;
switch (_that) {
case _Flood():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Flood value)?  $default,){
final _that = this;
switch (_that) {
case _Flood() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  DateTime calculatedAt,  DateTime scrapedAt,  Metrics metrics,  List<Station> stations,  List<Road> roads,  List<HeatmapPoint> heatmapPoints,  Weather weather)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Flood() when $default != null:
return $default(_that.success,_that.calculatedAt,_that.scrapedAt,_that.metrics,_that.stations,_that.roads,_that.heatmapPoints,_that.weather);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  DateTime calculatedAt,  DateTime scrapedAt,  Metrics metrics,  List<Station> stations,  List<Road> roads,  List<HeatmapPoint> heatmapPoints,  Weather weather)  $default,) {final _that = this;
switch (_that) {
case _Flood():
return $default(_that.success,_that.calculatedAt,_that.scrapedAt,_that.metrics,_that.stations,_that.roads,_that.heatmapPoints,_that.weather);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  DateTime calculatedAt,  DateTime scrapedAt,  Metrics metrics,  List<Station> stations,  List<Road> roads,  List<HeatmapPoint> heatmapPoints,  Weather weather)?  $default,) {final _that = this;
switch (_that) {
case _Flood() when $default != null:
return $default(_that.success,_that.calculatedAt,_that.scrapedAt,_that.metrics,_that.stations,_that.roads,_that.heatmapPoints,_that.weather);case _:
  return null;

}
}

}

/// @nodoc


class _Flood implements Flood {
  const _Flood({required this.success, required this.calculatedAt, required this.scrapedAt, required this.metrics, required  List<Station> stations, required  List<Road> roads, required  List<HeatmapPoint> heatmapPoints, required this.weather}): _stations = stations,_roads = roads,_heatmapPoints = heatmapPoints;
  

@override final  bool success;
@override final  DateTime calculatedAt;
@override final  DateTime scrapedAt;
@override final  Metrics metrics;
 final  List<Station> _stations;
@override List<Station> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

 final  List<Road> _roads;
@override List<Road> get roads {
  if (_roads is EqualUnmodifiableListView) return _roads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roads);
}

 final  List<HeatmapPoint> _heatmapPoints;
@override List<HeatmapPoint> get heatmapPoints {
  if (_heatmapPoints is EqualUnmodifiableListView) return _heatmapPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heatmapPoints);
}

@override final  Weather weather;

/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloodCopyWith<_Flood> get copyWith => __$FloodCopyWithImpl<_Flood>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Flood&&(identical(other.success, success) || other.success == success)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.scrapedAt, scrapedAt) || other.scrapedAt == scrapedAt)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.stations, _stations)&&const DeepCollectionEquality().equals(other.roads, _roads)&&const DeepCollectionEquality().equals(other.heatmapPoints, _heatmapPoints)&&(identical(other.weather, weather) || other.weather == weather));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,calculatedAt,scrapedAt,metrics,const DeepCollectionEquality().hash(_stations),const DeepCollectionEquality().hash(_roads),const DeepCollectionEquality().hash(_heatmapPoints),weather);
}

@override
String toString() {
    return 'Flood(success: $success, calculatedAt: $calculatedAt, scrapedAt: $scrapedAt, metrics: $metrics, stations: $stations, roads: $roads, heatmapPoints: $heatmapPoints, weather: $weather)';
}


}

/// @nodoc
abstract mixin class _$FloodCopyWith<$Res> implements $FloodCopyWith<$Res> {
  factory _$FloodCopyWith(_Flood value, $Res Function(_Flood) _then) = __$FloodCopyWithImpl;
@override @useResult
$Res call({
 bool success, DateTime calculatedAt, DateTime scrapedAt, Metrics metrics, List<Station> stations, List<Road> roads, List<HeatmapPoint> heatmapPoints, Weather weather
});


@override $MetricsCopyWith<$Res> get metrics;@override $WeatherCopyWith<$Res> get weather;

}
/// @nodoc
class __$FloodCopyWithImpl<$Res>
    implements _$FloodCopyWith<$Res> {
  __$FloodCopyWithImpl(this._self, this._then);

  final _Flood _self;
  final $Res Function(_Flood) _then;

/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? calculatedAt = null,Object? scrapedAt = null,Object? metrics = null,Object? stations = null,Object? roads = null,Object? heatmapPoints = null,Object? weather = null,}) {
  return _then(_Flood(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Metrics,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<Station>,roads: null == roads ? _self._roads : roads // ignore: cast_nullable_to_non_nullable
as List<Road>,heatmapPoints: null == heatmapPoints ? _self._heatmapPoints : heatmapPoints // ignore: cast_nullable_to_non_nullable
as List<HeatmapPoint>,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as Weather,
  ));
}

/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricsCopyWith<$Res> get metrics {
  
  return $MetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}/// Create a copy of Flood
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherCopyWith<$Res> get weather {
  
  return $WeatherCopyWith<$Res>(_self.weather, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}

// dart format on
