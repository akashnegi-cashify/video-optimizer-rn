mixin Searchable {
  String? _searchQuery;

  String? get searchQuery => _searchQuery;

  set searchQuery(String? value) {
    _searchQuery = value;
  }
}
