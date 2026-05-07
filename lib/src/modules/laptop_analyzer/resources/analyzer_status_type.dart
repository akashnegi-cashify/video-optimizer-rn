enum AnalyzerStatusType {
  paintShop(4, "Paint Shop"),
  bodyShop(5, "Body Shop"),
  dismantling(6, "Dismantling");

  final int value;
  final String label;

  const AnalyzerStatusType(this.value, this.label);
}
