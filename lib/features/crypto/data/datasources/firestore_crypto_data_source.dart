import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_trackr/core/common/error/exceptions.dart';

abstract class FirestoreCryptoDataSource {
  Future<void> setCryptoAsFavorite(
    String userId,
    String cryptoId,
  );

  Future<List<String>> getUserFavoritesCryptos(String userId);

  Future<void> deleteFavoriteCrypto(String userId, String cryptoId);
}

class FirestoreCryptoDataSourceImpl implements FirestoreCryptoDataSource {
  final FirebaseFirestore firestore;

  FirestoreCryptoDataSourceImpl({required this.firestore});

  @override
  Future<List<String>> getUserFavoritesCryptos(String userId) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final snapshot = await userDoc.collection('favorites').get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw const ServerException('Failed to get user favorites cryptos');
    }
  }

  @override
  Future<void> setCryptoAsFavorite(
    String userId,
    String cryptoId,
  ) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userDoc.collection('favorites').doc(cryptoId).set({
        'id': cryptoId,
      });
    } catch (e) {
      throw const ServerException('Failed to set crypto as favorite');
    }
  }

  @override
  Future<void> deleteFavoriteCrypto(String userId, String cryptoId) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userDoc.collection('favorites').doc(cryptoId).delete();
    } catch (e) {
      throw const ServerException('Failed to delete favorite crypto');
    }
  }
}
