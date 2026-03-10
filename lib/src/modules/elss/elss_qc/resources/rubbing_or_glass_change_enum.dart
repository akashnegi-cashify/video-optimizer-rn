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
    return RubbingOrGlassChangeEnum.values.firstWhere(
      (element) => element.id == id,
      orElse: () => RubbingOrGlassChangeEnum.notRequired, // Default to "Not Required" if value not found
    );
  }

  static RubbingOrGlassChangeEnum findByLabel(String label) {
    return RubbingOrGlassChangeEnum.values.firstWhere(
      (element) => element.label.toLowerCase() == label.toLowerCase(),
      orElse: () => RubbingOrGlassChangeEnum.notRequired, // Default to "Not Required" if label not found
    );
  }
}
