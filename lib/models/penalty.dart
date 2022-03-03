const String tablePenalty = 'penalty';

class PenaltyFields {
  static final List<String> values = [
    /// Add all fields
    id, article_id, penalty
  ];

  static const String id = '_id';
  // ignore: constant_identifier_names
  static const String article_id = '_article_id';
  static const String penalty = 'penalty';
}

class Penalty {
  final String id;
  // ignore: non_constant_identifier_names
  final String article_id;
  final String penalty;

  const Penalty({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.article_id,
    required this.penalty,
  });

  Penalty copy({
    String? id,
    // ignore: non_constant_identifier_names
    String? article_id,
    String? penalty,
  }) =>
      Penalty(
        id: id ?? this.id,
        article_id: article_id ?? this.article_id,
        penalty: penalty ?? this.penalty,
      );

  static Penalty fromJson(Map<String, Object?> json) => Penalty(
        id: json[PenaltyFields.id].toString(),
        article_id: json[PenaltyFields.article_id].toString(),
        penalty: json[PenaltyFields.penalty].toString(),
      );

  Map<String, Object?> toJson() => {
        PenaltyFields.id: id,
        PenaltyFields.article_id: article_id,
        PenaltyFields.penalty: penalty,
      };
}
