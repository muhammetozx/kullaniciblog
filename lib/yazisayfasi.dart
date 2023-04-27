import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YaziEkrani extends StatefulWidget {
  @override
  State<YaziEkrani> createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    FirebaseFirestore.instance.collection('Yazilar').doc(t1.text).set({
      'kullaniciId': auth.currentUser?.uid,
      'baslik': t1.text,
      'icerik': t2.text
    });
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection('Yazilar')
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text});
  }

  yaziSil() {
    FirebaseFirestore.instance.collection('Yazilar').doc(t1.text).delete();
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection('Yazilar')
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()?['baslik'];
        gelenYaziIcerigi = gelenVeri.data()?['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: t1,
            ),
            SizedBox(height: 30),
            TextField(
              controller: t2,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        yaziEkle();
                      },
                      child: Text("Ekle")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        yaziGuncelle();
                      },
                      child: Text("Güncelle")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        yaziSil();
                      },
                      child: Text("Sil")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        yaziGetir();
                      },
                      child: Text("Göster")),
                ],
              ),
            ),
            ListTile(
              title: Text(gelenYaziBasligi),
              subtitle: Text(gelenYaziIcerigi),
            ),
          ],
        ),
      ),
    );
  }
}
