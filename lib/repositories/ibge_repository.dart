import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUFListFromApi() async {
    const endPoint =
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados";

    try {
      final response = await Dio().get<List>(endPoint);

      final ufList = response.data.map<UF>((j) => UF.fromJson(j)).toList()
      ..sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return ufList;
    } on DioError {
      return Future.error("Falha ao obter os dados");
    }
  }

  getCityListFromApi() {}
}
