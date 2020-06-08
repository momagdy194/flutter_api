import 'package:api/api/News_Api.dart';
import 'package:api/model.dart';
import 'package:flutter/material.dart';

import 'singe_post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsApi newsApi = NewsApi();

  List<Article> articles = [];
  int pages = 5;
  int currentPage = 1;

  bool loading = true;
  ScrollController scrollController = ScrollController();

  fetchApi() {
    newsApi.fetcharticles(currentPage).then(
      (snapshot) {
        articles.addAll(snapshot);
        setState(
          () {
            loading = false;
            if (currentPage != pages) {
              currentPage++;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchApi();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/logo.png'),
            ),
          ),
        ),
        title: Text(
          'APPLE NEWS',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: articles.length + 1,
                itemBuilder: (BuildContext context, index) {
                  if (index == articles.length) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Article article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SingePost(article);
                        }));
                      },
                      child: Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 160,
                              child: (articles[index].urlToImage != null)
                                  ? (loading)
                                      ? CircularProgressIndicator()
                                      : Image.network(
                                          articles[index].urlToImage,
                                          fit: BoxFit.cover,
                                        )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 80,
                                      child: Container(),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                articles[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.3,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
      ),
    );
  }
}
