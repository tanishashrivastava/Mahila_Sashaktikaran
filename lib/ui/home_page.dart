import 'dart:ui';

import 'package:final_project/db/articles_database.dart';
import 'package:final_project/db/penalty_database.dart';
import 'package:final_project/db/rule_database.dart';
import 'package:final_project/models/article.dart';
import 'package:final_project/models/penalty.dart';
import 'package:final_project/models/rule.dart';
import 'package:final_project/ui/article_detail_page.dart';
import 'package:final_project/ui/chat_bot_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Articles> article;
  late List<Penalty> penalty;
  late List<Rule> rule;
  bool isLoading = false;
  late String _searchText = '';
  final searchTextController = TextEditingController();
  late Set<Map<String, String>> result = {};
  late List<Map<String, String>> resultList = [];
  late Map<String, String> tempResultList = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Future getData() async {
    result.clear();
    tempResultList.clear();
    resultList.clear();
    setState(() => isLoading = true);

    article = await ArticlesDatabase.instance.readAllNotes();

    for (int i = 0; i < article.length; i++) {
      bool temp = false;

      penalty =
          await PenaltyDatabase.instance.readPenalty(article[i].article_id);

      for (int j = 0; j < penalty.length; j++) {
        if (penalty[j]
            .penalty
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          result.add({penalty[j].article_id: article[i].title});

          temp = true;
          break;
        }
      }

      rule = await RuleDatabase.instance.readRule(article[i].article_id);

      if (!temp) {
        for (int j = 0; j < rule.length; j++) {
          if (rule[j].rule.toLowerCase().contains(_searchText.toLowerCase())) {
            result.add({rule[j].article_id: article[i].title});

            temp = true;
            break;
          }
        }
      } else {
        continue;
      }

      if (!temp) {
        if (article[i]
            .articleNo
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          result.add({article[i].article_id: article[i].title});

          temp = true;
          break;
        } else {
          continue;
        }
      }

      if (!temp) {
        if (article[i].date.toLowerCase().contains(_searchText.toLowerCase())) {
          result.add({article[i].article_id: article[i].title});
          temp = true;
          break;
        } else {
          continue;
        }
      }

      if (!temp) {
        if (article[i]
            .intent
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          result.add({article[i].article_id: article[i].title});

          temp = true;
          break;
        } else {
          continue;
        }
      }
      if (!temp) {
        if (article[i]
            .title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          result.add({article[i].article_id: article[i].title});

          temp = true;
          break;
        } else {
          continue;
        }
      }
    }

    setState(() => isLoading = false);

    for (var element in result) {
      element.forEach((key, value) {
        tempResultList[key] = value;
      });
    }

    tempResultList.forEach((key, value) {
      resultList.add({key: value});
    });

    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Image.asset(
          'image/homePage.jpg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 650,
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  color: Colors.brown,
                                  height: 26,
                                  child: const Text(
                                    "----",
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.brown,
                                minimumSize: const Size(130, 26),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Introduction",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  color: Colors.brown,
                                  height: 26,
                                  child: const Text(
                                    "----",
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.brown,
                                minimumSize: const Size(130, 26),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Why it is Necessary",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  color: Colors.brown,
                                  height: 26,
                                  child: const Text(
                                    "----",
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.brown,
                                minimumSize: const Size(130, 26),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Things to know about",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Expanded(
                  flex: 4,
                  child: Column(children: [
                    const SizedBox(
                      height: 683,
                    ),
                    Image.asset(
                      'image/chatbotIcon.jpg',
                      fit: BoxFit.none,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.pinkAccent.shade100,
                          minimumSize: const Size(130, 26),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatBotPage();
                          }));
                        },
                        child: const Text(
                          "Chat Bot",
                          style: TextStyle(fontSize: 20),
                        )),
                  ]),
                ),
              ],
            )
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 90),
            Row(
              children: [
                Center(
                    child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 270,
                      child: TextField(
                        cursorColor: Colors.brown,
                        style: const TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                        decoration: const InputDecoration(
                          hintText: 'Search Bar',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          labelStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.brown,
                              width: 4,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.brown,
                              width: 4,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        controller: searchTextController,
                      ),
                    ),
                  ],
                )),
                const SizedBox(width: 15),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.deepOrange.shade100,
                        primary: Colors.brown,
                        minimumSize: const Size(50, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _searchText = searchTextController.text;

                          if (_searchText.isEmpty) {
                            Container();
                          } else {
                            getData();
                          }
                        });
                      },
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Search",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.red.shade200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox(
                child: dataList(),
                width: 370,
                height: 475,
              ),
            ),
          ],
        ),
      ]),
    ));
  }

  Widget dataList() => ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int index) {
        String key = resultList[index].keys.first;
        String value = resultList[index].values.first;

        // return Container(
        //   color: Colors.blue[50],
        //   child: ListTile(
        //     // leading: Icon(Icons.add),
        //     title: Text(value),
        //     // trailing: Icon(Icons.done),
        //     // subtitle: Text('This is subtitle'),
        //     // selected: true,
        //     onTap: () async {
        //       await Navigator.push(context,
        //           MaterialPageRoute(builder: (context) {
        //         return ArticleDetailPage(articleId: key);
        //       }));
        //     },
        //   ),
        // );

        return ListTile(
          leading: const Icon(Icons.play_arrow_rounded),
          title: Text(
            value,
            style: TextStyle(
              color: Colors.brown[800],
            ),
          ),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ArticleDetailPage(articleId: key);
            }));
          },
        );
      });
}
