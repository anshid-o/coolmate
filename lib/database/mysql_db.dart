import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:coolmate/database/firestore_db.dart';
import 'package:mysql_client/mysql_client.dart';

Future<void> registerDB(String user, String password) async {
  print("Connecting to mysql server...");

  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  print("Connected");

  // update some rows

  // insert some rows
  await conn.execute(
    "INSERT INTO user ( email, password) VALUES ( :email, :password)",
    {
      "email": user,
      "password": password,
    },
  );

  // close all connections
  await conn.close();
}

Future<void> getUsers() async {
  print("Connecting to mysql server...");

  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  print("Connected");

  // update some rows

  // insert some rows
  var result = await conn.execute("SELECT * FROM user");

  // print query result
  for (final row in result.rows) {
    row.assoc().forEach((key, value) {
      print(key);
      print(value);
    });
  }

  // close all connections
  await conn.close();
}

//Update local from cloud-------------------------
Future<void> updateMysqlUsers() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    print('mysql updated');
    List<String?> datasM = await collectMysqlUsersEmail();

    List<Map<String, dynamic>> datasF = await collectFirebaseusersFull();

    List<List<String?>> emails = [];
    // for (var element in datasM) {
    //   emails.add([element.colByName('email'), element.colByName('password')]);
    // }
    datasF.forEach((element) {
      emails.add([element['email'], element['password']]);
    });

    emails.forEach((element) async {
      if (!datasM.contains(element[0])) {
        print(element);
        registerDB(element[0]!, element[1]!);
      }
    });
  } else {
    print('not connected ----- no updation');
  }
}

Future<List<ResultSetRow>> collectMysqlUsers() async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result = await conn.execute("SELECT * FROM user");
  List<ResultSetRow> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row);
  }

  // close all connections
  await conn.close();
  return datas;
}

Future<List<String?>> collectMysqlUsersEmail() async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result = await conn.execute("SELECT * FROM user");
  List<String?> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row.assoc()['email']);
  }

  // close all connections
  await conn.close();
  return datas;
}

//-------------------------------preload

Future<void> storePreloadCustomerDB(String name, String adr, String phone,
    String st, String tin, String tname) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  await conn.execute(
    "INSERT INTO $tname ( name, address,phone,state,tin) VALUES ( :name, :address, :phone, :state, :tin)",
    {"name": name, "address": adr, "phone": phone, "state": st, "tin": tin},
  );

  // close all connections
  await conn.close();
}

Future<List<List<String>>> getPreloadCustomerDB(String tname) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result = await conn.execute("SELECT * FROM $tname");
  List<ResultSetRow> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row);
  }
  List<List<String>> customers = [];
  // close all connections
  await conn.close();
  datas.forEach((element) {
    List<String> x = [];
    element.assoc().forEach((key, value) {
      x.add(value!);
    });
    customers.add(x);
  });

  return customers;
}

Future<List<String>> getSingleFromDB(String tname, {col = 'name'}) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result = await conn.execute("SELECT $col FROM $tname");

  List<ResultSetRow> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row);
  }
  List<String> x = [];
  // close all connections
  await conn.close();
  datas.forEach((element) {
    element.assoc().forEach((key, value) {
      x.add(value!);
    });
  });

  return x;
}

Future<void> storeSingleDB(String name, String tname) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  await conn.execute(
    "INSERT INTO $tname ( name) VALUES ( :name)",
    {"name": name},
  );

  // close all connections
  await conn.close();
}

Future<void> updatePreloadData(String tname, String n2, String a, String p,
    String s, String t, String n) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  await conn.execute(
      "UPDATE $tname SET name = :n2, address = :a, phone = :p, state = :s, tin = :t WHERE name = :n",
      {'n2': n2, 'a': a, 'p': p, 's': s, 't': t, 'n': n});
}

Future<List<List<String>>> deletePreloadData(String tname, String n) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result =
      await conn.execute("DELETE FROM $tname  WHERE name = :n", {'n': n});
  List<ResultSetRow> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row);
  }
  List<List<String>> customers = [];
  // close all connections
  await conn.close();
  datas.forEach((element) {
    List<String> x = [];
    element.assoc().forEach((key, value) {
      x.add(value!);
    });
    customers.add(x);
  });

  return customers;
}

//Item

Future<void> storeItemDB(String b, String c, String u, String name, String gst,
    String rp, String p, String q) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows

  await conn.execute(
    "INSERT INTO items(brand,category,unit,name,gst,rprice,mrp,Qty)  VALUES ( :b, :c, :u, :name, :gst, :rp, :p, :q)",
    {
      "b": b,
      "c": c,
      "u": u,
      "name": name,
      "gst": int.parse(gst),
      "rp": int.parse(rp),
      "p": int.parse(p),
      "q": int.parse(q)
    },
  );

  // close all connections
  await conn.close();
}

//stock

Future<void> storeStockDB(
  int b,
  String u,
  String name,
  int gst,
  int rp,
  int p,
  int q,
  int x,
  int a,
  int aa,
  int bb,
  String k,
  int cc,
) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows

  await conn.execute(
    "INSERT INTO stocks VALUES ( :b,  :u, :name, :gst, :rp, :p, :q, :x, :a, :aa, :bb, :k, :cc)",
    {
      "b": b,
      "u": u,
      "name": name,
      "gst": gst,
      "rp": rp,
      "p": p,
      "q": q,
      "x": x,
      "a": a,
      "aa": aa,
      "bb": bb,
      "k": k,
      "cc": cc,
    },
  );

  // close all connections
  await conn.close();
}

//stocks

Future<List<List<String>>> getStocksDB(String inv) async {
  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "anshid",
    password: "Anshid@2002",
    databaseName: "coolmate", // optional
  );

  await conn.connect();

  // update some rows

  // insert some rows
  var result = await conn.execute(
      "SELECT itemId, price, Qty, discount, cess, credit, transfEst, interState, branchTansIn FROM  stocks where invNo='$inv'");
  List<ResultSetRow> datas = [];
  // print query result
  for (final row in result.rows) {
    datas.add(row);
  }
  List<List<String>> customers = [];
  // close all connections
  await conn.close();
  datas.forEach((element) {
    List<String> x = [];
    element.assoc().forEach((key, value) {
      x.add(value!);
    });
    customers.add(x);
  });

  return customers;
}
