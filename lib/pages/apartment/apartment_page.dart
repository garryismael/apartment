import 'package:flutter/material.dart';
import 'package:prestation/constants/service.dart';
import 'package:prestation/models/apartment.dart';
import 'package:prestation/services/services.dart';

class ApartmentPage extends StatelessWidget {
  const ApartmentPage({super.key});

  Future<List<Apartment>> getData() async {
    var service = Service<Apartment>(Apartment.init(), urlApartment);
    return await service.list();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: const TextStyle(fontSize: 16),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: cards(snapshot.data),
              ),
            ),
          );
        }
      },
    );
  }

  List<Card> cards(List<Apartment>? d) {
    return d!.map((e) => buildCard(e)).toList();
  }

  Card buildCard(Apartment? apartment) {
    var heading = '\$${apartment?.price} per month';
    var subheading = '${apartment?.pieces} pieces';

    String? url = apartment?.getImageUrl();
    var cardImage = NetworkImage(url!);
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(heading),
            subtitle: Text(subheading),
            trailing: const Icon(
              Icons.favorite_outline,
            ),
          ),
          SizedBox(
            height: 200.0,
            child: Ink.image(
              image: cardImage,
              fit: BoxFit.cover,
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('LEARN MORE'),
                onPressed: () {/* ... */},
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ApartmentFormPage extends StatelessWidget {
  const ApartmentFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApartmentPage extends StatelessWidget {
  const MyApartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
