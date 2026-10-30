// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flood_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FloodRaw {

 bool get success; String get calculatedAt; String get scrapedAt; Map<String, dynamic> get metrics; List<Map<String, dynamic>> get stations; List<Map<String, dynamic>> get roads; List<Map<String, dynamic>> get heatmapPoints; Map<String, dynamic> get weather;
/// Create a copy of FloodRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloodRawCopyWith<FloodRaw> get copyWith => _$FloodRawCopyWithImpl<FloodRaw>(this as FloodRaw, _$identity);

  /// Serializes this FloodRaw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FloodRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloodRaw&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.calculatedAt, _this.calculatedAt) || other.calculatedAt == _this.calculatedAt)&&(identical(other.scrapedAt, _this.scrapedAt) || other.scrapedAt == _this.scrapedAt)&&const DeepCollectionEquality().equals(other.metrics, _this.metrics)&&const DeepCollectionEquality().equals(other.stations, _this.stations)&&const DeepCollectionEquality().equals(other.roads, _this.roads)&&const DeepCollectionEquality().equals(other.heatmapPoints, _this.heatmapPoints)&&const DeepCollectionEquality().equals(other.weather, _this.weather));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FloodRaw;
  return Object.hash(runtimeType,_this.success,_this.calculatedAt,_this.scrapedAt,const DeepCollectionEquality().hash(_this.metrics),const DeepCollectionEquality().hash(_this.stations),const DeepCollectionEquality().hash(_this.roads),const DeepCollectionEquality().hash(_this.heatmapPoints),const DeepCollectionEquality().hash(_this.weather));
}

@override
String toString() {
  final _this = this as FloodRaw;
  return 'FloodRaw(success: ${_this.success}, calculatedAt: ${_this.calculatedAt}, scrapedAt: ${_this.scrapedAt}, metrics: ${_this.metrics}, stations: ${_this.stations}, roads: ${_this.roads}, heatmapPoints: ${_this.heatmapPoints}, weather: ${_this.weather})';
}


}

/// @nodoc
abstract mixin class $FloodRawCopyWith<$Res>  {
  factory $FloodRawCopyWith(FloodRaw value, $Res Function(FloodRaw) _then) = _$FloodRawCopyWithImpl;
@useResult
$Res call({
 bool success, String calculatedAt, String scrapedAt, Map<String, dynamic> metrics, List<Map<String, dynamic>> stations, List<Map<String, dynamic>> roads, List<Map<String, dynamic>> heatmapPoints, Map<String, dynamic> weather
});




}
/// @nodoc
class _$FloodRawCopyWithImpl<$Res>
    implements $FloodRawCopyWith<$Res> {
  _$FloodRawCopyWithImpl(this._self, this._then);

  final FloodRaw _self;
  final $Res Function(FloodRaw) _then;

/// Create a copy of FloodRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? calculatedAt = null,Object? scrapedAt = null,Object? metrics = null,Object? stations = null,Object? roads = null,Object? heatmapPoints = null,Object? weather = null,}) {
  return _then(FloodRaw(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,roads: null == roads ? _self.roads : roads // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,heatmapPoints: null == heatmapPoints ? _self.heatmapPoints : heatmapPoints // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FloodRaw].
extension FloodRawPatterns on FloodRaw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloodRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloodRaw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloodRaw value)  $default,){
final _that = this;
switch (_that) {
case _FloodRaw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloodRaw value)?  $default,){
final _that = this;
switch (_that) {
case _FloodRaw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String calculatedAt,  String scrapedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations,  List<Map<String, dynamic>> roads,  List<Map<String, dynamic>> heatmapPoints,  Map<String, dynamic> weather)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloodRaw() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String calculatedAt,  String scrapedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations,  List<Map<String, dynamic>> roads,  List<Map<String, dynamic>> heatmapPoints,  Map<String, dynamic> weather)  $default,) {final _that = this;
switch (_that) {
case _FloodRaw():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String calculatedAt,  String scrapedAt,  Map<String, dynamic> metrics,  List<Map<String, dynamic>> stations,  List<Map<String, dynamic>> roads,  List<Map<String, dynamic>> heatmapPoints,  Map<String, dynamic> weather)?  $default,) {final _that = this;
switch (_that) {
case _FloodRaw() when $default != null:
return $default(_that.success,_that.calculatedAt,_that.scrapedAt,_that.metrics,_that.stations,_that.roads,_that.heatmapPoints,_that.weather);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FloodRaw implements FloodRaw {
  const _FloodRaw({required this.success, required this.calculatedAt, required this.scrapedAt, required  Map<String, dynamic> metrics, required  List<Map<String, dynamic>> stations, required  List<Map<String, dynamic>> roads, required  List<Map<String, dynamic>> heatmapPoints, required  Map<String, dynamic> weather}): _metrics = metrics,_stations = stations,_roads = roads,_heatmapPoints = heatmapPoints,_weather = weather;
  factory _FloodRaw.fromJson(Map<String, dynamic> json) => _$FloodRawFromJson(json);

@override final  bool success;
@override final  String calculatedAt;
@override final  String scrapedAt;
 final  Map<String, dynamic> _metrics;
@override Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

 final  List<Map<String, dynamic>> _stations;
@override List<Map<String, dynamic>> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

 final  List<Map<String, dynamic>> _roads;
@override List<Map<String, dynamic>> get roads {
  if (_roads is EqualUnmodifiableListView) return _roads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roads);
}

 final  List<Map<String, dynamic>> _heatmapPoints;
@override List<Map<String, dynamic>> get heatmapPoints {
  if (_heatmapPoints is EqualUnmodifiableListView) return _heatmapPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heatmapPoints);
}

 final  Map<String, dynamic> _weather;
@override Map<String, dynamic> get weather {
  if (_weather is EqualUnmodifiableMapView) return _weather;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_weather);
}


