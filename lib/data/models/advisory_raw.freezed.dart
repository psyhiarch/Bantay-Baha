// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advisory_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdvisoryRaw {

 String get id; String get source; String get authorName; String get authorHandle; String get publishedAt; String get cleanedText; String get severity; String get passability; String get depthCategory; int get depthInches; String get road; String get landmark; String get city; Map<String, double> get coordinates; List<Map<String, dynamic>> get locationPins;
/// Create a copy of AdvisoryRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvisoryRawCopyWith<AdvisoryRaw> get copyWith => _$AdvisoryRawCopyWithImpl<AdvisoryRaw>(this as AdvisoryRaw, _$identity);

  /// Serializes this AdvisoryRaw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdvisoryRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvisoryRaw&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.authorHandle, _this.authorHandle) || other.authorHandle == _this.authorHandle)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.cleanedText, _this.cleanedText) || other.cleanedText == _this.cleanedText)&&(identical(other.severity, _this.severity) || other.severity == _this.severity)&&(identical(other.passability, _this.passability) || other.passability == _this.passability)&&(identical(other.depthCategory, _this.depthCategory) || other.depthCategory == _this.depthCategory)&&(identical(other.depthInches, _this.depthInches) || other.depthInches == _this.depthInches)&&(identical(other.road, _this.road) || other.road == _this.road)&&(identical(other.landmark, _this.landmark) || other.landmark == _this.landmark)&&(identical(other.city, _this.city) || other.city == _this.city)&&const DeepCollectionEquality().equals(other.coordinates, _this.coordinates)&&const DeepCollectionEquality().equals(other.locationPins, _this.locationPins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdvisoryRaw;
  return Object.hash(runtimeType,_this.id,_this.source,_this.authorName,_this.authorHandle,_this.publishedAt,_this.cleanedText,_this.severity,_this.passability,_this.depthCategory,_this.depthInches,_this.road,_this.landmark,_this.city,const DeepCollectionEquality().hash(_this.coordinates),const DeepCollectionEquality().hash(_this.locationPins));
}

@override
String toString() {
  final _this = this as AdvisoryRaw;
  return 'AdvisoryRaw(id: ${_this.id}, source: ${_this.source}, authorName: ${_this.authorName}, authorHandle: ${_this.authorHandle}, publishedAt: ${_this.publishedAt}, cleanedText: ${_this.cleanedText}, severity: ${_this.severity}, passability: ${_this.passability}, depthCategory: ${_this.depthCategory}, depthInches: ${_this.depthInches}, road: ${_this.road}, landmark: ${_this.landmark}, city: ${_this.city}, coordinates: ${_this.coordinates}, locationPins: ${_this.locationPins})';
}


}

