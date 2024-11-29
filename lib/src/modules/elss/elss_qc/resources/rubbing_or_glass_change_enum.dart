enum RubbingOrGlassChangeEnum {
  rubbing(0, "Rubbing Required"),
  glassChange(1, "Glass Change Required"),
  notRequired(2, "Not Required");

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