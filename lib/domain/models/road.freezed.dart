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

 String get roadId; String get roadName; List<List<double>> get coordinates; List<double> get centroid; double get elevationM; double get elevationMeters; double get noahHazardLevel; bool get isFlooded; double get estimatedDepthCm; double get hazardScore; String get severity; String get color; String get depthCategory; dynamic get lineWeight; List<String> get drivableVehicles; Map<String, dynamic> get nearestStation; bool get isNearRiver; String get nationalRoute; String get roadClassification; String get region; String get description;
/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadCopyWith<Road> get copyWith => _$RoadCopyWithImpl<Road>(this as Road, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Road;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Road&&(identical(other.roadId, _this.roadId) || other.roadId == _this.roadId)&&(identical(other.roadName, _this.roadName) || other.roadName == _this.roadName)&&const DeepCollectionEquality().equals(other.coordinates, _this.coordinates)&&const DeepCollectionEquality().equals(other.centroid, _this.centroid)&&(identical(other.elevationM, _this.elevationM) || other.elevationM == _this.elevationM)&&(identical(other.elevationMeters, _this.elevationMeters) || other.elevationMeters == _this.elevationMeters)&&(identical(other.noahHazardLevel, _this.noahHazardLevel) || other.noahHazardLevel == _this.noahHazardLevel)&&(identical(other.isFlooded, _this.isFlooded) || other.isFlooded == _this.isFlooded)&&(identical(other.estimatedDepthCm, _this.estimatedDepthCm) || other.estimatedDepthCm == _this.estimatedDepthCm)&&(identical(other.hazardScore, _this.hazardScore) || other.hazardScore == _this.hazardScore)&&(identical(other.severity, _this.severity) || other.severity == _this.severity)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.depthCategory, _this.depthCategory) || other.depthCategory == _this.depthCategory)&&const DeepCollectionEquality().equals(other.lineWeight, _this.lineWeight)&&const DeepCollectionEquality().equals(other.drivableVehicles, _this.drivableVehicles)&&const DeepCollectionEquality().equals(other.nearestStation, _this.nearestStation)&&(identical(other.isNearRiver, _this.isNearRiver) || other.isNearRiver == _this.isNearRiver)&&(identical(other.nationalRoute, _this.nationalRoute) || other.nationalRoute == _this.nationalRoute)&&(identical(other.roadClassification, _this.roadClassification) || other.roadClassification == _this.roadClassification)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as Road;
  return Object.hashAll([runtimeType,_this.roadId,_this.roadName,const DeepCollectionEquality().hash(_this.coordinates),const DeepCollectionEquality().hash(_this.centroid),_this.elevationM,_this.elevationMeters,_this.noahHazardLevel,_this.isFlooded,_this.estimatedDepthCm,_this.hazardScore,_this.severity,_this.color,_this.depthCategory,const DeepCollectionEquality().hash(_this.lineWeight),const DeepCollectionEquality().hash(_this.drivableVehicles),const DeepCollectionEquality().hash(_this.nearestStation),_this.isNearRiver,_this.nationalRoute,_this.roadClassification,_this.region,_this.description]);
}

