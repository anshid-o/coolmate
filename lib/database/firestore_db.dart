import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:coolmate/const.dart';
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

  querySnapshot.forEach((document) {
    datas.add(document.map);
  });

  for (var element in datas) {
    element.forEach((key, value) {
      print('$key : $value');
    });
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
    element.forEach((key, value) {
      print('$key : $value');
    });
  }
}

Future<List<String>> collectFirebaseusers() async {
  Firestore firestore = Firestore.instance;

  List<String> datas = [];

  await firestore.collection('user').get().then((e) {
    e.forEach((element) {
      // print(element);
      datas.add(element.map['email']);
    });
  });

  return datas;
}

Future<void> updateFirebaseUsers() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    print('cloud updated');
    List<ResultSetRow> datasM = await collectMysqlUsers();
    List<String> datasF = await collectFirebaseusers();

    List<List<String?>> emails = [];
    for (var element in datasM) {
      emails.add([element.colByName('email'), element.colByName('password')]);
    }

    emails.forEach((element) async {
      if (!datasF.contains(element[0])) {
        print('----------${element[0]} added to cloud-------');
        await setUsers(element[0], element[1]);
      } else {
        print('${element[0]} already exist in cloud');
      }
    });
  } else {
    print('not connected ----- no updation');
  }
}
