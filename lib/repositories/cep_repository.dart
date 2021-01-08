import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error("CEP Inválido!");
    }

    final clearCep = cep.replaceAll(RegExp("[^0-9]"), "");

    if (clearCep.length != 8) {
      return Future.error("CEP Inválido!");
    }

    try {
      final endpoint = "http://www.viacep.com.br/ws/$clearCep/json";

      final response = await Dio().get<Map>(endpoint);

      if (response.data.containsKey("erro") && response.data["erro"] == true) {
            return Future.error("CEP Inválido!");
          }

      final ufList = await IBGERepository().getUFListFromApi();

      return Address(
              cep: response.data["cep"],
              district: response.data["bairro"],
              uf: ufList.firstWhere((uf) => uf.initials == response.data["uf"]),
              city: City(name: response.data["localidade"]));
    } catch (e) {
      Future.error("Falha ao buscar CEP");
    }
  }
}
