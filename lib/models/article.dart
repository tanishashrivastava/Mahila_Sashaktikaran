const String tablearticles = 'articles';

class ArticlesFields {
  static final List<String> values = [
    /// Add all fields
    article_id, articleNo, title, date, intent
  ];

  // ignore: constant_identifier_names
  static const String article_id = '_article_id';
  static const String articleNo = 'articleNo';
  static const String title = 'title';
  static const String date = 'date';
  static const String intent = 'intent';
}

class Articles {
  // ignore: non_constant_identifier_names
  final String article_id;
  final String articleNo;
  final String title;
  final String date;
  final String intent;

  const Articles({
    // ignore: non_constant_identifier_names
    required this.article_id,
    required this.articleNo,
    required this.title,
    required this.date,
    required this.intent,
  });

  Articles copy(
          // ignore: non_constant_identifier_names
          {String? article_id,
          String? articleNo,
          String? title,
          String? date,
          String? intent}) =>
      Articles(
        article_id: article_id ?? this.article_id,
        articleNo: articleNo ?? this.articleNo,
        title: title ?? this.title,
        date: date ?? this.date,
        intent: intent ?? this.intent,
      );

  static Articles fromJson(Map<String, Object?> json) => Articles(
        article_id: json[ArticlesFields.article_id].toString(),
        articleNo: json[ArticlesFields.articleNo] as String,
        title: json[ArticlesFields.title] as String,
        date: json[ArticlesFields.date] as String,
        intent: json[ArticlesFields.intent] as String,
      );

  Map<String, Object?> toJson() => {
        ArticlesFields.article_id: article_id,
        ArticlesFields.title: title,
        ArticlesFields.articleNo: articleNo,
        ArticlesFields.date: date,
        ArticlesFields.intent: intent,
      };
}
