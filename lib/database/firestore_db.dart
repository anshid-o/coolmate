import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:firedart/firedart.dart';
import 'package:mysql_client/mysql_client.dart';

Future<void> setUsers(email, pass) async {
  Firestore firestore = Firestore.instance;

  firestore
      .collection('user')
      .document('Document of $email')
      .set({'email': email, 'password': pass});
}

Future<void> getItems() async {
  Firestore firestore =
      Firestore.instance; // Get the default Firestore instance

  List<Map<String, dynamic>> datas = [];

  final querySnapshot = await firestore.collection('items').get();

  for (var document in querySnapshot) {
    datas.add(document.map);
  }

  for (var element in datas) {
    element.forEach((key, value) {});
  }
}

Future<void> checkUsers() async {
  Firestore firestore = Firestore.instance;

  List<Map<String, dynamic>> datas = [];

  await firestore.collection('user').get().then((value) {
    for (var element in value) {
      datas.add(element.map);
    }
  });

  for (var element in datas) {
    element.forEach((key, value) {});
  }
}

Future<List<String>> collectFirebaseusers() async {
  Firestore firestore = Firestore.instance;

  List<String> datas = [];

  await firestore.collection('user').get().then((e) {
    for (var element in e) {
      // print(element);
      datas.add(element.map['email']);
    }
  });

  return datas;
}

Future<List<Map<String, dynamic>>> collectFirebaseusersFull() async {
  Firestore firestore = Firestore.instance;

  List<Map<String, dynamic>> datas = [];

  await firestore.collection('user').get().then((e) {
    for (var element in e) {
      // print(element);
      datas.add(element.map);
    }
  });

  return datas;
}

Future<void> updateFirebaseUsers() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    List<ResultSetRow> datasM = await collectMysqlUsers();
    List<String> datasF = await collectFirebaseusers();

    List<List<String?>> emails = [];
    for (var element in datasM) {
      emails.add([element.colByName('email'), element.colByName('password')]);
    }

    emails.forEach((element) async {
      if (!datasF.contains(element[0])) {
        await setUsers(element[0], element[1]);
      }
    });
  } else {}
}
