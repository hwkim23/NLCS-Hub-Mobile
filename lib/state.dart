import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_scraper/web_scraper.dart';

final firestore = FirebaseFirestore.instance;

class Store1 extends ChangeNotifier {
  List<String> title = [];
  List<String> path = [];

  double jeoji = 0;
  double geomun = 0;
  double sarah = 0;
  double mulchat = 0;
  double noro = 0;
  String nextCompetition = "";

  /*List<String> sport = [];
  List<String> tournament = [];
  List<String> date = [];
  List<bool> isA = [];
  List<bool> isBoy = [];
  List<List<dynamic>> score = [];
  List<String> opp = [];
  List<String> logoUrl = [];
  String nlcsUrl = "";*/

  List<String> podTitle = [];
  List<String> podPath = [];
  List<String> podImage = [];
  List<String> podDate = [];
  List<String> podImg = [];
  List<String> podMp3 = [];
  int documents = 0;

  Future<bool> getData() async {
    title = [];
    path = [];
    /*sport = [];
    tournament = [];
    date = [];
    isA = [];
    isBoy = [];
    score = [];
    opp = [];*/
    podTitle = [];
    podDate = [];
    podImage = [];
    podPath = [];
    podImg = [];
    podMp3 = [];
    //logoUrl = [];

    await firestore
        .collection("bulletin")
        .orderBy('index', descending: true)
        .get()
        .then((QuerySnapshot ds) {
      for (var doc in ds.docs) {
        title.add(doc["title"]);
        path.add(doc["path"]);
      }
    });

    var collection = firestore.collection('houseCompetition');
    var docSnapshot = await collection.doc('Hd0zeqJJASpQoo3wjB3V').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      jeoji = data?['jeoji'].toDouble();
      geomun = data?['geomun'].toDouble();
      sarah = data?['sarah'].toDouble();
      mulchat = data?['mulchat'].toDouble();
      noro = data?['noro'].toDouble();
      nextCompetition = data?['nextCompetition'];
    }

    /*await firestore.collection("sport").orderBy('date', descending: true).get().then((QuerySnapshot ds) {
      for (var doc in ds.docs) {
        sport.add(doc["sportsType"]);
        tournament.add(doc["category"]);
        date.add(doc["date"].toDate().toString().substring(0,10));
        isA.add(doc["isA"]);
        isBoy.add(doc["isBoy"]);
        score.add(doc["score"]);
        opp.add(doc["opp"]);
      }
    });*/

    await firestore
        .collection("podcast")
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot ds) {
      for (var doc in ds.docs) {
        podTitle.add(doc["title"]);
        podDate.add(doc["date"].toDate().toString().substring(0, 10));
        podImage.add(doc["imageURL"]);
        podPath.add(doc["path"]);
      }
    });

    for (int i = 0; i < podTitle.length; i++) {
      final ref = FirebaseStorage.instance.ref().child(podImage[i]);
      var url = await ref.getDownloadURL();
      podImg.add(url);

      final ref2 = FirebaseStorage.instance.ref().child(podPath[i]);
      var url2 = await ref2.getDownloadURL();
      podMp3.add(url2);
    }

    notifyListeners();

    return true;
  }
}

class Store2 extends ChangeNotifier {
  final webScraper = WebScraper('https://nlcshub.com');

  late List<List<Map<String, dynamic>>>? title = [[], [], [], [], []];
  late List<List<Map<String, dynamic>>> category = [[], [], [], [], []];
  late List<List<Map<String, dynamic>>> image = [[], [], [], [], []];
  late List<List<Map<String, dynamic>>> read = [[], [], [], [], []];
  late List<List<Map<String, dynamic>>> date = [[], [], [], [], []];

  void fetchData(String url, int index) async {
    if (await webScraper.loadWebPage(url)) {
      title![index] = webScraper.getElement('h1.entry-title', ['class']);
      category[index] = webScraper.getElement(
          'div.meta-category > a.category-style > span.label', ['class']);
      image[index] =
          webScraper.getElement('div.entry-overlay > img', ['src', 'class']);
      read[index] = webScraper.getElement('li.meta-reading-time', ['class']);
      date[index] = webScraper.getElement('li.meta-date', ['class']);
    }
    notifyListeners();
  }
}

class Store3 extends ChangeNotifier {
  List<String> sport = [];
  List<String> tournament = [];
  List<String> date = [];
  List<bool> isA = [];
  List<bool> isBoy = [];
  List<List<dynamic>> score = [];
  List<String> opp = [];
  List<String> logoUrl = [];
  String nlcsUrl = "";
  bool loaded = false;

  Future<bool> getSportsData() async {
    if (loaded == false) {
      sport = [];
      tournament = [];
      date = [];
      isA = [];
      isBoy = [];
      score = [];
      opp = [];
      logoUrl = [];

      await firestore
          .collection("sport")
          .orderBy('date', descending: true)
          .get()
          .then((QuerySnapshot ds) {
        for (var doc in ds.docs) {
          sport.add(doc["sportsType"]);
          tournament.add(doc["category"]);
          date.add(doc["date"].toDate().toString().substring(0, 10));
          isA.add(doc["isA"]);
          isBoy.add(doc["isBoy"]);
          score.add(doc["score"]);
          opp.add(doc["opp"]);
        }
      });

      final nlcs = FirebaseStorage.instance.ref().child('school_logo/nlcs.png');
      nlcsUrl = await nlcs.getDownloadURL();

      for (int i = 0; i < opp.length; i++) {
        final ref =
            FirebaseStorage.instance.ref().child('school_logo/${opp[i]}.png');
        var url = await ref.getDownloadURL();
        logoUrl.add(url);
      }

      loaded = true;

      notifyListeners();

      return true;
    } else {
      return true;
    }
  }
}
