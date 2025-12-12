import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_meal.dart';

class FavoritesService {
  final _db = FirebaseFirestore.instance;
  final _collection = 'favorites';

  Future<void> addFavorite(FavoriteMeal meal) async {
    await _db.collection(_collection).doc(meal.id).set(meal.toJson());
  }

  Future<void> removeFavorite(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  Stream<List<FavoriteMeal>> getFavorites() {
    return _db.collection(_collection).snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => FavoriteMeal.fromJson(doc.data()))
          .toList(),
    );
  }
}
