class ParseArray {
  static List<T> parseListItem<T>(List list, Function fromJson) {
    List<T> parseList = [];
    for (int i = 0; i < list.length; i++) {
      parseList.add(fromJson(list[i]));
    }
    return parseList;
  }
}
