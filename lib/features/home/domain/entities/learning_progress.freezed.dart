// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearningProgress {
  int get completedQuestions;
  int get totalQuestions;
  int get streakDays;
  String get lastStudiedCategory;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LearningProgressCopyWith<LearningProgress> get copyWith =>
      _$LearningProgressCopyWithImpl<LearningProgress>(
          this as LearningProgress, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LearningProgress &&
            (identical(other.completedQuestions, completedQuestions) ||
                other.completedQuestions == completedQuestions) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.lastStudiedCategory, lastStudiedCategory) ||
                other.lastStudiedCategory == lastStudiedCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completedQuestions,
      totalQuestions, streakDays, lastStudiedCategory);

  @override
  String toString() {
    return 'LearningProgress(completedQuestions: $completedQuestions, totalQuestions: $totalQuestions, streakDays: $streakDays, lastStudiedCategory: $lastStudiedCategory)';
  }
}

/// @nodoc
abstract mixin class $LearningProgressCopyWith<$Res> {
  factory $LearningProgressCopyWith(
          LearningProgress value, $Res Function(LearningProgress) _then) =
      _$LearningProgressCopyWithImpl;
  @useResult
  $Res call(
      {int completedQuestions,
      int totalQuestions,
      int streakDays,
      String lastStudiedCategory});
}

/// @nodoc
class _$LearningProgressCopyWithImpl<$Res>
    implements $LearningProgressCopyWith<$Res> {
  _$LearningProgressCopyWithImpl(this._self, this._then);

  final LearningProgress _self;
  final $Res Function(LearningProgress) _then;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedQuestions = null,
    Object? totalQuestions = null,
    Object? streakDays = null,
    Object? lastStudiedCategory = null,
  }) {
    return _then(_self.copyWith(
      completedQuestions: null == completedQuestions
          ? _self.completedQuestions
          : completedQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _self.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudiedCategory: null == lastStudiedCategory
          ? _self.lastStudiedCategory
          : lastStudiedCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [LearningProgress].
extension LearningProgressPatterns on LearningProgress {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LearningProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LearningProgress() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LearningProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningProgress():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LearningProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningProgress() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int completedQuestions, int totalQuestions, int streakDays,
            String lastStudiedCategory)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LearningProgress() when $default != null:
        return $default(_that.completedQuestions, _that.totalQuestions,
            _that.streakDays, _that.lastStudiedCategory);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int completedQuestions, int totalQuestions, int streakDays,
            String lastStudiedCategory)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningProgress():
        return $default(_that.completedQuestions, _that.totalQuestions,
            _that.streakDays, _that.lastStudiedCategory);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int completedQuestions, int totalQuestions,
            int streakDays, String lastStudiedCategory)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningProgress() when $default != null:
        return $default(_that.completedQuestions, _that.totalQuestions,
            _that.streakDays, _that.lastStudiedCategory);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LearningProgress implements LearningProgress {
  const _LearningProgress(
      {required this.completedQuestions,
      required this.totalQuestions,
      required this.streakDays,
      required this.lastStudiedCategory});

  @override
  final int completedQuestions;
  @override
  final int totalQuestions;
  @override
  final int streakDays;
  @override
  final String lastStudiedCategory;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LearningProgressCopyWith<_LearningProgress> get copyWith =>
      __$LearningProgressCopyWithImpl<_LearningProgress>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LearningProgress &&
            (identical(other.completedQuestions, completedQuestions) ||
                other.completedQuestions == completedQuestions) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.lastStudiedCategory, lastStudiedCategory) ||
                other.lastStudiedCategory == lastStudiedCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completedQuestions,
      totalQuestions, streakDays, lastStudiedCategory);

  @override
  String toString() {
    return 'LearningProgress(completedQuestions: $completedQuestions, totalQuestions: $totalQuestions, streakDays: $streakDays, lastStudiedCategory: $lastStudiedCategory)';
  }
}

/// @nodoc
abstract mixin class _$LearningProgressCopyWith<$Res>
    implements $LearningProgressCopyWith<$Res> {
  factory _$LearningProgressCopyWith(
          _LearningProgress value, $Res Function(_LearningProgress) _then) =
      __$LearningProgressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int completedQuestions,
      int totalQuestions,
      int streakDays,
      String lastStudiedCategory});
}

/// @nodoc
class __$LearningProgressCopyWithImpl<$Res>
    implements _$LearningProgressCopyWith<$Res> {
  __$LearningProgressCopyWithImpl(this._self, this._then);

  final _LearningProgress _self;
  final $Res Function(_LearningProgress) _then;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? completedQuestions = null,
    Object? totalQuestions = null,
    Object? streakDays = null,
    Object? lastStudiedCategory = null,
  }) {
    return _then(_LearningProgress(
      completedQuestions: null == completedQuestions
          ? _self.completedQuestions
          : completedQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _self.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudiedCategory: null == lastStudiedCategory
          ? _self.lastStudiedCategory
          : lastStudiedCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
