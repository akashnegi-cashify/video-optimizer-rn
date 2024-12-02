enum RubbingOrGlassChangeEnum {
  rubbing(2, "Rubbing Required"),
  glassChange(1, "Glass Change Required"),
  notRequired(0, "Not Required");

  final int id;
  final String label;

  const RubbingOrGlassChangeEnum(this.id, this.label);

  static RubbingOrGlassChangeEnum findById(int id) {
    return RubbingOrGlassChangeEnum.values.firstWhere((element) => element.id == id);
  }

  static RubbingOrGlassChangeEnum findByLabel(String label) {
    return RubbingOrGlassChangeEnum.values.firstWhere((element) => element.label == label);
  }
}