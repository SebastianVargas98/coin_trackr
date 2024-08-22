import 'package:coin_trackr/core/data/entities/crypto.dart';

class CryptoModel extends Crypto {
  CryptoModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.price,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      price: json['current_price'].toDouble(),
    );
  }
}
