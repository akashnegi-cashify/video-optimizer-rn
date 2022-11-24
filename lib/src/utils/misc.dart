
mayBe(Function exp, [dynamic defaultValue]) {
  try {
    return exp();
  } catch (e) {
    return defaultValue ?? null;
  }
}