@override
String toString() {
  final _this = this as Road;
  return 'Road(roadId: ${_this.roadId}, roadName: ${_this.roadName}, coordinates: ${_this.coordinates}, centroid: ${_this.centroid}, elevationM: ${_this.elevationM}, elevationMeters: ${_this.elevationMeters}, noahHazardLevel: ${_this.noahHazardLevel}, isFlooded: ${_this.isFlooded}, estimatedDepthCm: ${_this.estimatedDepthCm}, hazardScore: ${_this.hazardScore}, severity: ${_this.severity}, color: ${_this.color}, depthCategory: ${_this.depthCategory}, lineWeight: ${_this.lineWeight}, drivableVehicles: ${_this.drivableVehicles}, nearestStation: ${_this.nearestStation}, isNearRiver: ${_this.isNearRiver}, nationalRoute: ${_this.nationalRoute}, roadClassification: ${_this.roadClassification}, region: ${_this.region}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $RoadCopyWith<$Res>  {
  factory $RoadCopyWith(Road value, $Res Function(Road) _then) = _$RoadCopyWithImpl;
@useResult
$Res call({
 String roadId, String roadName, List<List<double>> coordinates, List<double> centroid, double elevationM, double elevationMeters, double noahHazardLevel, bool isFlooded, double estimatedDepthCm, double hazardScore, String severity, String color, String depthCategory, dynamic lineWeight, List<String> drivableVehicles, Map<String, dynamic> nearestStation, bool isNearRiver, String nationalRoute, String roadClassification, String region, String description
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
@pragma('vm:prefer-inline') @override $Res call({Object? roadId = null,Object? roadName = null,Object? coordinates = null,Object? centroid = null,Object? elevationM = null,Object? elevationMeters = null,Object? noahHazardLevel = null,Object? isFlooded = null,Object? estimatedDepthCm = null,Object? hazardScore = null,Object? severity = null,Object? color = null,Object? depthCategory = null,Object? lineWeight = freezed,Object? drivableVehicles = null,Object? nearestStation = null,Object? isNearRiver = null,Object? nationalRoute = null,Object? roadClassification = null,Object? region = null,Object? description = null,}) {
  return _then(Road(
roadId: null == roadId ? _self.roadId : roadId // ignore: cast_nullable_to_non_nullable
as String,roadName: null == roadName ? _self.roadName : roadName // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<List<double>>,centroid: null == centroid ? _self.centroid : centroid // ignore: cast_nullable_to_non_nullable
as List<double>,elevationM: null == elevationM ? _self.elevationM : elevationM // ignore: cast_nullable_to_non_nullable
as double,elevationMeters: null == elevationMeters ? _self.elevationMeters : elevationMeters // ignore: cast_nullable_to_non_nullable
as double,noahHazardLevel: null == noahHazardLevel ? _self.noahHazardLevel : noahHazardLevel // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,estimatedDepthCm: null == estimatedDepthCm ? _self.estimatedDepthCm : estimatedDepthCm // ignore: cast_nullable_to_non_nullable
as double,hazardScore: null == hazardScore ? _self.hazardScore : hazardScore // ignore: cast_nullable_to_non_nullable
as double,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,lineWeight: freezed == lineWeight ? _self.lineWeight : lineWeight // ignore: cast_nullable_to_non_nullable
as dynamic,drivableVehicles: null == drivableVehicles ? _self.drivableVehicles : drivableVehicles // ignore: cast_nullable_to_non_nullable
as List<String>,nearestStation: null == nearestStation ? _self.nearestStation : nearestStation // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isNearRiver: null == isNearRiver ? _self.isNearRiver : isNearRiver // ignore: cast_nullable_to_non_nullable
as bool,nationalRoute: null == nationalRoute ? _self.nationalRoute : nationalRoute // ignore: cast_nullable_to_non_nullable
as String,roadClassification: null == roadClassification ? _self.roadClassification : roadClassification // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roadId,  String roadName,  List<List<double>> coordinates,  List<double> centroid,  double elevationM,  double elevationMeters,  double noahHazardLevel,  bool isFlooded,  double estimatedDepthCm,  double hazardScore,  String severity,  String color,  String depthCategory,  dynamic lineWeight,  List<String> drivableVehicles,  Map<String, dynamic> nearestStation,  bool isNearRiver,  String nationalRoute,  String roadClassification,  String region,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Road() when $default != null:
return $default(_that.roadId,_that.roadName,_that.coordinates,_that.centroid,_that.elevationM,_that.elevationMeters,_that.noahHazardLevel,_that.isFlooded,_that.estimatedDepthCm,_that.hazardScore,_that.severity,_that.color,_that.depthCategory,_that.lineWeight,_that.drivableVehicles,_that.nearestStation,_that.isNearRiver,_that.nationalRoute,_that.roadClassification,_that.region,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roadId,  String roadName,  List<List<double>> coordinates,  List<double> centroid,  double elevationM,  double elevationMeters,  double noahHazardLevel,  bool isFlooded,  double estimatedDepthCm,  double hazardScore,  String severity,  String color,  String depthCategory,  dynamic lineWeight,  List<String> drivableVehicles,  Map<String, dynamic> nearestStation,  bool isNearRiver,  String nationalRoute,  String roadClassification,  String region,  String description)  $default,) {final _that = this;
switch (_that) {
case _Road():
return $default(_that.roadId,_that.roadName,_that.coordinates,_that.centroid,_that.elevationM,_that.elevationMeters,_that.noahHazardLevel,_that.isFlooded,_that.estimatedDepthCm,_that.hazardScore,_that.severity,_that.color,_that.depthCategory,_that.lineWeight,_that.drivableVehicles,_that.nearestStation,_that.isNearRiver,_that.nationalRoute,_that.roadClassification,_that.region,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roadId,  String roadName,  List<List<double>> coordinates,  List<double> centroid,  double elevationM,  double elevationMeters,  double noahHazardLevel,  bool isFlooded,  double estimatedDepthCm,  double hazardScore,  String severity,  String color,  String depthCategory,  dynamic lineWeight,  List<String> drivableVehicles,  Map<String, dynamic> nearestStation,  bool isNearRiver,  String nationalRoute,  String roadClassification,  String region,  String description)?  $default,) {final _that = this;
switch (_that) {
case _Road() when $default != null:
return $default(_that.roadId,_that.roadName,_that.coordinates,_that.centroid,_that.elevationM,_that.elevationMeters,_that.noahHazardLevel,_that.isFlooded,_that.estimatedDepthCm,_that.hazardScore,_that.severity,_that.color,_that.depthCategory,_that.lineWeight,_that.drivableVehicles,_that.nearestStation,_that.isNearRiver,_that.nationalRoute,_that.roadClassification,_that.region,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _Road implements Road {
  const _Road({required this.roadId, required this.roadName, required  List<List<double>> coordinates, required  List<double> centroid, required this.elevationM, required this.elevationMeters, required this.noahHazardLevel, required this.isFlooded, required this.estimatedDepthCm, required this.hazardScore, required this.severity, required this.color, required this.depthCategory, required this.lineWeight, required  List<String> drivableVehicles, required  Map<String, dynamic> nearestStation, required this.isNearRiver, required this.nationalRoute, required this.roadClassification, required this.region, required this.description}): _coordinates = coordinates,_centroid = centroid,_drivableVehicles = drivableVehicles,_nearestStation = nearestStation;
  

@override final  String roadId;
@override final  String roadName;
 final  List<List<double>> _coordinates;
@override List<List<double>> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}

 final  List<double> _centroid;
@override List<double> get centroid {
  if (_centroid is EqualUnmodifiableListView) return _centroid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_centroid);
}

@override final  double elevationM;
@override final  double elevationMeters;
@override final  double noahHazardLevel;
@override final  bool isFlooded;
@override final  double estimatedDepthCm;
@override final  double hazardScore;
@override final  String severity;
@override final  String color;
@override final  String depthCategory;
@override final  dynamic lineWeight;
 final  List<String> _drivableVehicles;
@override List<String> get drivableVehicles {
  if (_drivableVehicles is EqualUnmodifiableListView) return _drivableVehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drivableVehicles);
}

 final  Map<String, dynamic> _nearestStation;
@override Map<String, dynamic> get nearestStation {
  if (_nearestStation is EqualUnmodifiableMapView) return _nearestStation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_nearestStation);
}

@override final  bool isNearRiver;
@override final  String nationalRoute;
@override final  String roadClassification;
@override final  String region;
@override final  String description;

/// Create a copy of Road
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadCopyWith<_Road> get copyWith => __$RoadCopyWithImpl<_Road>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Road&&(identical(other.roadId, roadId) || other.roadId == roadId)&&(identical(other.roadName, roadName) || other.roadName == roadName)&&const DeepCollectionEquality().equals(other.coordinates, _coordinates)&&const DeepCollectionEquality().equals(other.centroid, _centroid)&&(identical(other.elevationM, elevationM) || other.elevationM == elevationM)&&(identical(other.elevationMeters, elevationMeters) || other.elevationMeters == elevationMeters)&&(identical(other.noahHazardLevel, noahHazardLevel) || other.noahHazardLevel == noahHazardLevel)&&(identical(other.isFlooded, isFlooded) || other.isFlooded == isFlooded)&&(identical(other.estimatedDepthCm, estimatedDepthCm) || other.estimatedDepthCm == estimatedDepthCm)&&(identical(other.hazardScore, hazardScore) || other.hazardScore == hazardScore)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.color, color) || other.color == color)&&(identical(other.depthCategory, depthCategory) || other.depthCategory == depthCategory)&&const DeepCollectionEquality().equals(other.lineWeight, lineWeight)&&const DeepCollectionEquality().equals(other.drivableVehicles, _drivableVehicles)&&const DeepCollectionEquality().equals(other.nearestStation, _nearestStation)&&(identical(other.isNearRiver, isNearRiver) || other.isNearRiver == isNearRiver)&&(identical(other.nationalRoute, nationalRoute) || other.nationalRoute == nationalRoute)&&(identical(other.roadClassification, roadClassification) || other.roadClassification == roadClassification)&&(identical(other.region, region) || other.region == region)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,roadId,roadName,const DeepCollectionEquality().hash(_coordinates),const DeepCollectionEquality().hash(_centroid),elevationM,elevationMeters,noahHazardLevel,isFlooded,estimatedDepthCm,hazardScore,severity,color,depthCategory,const DeepCollectionEquality().hash(lineWeight),const DeepCollectionEquality().hash(_drivableVehicles),const DeepCollectionEquality().hash(_nearestStation),isNearRiver,nationalRoute,roadClassification,region,description]);
}

@override
String toString() {
    return 'Road(roadId: $roadId, roadName: $roadName, coordinates: $coordinates, centroid: $centroid, elevationM: $elevationM, elevationMeters: $elevationMeters, noahHazardLevel: $noahHazardLevel, isFlooded: $isFlooded, estimatedDepthCm: $estimatedDepthCm, hazardScore: $hazardScore, severity: $severity, color: $color, depthCategory: $depthCategory, lineWeight: $lineWeight, drivableVehicles: $drivableVehicles, nearestStation: $nearestStation, isNearRiver: $isNearRiver, nationalRoute: $nationalRoute, roadClassification: $roadClassification, region: $region, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RoadCopyWith<$Res> implements $RoadCopyWith<$Res> {
  factory _$RoadCopyWith(_Road value, $Res Function(_Road) _then) = __$RoadCopyWithImpl;
@override @useResult
$Res call({
 String roadId, String roadName, List<List<double>> coordinates, List<double> centroid, double elevationM, double elevationMeters, double noahHazardLevel, bool isFlooded, double estimatedDepthCm, double hazardScore, String severity, String color, String depthCategory, dynamic lineWeight, List<String> drivableVehicles, Map<String, dynamic> nearestStation, bool isNearRiver, String nationalRoute, String roadClassification, String region, String description
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
@override @pragma('vm:prefer-inline') $Res call({Object? roadId = null,Object? roadName = null,Object? coordinates = null,Object? centroid = null,Object? elevationM = null,Object? elevationMeters = null,Object? noahHazardLevel = null,Object? isFlooded = null,Object? estimatedDepthCm = null,Object? hazardScore = null,Object? severity = null,Object? color = null,Object? depthCategory = null,Object? lineWeight = freezed,Object? drivableVehicles = null,Object? nearestStation = null,Object? isNearRiver = null,Object? nationalRoute = null,Object? roadClassification = null,Object? region = null,Object? description = null,}) {
  return _then(_Road(
roadId: null == roadId ? _self.roadId : roadId // ignore: cast_nullable_to_non_nullable
as String,roadName: null == roadName ? _self.roadName : roadName // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<List<double>>,centroid: null == centroid ? _self._centroid : centroid // ignore: cast_nullable_to_non_nullable
as List<double>,elevationM: null == elevationM ? _self.elevationM : elevationM // ignore: cast_nullable_to_non_nullable
as double,elevationMeters: null == elevationMeters ? _self.elevationMeters : elevationMeters // ignore: cast_nullable_to_non_nullable
as double,noahHazardLevel: null == noahHazardLevel ? _self.noahHazardLevel : noahHazardLevel // ignore: cast_nullable_to_non_nullable
as double,isFlooded: null == isFlooded ? _self.isFlooded : isFlooded // ignore: cast_nullable_to_non_nullable
as bool,estimatedDepthCm: null == estimatedDepthCm ? _self.estimatedDepthCm : estimatedDepthCm // ignore: cast_nullable_to_non_nullable
as double,hazardScore: null == hazardScore ? _self.hazardScore : hazardScore // ignore: cast_nullable_to_non_nullable
as double,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,lineWeight: freezed == lineWeight ? _self.lineWeight : lineWeight // ignore: cast_nullable_to_non_nullable
as dynamic,drivableVehicles: null == drivableVehicles ? _self._drivableVehicles : drivableVehicles // ignore: cast_nullable_to_non_nullable
as List<String>,nearestStation: null == nearestStation ? _self._nearestStation : nearestStation // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isNearRiver: null == isNearRiver ? _self.isNearRiver : isNearRiver // ignore: cast_nullable_to_non_nullable
as bool,nationalRoute: null == nationalRoute ? _self.nationalRoute : nationalRoute // ignore: cast_nullable_to_non_nullable
as String,roadClassification: null == roadClassification ? _self.roadClassification : roadClassification // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
