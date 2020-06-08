import 'package:api/model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingePost extends StatefulWidget {
  final Article article;

  SingePost(this.article);
  @override
  _SingePostState createState() => _SingePostState();
}

class _SingePostState extends State<SingePost> {
  onTap() {
    var url = widget.article.url;
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.article.urlToImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.article.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.article.description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  letterSpacing: .8,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: Text(
                  widget.article.url,
                  style: TextStyle(color: Colors.blue, height: 1.3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: Text(
                widget.article.content,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  letterSpacing: .8,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
