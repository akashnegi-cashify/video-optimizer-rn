import 'package:json_annotation/json_annotation.dart';
part 'search_query.g.dart';

@JsonSerializable()
class SearchQuery {
  @JsonKey(name: "br")
  String? br;



  static SearchQuery fromJson(Map<String, dynamic> data) =>
      _$SearchQueryFromJson(data);

  Map<String, dynamic> toJson() => _$SearchQueryToJson(this);
}
