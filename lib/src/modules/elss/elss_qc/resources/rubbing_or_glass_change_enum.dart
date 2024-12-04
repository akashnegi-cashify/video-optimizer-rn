enum RubbingOrGlassChangeEnum {
  rubbing(1, "Rubbing Required"),
  glassChange(2, "Glass Change Required"),
  notRequired(0, "Not Required");

  final int id;
  final String label;

  const RubbingOrGlassChangeEnum(this.id, this.label);

  static RubbingOrGlassChangeEnum findById(int? id) {
    if (id == null) {
      return RubbingOrGlassChangeEnum.notRequired;
    }
    return RubbingOrGlassChangeEnum.values.firstWhere((element) => element.id == id);
  }

  static RubbingOrGlassChangeEnum findByLabel(String label) {
    return RubbingOrGlassChangeEnum.values.firstWhere((element) => element.label.toLowerCase() == label.toLowerCase());
  }
}
