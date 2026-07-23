import '../../local/database/app_database.dart';

class FavoriteRepository {
  final AppDatabase _database;

  FavoriteRepository(this._database);

  Future<void> addFavorite(String jobId) async {
    await _database.addToFavorites(
      FavoriteEntityCompanion.insert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        jobId: jobId,
        savedAt: DateTime.now(),
      ),
    );
  }

  Future<void> removeFavorite(String jobId) =>_database.removeFromFavorites(jobId);

  Future<bool> isFavorite(String jobId) async {
    final favorites = await _database.getAllFavorites();
    return favorites.any((f) => f.jobId == jobId);
  }

  Future<int> getFavoriteCount() async {
    final favorites = await _database.getAllFavorites();
    return favorites.length;
  }
}
