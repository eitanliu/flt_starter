extension StandardTypeExtension<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and returns its result.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  R let<R>(R Function(T) block) {
    return block(this);
  }

  /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  T? takeIf(bool Function(T) predicate) {
    if (predicate(this)) return this;
    return null;
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  T? takeUnless(bool Function(T) predicate) {
    if (!predicate(this)) return this;
    return null;
  }
}

extension StandardBoolExtension on bool {
  bool then(Function() block) {
    if (this == true) {
      block();
    }
    return this;
  }

  bool other(Function() block) {
    if (this == false) {
      block();
    }
    return this;
  }
}
