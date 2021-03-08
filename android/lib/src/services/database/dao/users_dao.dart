import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sembast/sembast.dart';

import '../app_database.dart';

class UsersDao{
  static const String folderName = "Users";
  final _userFolder = intMapStoreFactory.store(folderName);
  final _collection = FirebaseFirestore.instance.collection(Constants.USER_COLLECTION);
  final _userId = FirebaseAuth.instance.currentUser;


  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future updateOrInsertPembina() async{
    final snapshot = await _collection.doc(_userId.uid).get();
    await _userFolder.record(0).put(await _db, snapshot.data() );
    print('Student Inserted successfully !!');
  }

  Future<Map<String, dynamic>> readPembina() async {
    return _userFolder.record(0).get(await _db);
  }

  Future updateOrInsertPengasuh() async{
    final snapshot = await _collection.doc(_userId.uid).get();
    await _userFolder.record(0).put(await _db, snapshot.data() );
    print('Student Inserted successfully !!');
  }

  Future<Map<String, dynamic>> readPengasuh() async {
    return _userFolder.record(0).get(await _db);
  }

  Future updateOrInsertSecurity() async{
    final snapshot = await _collection.doc(_userId.uid).get();
    await _userFolder.record(0).put(await _db, snapshot.data() );
    print('Student Inserted successfully !!');
  }

  Future<Map<String, dynamic>> readSecurity() async {
    return _userFolder.record(0).get(await _db);
  }

  Future deleteUsers() async{
    await _userFolder.drop(await _db);
    print('Deleted All Users successfully !!');
  }
}