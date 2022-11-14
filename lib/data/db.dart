import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class localDb {
  localDb._();
  static final localDb db = localDb._();
  late Database _database;
  Future<Database> initDb(String timeStamp) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, timeStamp);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS Admin(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,password TEXT,contact TEXT, role Roles NOT NULL DEFAULT agent,  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,CONSTRAINT Admin_pkey PRIMARY KEY (id));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS User(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT NOT NULL,password TEXT,createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,  CONSTRAINT User_pkey PRIMARY KEY (id));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS ServiceType(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,price DECIMAL(65,30) DEFAULT 0,createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP(3) NOT NULL,CONSTRAINT ServiceType_pkey PRIMARY KEY (id)   );");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS Service(id INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT NOT NULL,amountTendered DECIMAL(65,30) NOT NULL DEFAULT 0, amount DECIMAL(65,30) NOT NULL DEFAULT 0,balance DECIMAL(65,30) DEFAULT 0, adminId TEXT NOT NULL, createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP(3) NOT NULL,activeness BOOLEAN NOT NULL DEFAULT true, CONSTRAINT Service_pkey PRIMARY KEY (id));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS servicePatronised( serviceId TEXT NOT NULL,serviceTypeId TEXT NOT NULL, assignedAt TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,CONSTRAINT servicePatronised_pkey PRIMARY KEY (serviceId,serviceTypeId));");
      await db.execute(
          'CREATE TABLE Winner(id TEXT NOT NULL, userId TEXT NOT NULL, createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP(3) NOT NULL,CONSTRAINT Winner_pkey PRIMARY KEY (id))');

      await db.execute('ALTER TABLE "Service" ADD CONSTRAINT "Service_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE');
      await db.execute('ALTER TABLE "Service" ADD CONSTRAINT "Service_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE');
     await db.execute('ALTER TABLE "servicePatronised" ADD CONSTRAINT "servicePatronised_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE');
       await db.execute('ALTER TABLE "servicePatronised" ADD CONSTRAINT "servicePatronised_serviceTypeId_fkey" FOREIGN KEY ("serviceTypeId") REFERENCES "ServiceType"("id") ON DELETE RESTRICT ON UPDATE CASCADE');
           await db.execute('ALTER TABLE "Winner" ADD CONSTRAINT "Winner_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE');
    });
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb(".ds");
    return _database;
  }
}
