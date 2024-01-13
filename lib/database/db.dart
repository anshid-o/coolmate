import 'package:mysql_client/mysql_client.dart';

Future<void> registerDB(String name, String user, String password) async {
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
    "INSERT INTO user (name, user, password) VALUES (:name, :user, :password)",
    {
      "name": name,
      "user": user,
      "password": password,
    },
  );

  // close all connections
  await conn.close();
}
