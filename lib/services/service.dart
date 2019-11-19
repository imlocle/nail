import 'package:n_r_d/sqlite/dbHelper.dart';
import 'package:n_r_d/models/nailArt.dart';

savingToSqlite(String brandName, String colorName, String nailType){
  DBHelper helper = DBHelper();
  NailArt nailArt = NailArt(null, brandName, colorName, nailType);
  helper.insert(nailArt);
}

removeNailArt(int id){
  DBHelper helper = DBHelper();
  helper.delete(id);
}