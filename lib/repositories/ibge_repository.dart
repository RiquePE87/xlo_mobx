import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUFListFromApi() async {
    final preference = await SharedPreferences.getInstance();

    if (preference.containsKey("UF_LIST")) {
      final jsonList = json.decode(preference.get("UF_LIST"));

      return jsonList.data.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }

    const endPoint =
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados";

    try {
      final response = await Dio().get<List>(endPoint);

      final ufList = response.data.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      preference.setString("UF_LIST", json.encode(response.data));

      return ufList;
    } on DioError {
      return Future.error("Falha ao obter os dados");
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final String endPoint =
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios";

    try {
      final response = await Dio().get<List>(endPoint);

      final cityList = response.data.map<City>((j) => City.fromJson(j)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return cityList;
    } on DioError {
      return Future.error("Erro ao obter lista de cidades");
    }
  }
}
