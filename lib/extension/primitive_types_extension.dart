extension BaseBoolExtension on bool {
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
