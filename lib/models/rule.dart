const String tablePenalty = 'rule';

class RuleFields {
  static final List<String> values = [
    /// Add all fields
    id, article_id, rule
  ];

  static const String id = '_id';
  // ignore: constant_identifier_names
  static const String article_id = '_article_id';
  static const String rule = 'rule';
}

class Rule {
  final String id;
  // ignore: non_constant_identifier_names
  final String article_id;
  final String rule;

  const Rule({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.article_id,
    required this.rule,
  });

  Rule copy({
    String? id,
    // ignore: non_constant_identifier_names
    String? article_id,
    String? rule,
  }) =>
      Rule(
        id: id ?? this.id,
        article_id: article_id ?? this.article_id,
        rule: rule ?? this.rule,
      );

  static Rule fromJson(Map<String, Object?> json) => Rule(
        id: json[RuleFields.id].toString(),
        article_id: json[RuleFields.article_id].toString(),
        rule: json[RuleFields.rule].toString(),
      );

  Map<String, Object?> toJson() => {
        RuleFields.id: id,
        RuleFields.article_id: article_id,
        RuleFields.rule: rule,
      };
}
