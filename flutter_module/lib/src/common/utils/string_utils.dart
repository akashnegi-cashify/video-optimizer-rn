extension StringUtil on String? {
  bool containsIgnoreCase(String? query) {
    return (this ?? "").toLowerCase().contains(query?.toLowerCase() ?? "");
  }
}