/// @nodoc
abstract mixin class $AdvisoryRawCopyWith<$Res>  {
  factory $AdvisoryRawCopyWith(AdvisoryRaw value, $Res Function(AdvisoryRaw) _then) = _$AdvisoryRawCopyWithImpl;
@useResult
$Res call({
 String id, String source, String authorName, String authorHandle, String publishedAt, String cleanedText, String severity, String passability, String depthCategory, int depthInches, String road, String landmark, String city, Map<String, double> coordinates, List<Map<String, dynamic>> locationPins
});




}
/// @nodoc
class _$AdvisoryRawCopyWithImpl<$Res>
    implements $AdvisoryRawCopyWith<$Res> {
  _$AdvisoryRawCopyWithImpl(this._self, this._then);

  final AdvisoryRaw _self;
  final $Res Function(AdvisoryRaw) _then;

/// Create a copy of AdvisoryRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? authorName = null,Object? authorHandle = null,Object? publishedAt = null,Object? cleanedText = null,Object? severity = null,Object? passability = null,Object? depthCategory = null,Object? depthInches = null,Object? road = null,Object? landmark = null,Object? city = null,Object? coordinates = null,Object? locationPins = null,}) {
  return _then(AdvisoryRaw(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorHandle: null == authorHandle ? _self.authorHandle : authorHandle // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,cleanedText: null == cleanedText ? _self.cleanedText : cleanedText // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,depthInches: null == depthInches ? _self.depthInches : depthInches // ignore: cast_nullable_to_non_nullable
as int,road: null == road ? _self.road : road // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,locationPins: null == locationPins ? _self.locationPins : locationPins // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdvisoryRaw].
extension AdvisoryRawPatterns on AdvisoryRaw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdvisoryRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdvisoryRaw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdvisoryRaw value)  $default,){
final _that = this;
switch (_that) {
case _AdvisoryRaw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdvisoryRaw value)?  $default,){
final _that = this;
switch (_that) {
case _AdvisoryRaw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String authorName,  String authorHandle,  String publishedAt,  String cleanedText,  String severity,  String passability,  String depthCategory,  int depthInches,  String road,  String landmark,  String city,  Map<String, double> coordinates,  List<Map<String, dynamic>> locationPins)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdvisoryRaw() when $default != null:
return $default(_that.id,_that.source,_that.authorName,_that.authorHandle,_that.publishedAt,_that.cleanedText,_that.severity,_that.passability,_that.depthCategory,_that.depthInches,_that.road,_that.landmark,_that.city,_that.coordinates,_that.locationPins);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String authorName,  String authorHandle,  String publishedAt,  String cleanedText,  String severity,  String passability,  String depthCategory,  int depthInches,  String road,  String landmark,  String city,  Map<String, double> coordinates,  List<Map<String, dynamic>> locationPins)  $default,) {final _that = this;
switch (_that) {
case _AdvisoryRaw():
return $default(_that.id,_that.source,_that.authorName,_that.authorHandle,_that.publishedAt,_that.cleanedText,_that.severity,_that.passability,_that.depthCategory,_that.depthInches,_that.road,_that.landmark,_that.city,_that.coordinates,_that.locationPins);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String authorName,  String authorHandle,  String publishedAt,  String cleanedText,  String severity,  String passability,  String depthCategory,  int depthInches,  String road,  String landmark,  String city,  Map<String, double> coordinates,  List<Map<String, dynamic>> locationPins)?  $default,) {final _that = this;
switch (_that) {
case _AdvisoryRaw() when $default != null:
return $default(_that.id,_that.source,_that.authorName,_that.authorHandle,_that.publishedAt,_that.cleanedText,_that.severity,_that.passability,_that.depthCategory,_that.depthInches,_that.road,_that.landmark,_that.city,_that.coordinates,_that.locationPins);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdvisoryRaw implements AdvisoryRaw {
  const _AdvisoryRaw({required this.id, required this.source, required this.authorName, required this.authorHandle, required this.publishedAt, required this.cleanedText, required this.severity, required this.passability, required this.depthCategory, required this.depthInches, required this.road, required this.landmark, required this.city, required  Map<String, double> coordinates, required  List<Map<String, dynamic>> locationPins}): _coordinates = coordinates,_locationPins = locationPins;
  factory _AdvisoryRaw.fromJson(Map<String, dynamic> json) => _$AdvisoryRawFromJson(json);

@override final  String id;
@override final  String source;
@override final  String authorName;
@override final  String authorHandle;
@override final  String publishedAt;
@override final  String cleanedText;
@override final  String severity;
@override final  String passability;
@override final  String depthCategory;
@override final  int depthInches;
@override final  String road;
@override final  String landmark;
@override final  String city;
 final  Map<String, double> _coordinates;
@override Map<String, double> get coordinates {
  if (_coordinates is EqualUnmodifiableMapView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_coordinates);
}

 final  List<Map<String, dynamic>> _locationPins;
@override List<Map<String, dynamic>> get locationPins {
  if (_locationPins is EqualUnmodifiableListView) return _locationPins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locationPins);
}


/// Create a copy of AdvisoryRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvisoryRawCopyWith<_AdvisoryRaw> get copyWith => __$AdvisoryRawCopyWithImpl<_AdvisoryRaw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdvisoryRawToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdvisoryRaw&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorHandle, authorHandle) || other.authorHandle == authorHandle)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.cleanedText, cleanedText) || other.cleanedText == cleanedText)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.passability, passability) || other.passability == passability)&&(identical(other.depthCategory, depthCategory) || other.depthCategory == depthCategory)&&(identical(other.depthInches, depthInches) || other.depthInches == depthInches)&&(identical(other.road, road) || other.road == road)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.coordinates, _coordinates)&&const DeepCollectionEquality().equals(other.locationPins, _locationPins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,source,authorName,authorHandle,publishedAt,cleanedText,severity,passability,depthCategory,depthInches,road,landmark,city,const DeepCollectionEquality().hash(_coordinates),const DeepCollectionEquality().hash(_locationPins));
}

@override
String toString() {
    return 'AdvisoryRaw(id: $id, source: $source, authorName: $authorName, authorHandle: $authorHandle, publishedAt: $publishedAt, cleanedText: $cleanedText, severity: $severity, passability: $passability, depthCategory: $depthCategory, depthInches: $depthInches, road: $road, landmark: $landmark, city: $city, coordinates: $coordinates, locationPins: $locationPins)';
}


}

/// @nodoc
abstract mixin class _$AdvisoryRawCopyWith<$Res> implements $AdvisoryRawCopyWith<$Res> {
  factory _$AdvisoryRawCopyWith(_AdvisoryRaw value, $Res Function(_AdvisoryRaw) _then) = __$AdvisoryRawCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String authorName, String authorHandle, String publishedAt, String cleanedText, String severity, String passability, String depthCategory, int depthInches, String road, String landmark, String city, Map<String, double> coordinates, List<Map<String, dynamic>> locationPins
});




}
/// @nodoc
class __$AdvisoryRawCopyWithImpl<$Res>
    implements _$AdvisoryRawCopyWith<$Res> {
  __$AdvisoryRawCopyWithImpl(this._self, this._then);

  final _AdvisoryRaw _self;
  final $Res Function(_AdvisoryRaw) _then;

/// Create a copy of AdvisoryRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? authorName = null,Object? authorHandle = null,Object? publishedAt = null,Object? cleanedText = null,Object? severity = null,Object? passability = null,Object? depthCategory = null,Object? depthInches = null,Object? road = null,Object? landmark = null,Object? city = null,Object? coordinates = null,Object? locationPins = null,}) {
  return _then(_AdvisoryRaw(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorHandle: null == authorHandle ? _self.authorHandle : authorHandle // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,cleanedText: null == cleanedText ? _self.cleanedText : cleanedText // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,passability: null == passability ? _self.passability : passability // ignore: cast_nullable_to_non_nullable
as String,depthCategory: null == depthCategory ? _self.depthCategory : depthCategory // ignore: cast_nullable_to_non_nullable
as String,depthInches: null == depthInches ? _self.depthInches : depthInches // ignore: cast_nullable_to_non_nullable
as int,road: null == road ? _self.road : road // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,locationPins: null == locationPins ? _self._locationPins : locationPins // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
