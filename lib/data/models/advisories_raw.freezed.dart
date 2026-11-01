// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advisories_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdvisoriesRaw {

 bool? get success; String? get scrapedAt; List<Map<String, dynamic>>? get advisories; int? get totalCount; int? get activeFloodCount; Map<String, dynamic>? get meta;
/// Create a copy of AdvisoriesRaw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvisoriesRawCopyWith<AdvisoriesRaw> get copyWith => _$AdvisoriesRawCopyWithImpl<AdvisoriesRaw>(this as AdvisoriesRaw, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AdvisoriesRaw;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvisoriesRaw&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.scrapedAt, _this.scrapedAt) || other.scrapedAt == _this.scrapedAt)&&const DeepCollectionEquality().equals(other.advisories, _this.advisories)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.activeFloodCount, _this.activeFloodCount) || other.activeFloodCount == _this.activeFloodCount)&&const DeepCollectionEquality().equals(other.meta, _this.meta));
}


@override
int get hashCode {
  final _this = this as AdvisoriesRaw;
  return Object.hash(runtimeType,_this.success,_this.scrapedAt,const DeepCollectionEquality().hash(_this.advisories),_this.totalCount,_this.activeFloodCount,const DeepCollectionEquality().hash(_this.meta));
}

@override
String toString() {
  final _this = this as AdvisoriesRaw;
  return 'AdvisoriesRaw(success: ${_this.success}, scrapedAt: ${_this.scrapedAt}, advisories: ${_this.advisories}, totalCount: ${_this.totalCount}, activeFloodCount: ${_this.activeFloodCount}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $AdvisoriesRawCopyWith<$Res>  {
  factory $AdvisoriesRawCopyWith(AdvisoriesRaw value, $Res Function(AdvisoriesRaw) _then) = _$AdvisoriesRawCopyWithImpl;
@useResult
$Res call({
 bool? success, String? scrapedAt, List<Map<String, dynamic>>? advisories, int? totalCount, int? activeFloodCount, Map<String, dynamic>? meta
});




}
/// @nodoc
class _$AdvisoriesRawCopyWithImpl<$Res>
    implements $AdvisoriesRawCopyWith<$Res> {
  _$AdvisoriesRawCopyWithImpl(this._self, this._then);

  final AdvisoriesRaw _self;
  final $Res Function(AdvisoriesRaw) _then;

/// Create a copy of AdvisoriesRaw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? scrapedAt = freezed,Object? advisories = freezed,Object? totalCount = freezed,Object? activeFloodCount = freezed,Object? meta = freezed,}) {
  return _then(AdvisoriesRaw(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,scrapedAt: freezed == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String?,advisories: freezed == advisories ? _self.advisories : advisories // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,activeFloodCount: freezed == activeFloodCount ? _self.activeFloodCount : activeFloodCount // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdvisoriesRaw].
extension AdvisoriesRawPatterns on AdvisoriesRaw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdvisoriesRaw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdvisoriesRaw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdvisoriesRaw value)  $default,){
final _that = this;
switch (_that) {
case _AdvisoriesRaw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdvisoriesRaw value)?  $default,){
final _that = this;
switch (_that) {
case _AdvisoriesRaw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? success,  String? scrapedAt,  List<Map<String, dynamic>>? advisories,  int? totalCount,  int? activeFloodCount,  Map<String, dynamic>? meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdvisoriesRaw() when $default != null:
return $default(_that.success,_that.scrapedAt,_that.advisories,_that.totalCount,_that.activeFloodCount,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? success,  String? scrapedAt,  List<Map<String, dynamic>>? advisories,  int? totalCount,  int? activeFloodCount,  Map<String, dynamic>? meta)  $default,) {final _that = this;
switch (_that) {
case _AdvisoriesRaw():
return $default(_that.success,_that.scrapedAt,_that.advisories,_that.totalCount,_that.activeFloodCount,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? success,  String? scrapedAt,  List<Map<String, dynamic>>? advisories,  int? totalCount,  int? activeFloodCount,  Map<String, dynamic>? meta)?  $default,) {final _that = this;
switch (_that) {
case _AdvisoriesRaw() when $default != null:
return $default(_that.success,_that.scrapedAt,_that.advisories,_that.totalCount,_that.activeFloodCount,_that.meta);case _:
  return null;

}
}

}

/// @nodoc


class _AdvisoriesRaw implements AdvisoriesRaw {
  const _AdvisoriesRaw({required this.success, required this.scrapedAt, required  List<Map<String, dynamic>>? advisories, required this.totalCount, required this.activeFloodCount, required  Map<String, dynamic>? meta}): _advisories = advisories,_meta = meta;
  

@override final  bool? success;
@override final  String? scrapedAt;
 final  List<Map<String, dynamic>>? _advisories;
@override List<Map<String, dynamic>>? get advisories {
  final value = _advisories;
  if (value == null) return null;
  if (_advisories is EqualUnmodifiableListView) return _advisories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? totalCount;
@override final  int? activeFloodCount;
 final  Map<String, dynamic>? _meta;
@override Map<String, dynamic>? get meta {
  final value = _meta;
  if (value == null) return null;
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AdvisoriesRaw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvisoriesRawCopyWith<_AdvisoriesRaw> get copyWith => __$AdvisoriesRawCopyWithImpl<_AdvisoriesRaw>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdvisoriesRaw&&(identical(other.success, success) || other.success == success)&&(identical(other.scrapedAt, scrapedAt) || other.scrapedAt == scrapedAt)&&const DeepCollectionEquality().equals(other.advisories, _advisories)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.activeFloodCount, activeFloodCount) || other.activeFloodCount == activeFloodCount)&&const DeepCollectionEquality().equals(other.meta, _meta));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,scrapedAt,const DeepCollectionEquality().hash(_advisories),totalCount,activeFloodCount,const DeepCollectionEquality().hash(_meta));
}

@override
String toString() {
    return 'AdvisoriesRaw(success: $success, scrapedAt: $scrapedAt, advisories: $advisories, totalCount: $totalCount, activeFloodCount: $activeFloodCount, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$AdvisoriesRawCopyWith<$Res> implements $AdvisoriesRawCopyWith<$Res> {
  factory _$AdvisoriesRawCopyWith(_AdvisoriesRaw value, $Res Function(_AdvisoriesRaw) _then) = __$AdvisoriesRawCopyWithImpl;
@override @useResult
$Res call({
 bool? success, String? scrapedAt, List<Map<String, dynamic>>? advisories, int? totalCount, int? activeFloodCount, Map<String, dynamic>? meta
});




}
/// @nodoc
class __$AdvisoriesRawCopyWithImpl<$Res>
    implements _$AdvisoriesRawCopyWith<$Res> {
  __$AdvisoriesRawCopyWithImpl(this._self, this._then);

  final _AdvisoriesRaw _self;
  final $Res Function(_AdvisoriesRaw) _then;

/// Create a copy of AdvisoriesRaw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? scrapedAt = freezed,Object? advisories = freezed,Object? totalCount = freezed,Object? activeFloodCount = freezed,Object? meta = freezed,}) {
  return _then(_AdvisoriesRaw(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,scrapedAt: freezed == scrapedAt ? _self.scrapedAt : scrapedAt // ignore: cast_nullable_to_non_nullable
as String?,advisories: freezed == advisories ? _self._advisories : advisories // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,activeFloodCount: freezed == activeFloodCount ? _self.activeFloodCount : activeFloodCount // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
