import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class CategoryRepository{

  Future<List<Category>> getList() async{
    final query = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);
    final response = await query.query();

    if (response.success){
      return response.results.map((p) => Category.fromParseServer(p)).toList();
    }else{
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}