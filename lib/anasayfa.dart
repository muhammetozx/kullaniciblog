import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TumYazilar(),
    );
  }
}

class TumYazilar extends StatefulWidget {
  @override
  _TumYazilarState createState() => _TumYazilarState();
}

class _TumYazilarState extends State<TumYazilar> {
  final Stream<QuerySnapshot> blogYazilari =
      FirebaseFirestore.instance.collection('Yazilar').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: blogYazilari,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['baslik']),
              subtitle: Text(data['icerik']),
            );
          }).toList(),
        );
      },
    );
  }
}
