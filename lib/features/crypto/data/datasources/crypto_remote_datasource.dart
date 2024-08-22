import 'dart:convert';

import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/features/crypto/data/models/crypto_model.dart';
import 'package:http/http.dart' as http;

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> getCryptoList();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final http.Client client;

  CryptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CryptoModel>> getCryptoList() async {
    final response = await client.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CryptoModel.fromJson(json)).toList();
    } else {
      throw const ServerException('Error loading cryptos');
    }
  }
}