/// Create a copy of FloodRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloodRawCopyWith<_FloodRaw> get copyWith => __$FloodRawCopyWithImpl<_FloodRaw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FloodRawToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloodRaw&&(identical(other.success, success) || other.success == success)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.scrapedAt, scrapedAt) || other.scrapedAt == scrapedAt)&&const DeepCollectionEquality().equals(other.metrics, _metrics)&&const DeepCollectionEquality().equals(other.stations, _stations)&&const DeepCollectionEquality().equals(other.roads, _roads)&&const DeepCollectionEquality().equals(other.heatmapPoints, _heatmapPoints)&&const DeepCollectionEquality().equals(other.weather, _weather));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,success,calculatedAt,scrapedAt,const DeepCollectionEquality().hash(_metrics),const DeepCollectionEquality().hash(_stations),const DeepCollectionEquality().hash(_roads),const DeepCollectionEquality().hash(_heatmapPoints),const DeepCollectionEquality().hash(_weather));
}

@override
String toString() {
    return 'FloodRaw(success: $success, calculatedAt: $calculatedAt, scrapedAt: $scrapedAt, metrics: $metrics, stations: $stations, roads: $roads, heatmapPoints: $heatmapPoints, weather: $weather)';
}


}

/// @nodoc
abstract mixin class _$FloodRawCopyWith<$Res> implements $FloodRawCopyWith<$Res> {
  factory _$FloodRawCopyWith(_FloodRaw value, $Res Function(_FloodRaw) _then) = __$FloodRawCopyWithImpl;
@override @useResult
$Res call({
 bool success, String calculatedAt, String scrapedAt, Map<String, dynamic> metrics, List<Map<String, dynamic>> stations, List<Map<String, dynamic>> roads, List<Map<String, dynamic>> heatmapPoints, Map<String, dynamic> weather
});




}
/// @nodoc
class __$FloodRawCopyWithImpl<$Res>
    implements _$FloodRawCopyWith<$Res> {
  __$FloodRawCopyWithImpl(this._self, this._then);

  final _FloodRaw _self;
  final $Res Function(_FloodRaw) _then;

/// Create a copy of FloodRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? calculatedAt = null,Object? scrapedAt = null,Object? metrics = null,Object? stations = null,Object? roads = null,Object? heatmapPoints = null,Object? weather = null,}) {
  return _then(_FloodRaw(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String,scrapedAt: null == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,roads: null == roads ? _self._roads : roads // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,heatmapPoints: null == heatmapPoints ? _self._heatmapPoints : heatmapPoints // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,weather: null == weather ? _self._weather : weather // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
