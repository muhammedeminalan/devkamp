// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedQuestion {
  String get id;
  String get questionText;
  String get categoryId;
  String get categoryTitle;
  DateTime get savedAt;

  /// Create a copy of SavedQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedQuestionCopyWith<SavedQuestion> get copyWith =>
      _$SavedQuestionCopyWithImpl<SavedQuestion>(
          this as SavedQuestion, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedQuestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryTitle, categoryTitle) ||
                other.categoryTitle == categoryTitle) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, questionText, categoryId, categoryTitle, savedAt);

  @override
  String toString() {
    return 'SavedQuestion(id: $id, questionText: $questionText, categoryId: $categoryId, categoryTitle: $categoryTitle, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class $SavedQuestionCopyWith<$Res> {
  factory $SavedQuestionCopyWith(
          SavedQuestion value, $Res Function(SavedQuestion) _then) =
      _$SavedQuestionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String questionText,
      String categoryId,
      String categoryTitle,
      DateTime savedAt});
}

/// @nodoc
class _$SavedQuestionCopyWithImpl<$Res>
    implements $SavedQuestionCopyWith<$Res> {
  _$SavedQuestionCopyWithImpl(this._self, this._then);

  final SavedQuestion _self;
  final $Res Function(SavedQuestion) _then;

  /// Create a copy of SavedQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionText = null,
    Object? categoryId = null,
    Object? categoryTitle = null,
    Object? savedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      questionText: null == questionText
          ? _self.questionText
          : questionText // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryTitle: null == categoryTitle
          ? _self.categoryTitle
          : categoryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedQuestion].
extension SavedQuestionPatterns on SavedQuestion {
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
    TResult Function(_SavedQuestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion() when $default != null:
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
    TResult Function(_SavedQuestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion():
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
    TResult? Function(_SavedQuestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion() when $default != null:
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
    TResult Function(String id, String questionText, String categoryId,
            String categoryTitle, DateTime savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion() when $default != null:
        return $default(_that.id, _that.questionText, _that.categoryId,
            _that.categoryTitle, _that.savedAt);
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
    TResult Function(String id, String questionText, String categoryId,
            String categoryTitle, DateTime savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion():
        return $default(_that.id, _that.questionText, _that.categoryId,
            _that.categoryTitle, _that.savedAt);
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
    TResult? Function(String id, String questionText, String categoryId,
            String categoryTitle, DateTime savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedQuestion() when $default != null:
        return $default(_that.id, _that.questionText, _that.categoryId,
            _that.categoryTitle, _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SavedQuestion implements SavedQuestion {
  const _SavedQuestion(
      {required this.id,
      required this.questionText,
      required this.categoryId,
      required this.categoryTitle,
      required this.savedAt});

  @override
  final String id;
  @override
  final String questionText;
  @override
  final String categoryId;
  @override
  final String categoryTitle;
  @override
  final DateTime savedAt;

  /// Create a copy of SavedQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedQuestionCopyWith<_SavedQuestion> get copyWith =>
      __$SavedQuestionCopyWithImpl<_SavedQuestion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedQuestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryTitle, categoryTitle) ||
                other.categoryTitle == categoryTitle) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, questionText, categoryId, categoryTitle, savedAt);

  @override
  String toString() {
    return 'SavedQuestion(id: $id, questionText: $questionText, categoryId: $categoryId, categoryTitle: $categoryTitle, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$SavedQuestionCopyWith<$Res>
    implements $SavedQuestionCopyWith<$Res> {
  factory _$SavedQuestionCopyWith(
          _SavedQuestion value, $Res Function(_SavedQuestion) _then) =
      __$SavedQuestionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String questionText,
      String categoryId,
      String categoryTitle,
      DateTime savedAt});
}

/// @nodoc
class __$SavedQuestionCopyWithImpl<$Res>
    implements _$SavedQuestionCopyWith<$Res> {
  __$SavedQuestionCopyWithImpl(this._self, this._then);

  final _SavedQuestion _self;
  final $Res Function(_SavedQuestion) _then;

  /// Create a copy of SavedQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? questionText = null,
    Object? categoryId = null,
    Object? categoryTitle = null,
    Object? savedAt = null,
  }) {
    return _then(_SavedQuestion(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      questionText: null == questionText
          ? _self.questionText
          : questionText // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryTitle: null == categoryTitle
          ? _self.categoryTitle
          : categoryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
