enum NpsQuestionType {
  rating("RATING"),
  text("TEXT"),
  unKnown("");

  final String value;

  const NpsQuestionType(this.value);

  NpsQuestionType findByValue(String value) {
    var npsList = NpsQuestionType.values;
    var index = npsList.indexWhere((element) => element.value.toLowerCase() == value.toLowerCase());
    if (index > -1) {
      return npsList[index];
    }
    return unKnown;
  }
}
