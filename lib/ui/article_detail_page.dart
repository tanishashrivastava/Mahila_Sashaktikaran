import "package:flutter/material.dart";
import "package:final_project/db/articles_database.dart";
import "package:final_project/db/penalty_database.dart";
import "package:final_project/db/rule_database.dart";
import "package:final_project/models/article.dart";
import "package:final_project/models/penalty.dart";
import "package:final_project/models/rule.dart";
import 'package:flutter/services.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;

  const ArticleDetailPage({
    Key? key,
    required this.articleId,
  }) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late Articles article;
  late List<Penalty> penalty;
  late List<Rule> rule;

  late List<Map<String, String>> data = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    refreshNote();
  }

  addData(String key, String value) {
    late Map<String, String> temp = {};
    temp[key] = value;
    data.add(temp);
    setState(() => {});
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    article = await ArticlesDatabase.instance.readNote(widget.articleId);

    addData("article_id", article.article_id);
    addData("articleNo", article.articleNo);
    addData("title", article.title);
    addData("date", article.date);
    addData("intent", article.intent);

    penalty = await PenaltyDatabase.instance.readPenalty(widget.articleId);

    for (int i = 0; i < penalty.length; i++) {
      addData("penalty" + i.toString(), penalty[i].penalty);
    }

    rule = await RuleDatabase.instance.readRule(widget.articleId);
    for (int i = 0; i < rule.length; i++) {
      addData("rule" + i.toString(), rule[i].rule);
    }

    setState(() => isLoading = false);
    // print("data");
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Image.asset(
                    'image/homePage.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                  ),
                  Expanded(child: dataList())
                ],
              ),
      ),
    );
  }

  Widget penaltyList() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: penalty.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(penalty[index].article_id),
            subtitle: Text(penalty[index].penalty));
      });

  Widget ruleList() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: rule.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(rule[index].article_id),
            subtitle: Text(rule[index].rule));
      });

  Widget dataList() => ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        String key = data[index].keys.first;
        String value = data[index].values.first;

        if (key == "article_id") {
          // return ListTile(title: Text("Article ID : " + value));
          return const SizedBox(
            height: 60,
          );
        } else if (key == "articleNo") {
          if (value == "") {
            return const ListTile(
                title: Text("Article No : No article number"));
          } else {
            return ListTile(
              title: Text("Article No : " + value),
            );
          }
        } else if (key == "title") {
          if (value == "") {
            return const ListTile(title: Text("Artio : No article title"));
          } else {
            return ListTile(
              title: Text("Article Title : " + value),
            );
          }
        } else if (key == "date") {
          if (value == "") {
            return const ListTile(
                title: Text("Article Date : No article date"));
          } else {
            return ListTile(
              title: Text("Article Date : " + value),
            );
          }
        } else if (key == "intent") {
          if (value == "") {
            return const ListTile(
                title: Text("Article Intent : No article intent"));
          } else {
            return ListTile(
              title: Text("Article Intent : " + value),
            );
          }
        } else if (key.contains("penalty")) {
          if (value == "Null") {
            return const ListTile(title: Text("Penalty : No Penalty data"));
          } else {
            return ListTile(
              title: Text("Penalty : " + value),
            );
          }
        } else if (key.contains("rule")) {
          if (value == "") {
            return const ListTile(title: Text("Rule : No Rule data"));
          } else {
            return ListTile(
              title: Text("Rule : " + value),
            );
          }
        } else {
          return const ListTile(title: Text("The End"));
        }
      });
}
