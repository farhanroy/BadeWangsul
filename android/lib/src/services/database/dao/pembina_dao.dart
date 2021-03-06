import 'package:bade_wangsul/src/models/models.dart';
import 'package:sembast/sembast.dart';

import '../app_database.dart';

class UsersDao{
  static const String folderName = "Users";
  final _userFolder = intMapStoreFactory.store(folderName);


  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insertPembina(Pembina pembina) async{

    await _userFolder.add(await _db, pembina.toJson() );
    print('Student Inserted successfully !!');
  }

  Future deleteUsers() async{
    await _userFolder.drop(await _db);
    print('Deleted All Users successfully !!');
  }
}