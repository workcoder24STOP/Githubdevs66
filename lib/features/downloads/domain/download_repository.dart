import 'package:shonenx/features/offline/catalog_snapshot.dart';
import 'package:isar_community/isar.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';

class DownloadRepository {
  final Isar _isar;

  DownloadRepository(this._isar);

  Future<void> putTask(DownloadTask task) async {
    task.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.downloadTasks.put(task);
    });
    await CatalogSnapshot.write(task);
  }

  Future<DownloadTask?> getByCatalogKey(String key) =>
      _isar.downloadTasks.filter().catalogKeyEqualTo(key).findFirst();

  Future<List<DownloadTask>> getAll() => _isar.downloadTasks.where().findAll();

  Future<void> updateReading(Id id, int page, {List<int>? bookmarks}) async {
    final saved = await _isar.writeTxn(() async {
      final task = await _isar.downloadTasks.get(id);
      if (task == null) return null;
      task.readingPage = task.localPages.isEmpty
          ? 0
          : page.clamp(0, task.localPages.length - 1);
      if (bookmarks != null) task.bookmarks = bookmarks;
      await _isar.downloadTasks.put(task);
      return task;
    });
    if (saved != null) await CatalogSnapshot.write(saved);
  }

  Future<void> updatePlayback(Id id, int milliseconds) async {
    final saved = await _isar.writeTxn(() async {
      final task = await _isar.downloadTasks.get(id);
      if (task == null) return null;
      task.playbackMs = milliseconds;
      await _isar.downloadTasks.put(task);
      return task;
    });
    if (saved != null) await CatalogSnapshot.write(saved);
  }

  Future<void> deleteTask(Id id) async {
    final task = await getTaskById(id);
    if (task != null) await CatalogSnapshot.remove(task);
    await _isar.writeTxn(() async {
      await _isar.downloadTasks.delete(id);
    });
  }

  Future<DownloadTask?> getTaskByUrl(String url) async {
    return await _isar.downloadTasks.filter().urlEqualTo(url).findFirst();
  }

  Future<DownloadTask?> getTaskById(Id id) async {
    return await _isar.downloadTasks.get(id);
  }

  Future<List<DownloadTask>> getPendingOrPausedTasks() async {
    return await _isar.downloadTasks
        .filter()
        .statusBetween(DownloadStatus.pending, DownloadStatus.paused)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<DownloadTask>> getUnfinishedTasks() async {
    return await _isar.downloadTasks
        .filter()
        .not()
        .statusEqualTo(DownloadStatus.completed)
        .findAll();
  }

  Stream<List<DownloadTask>> watchAllTasks() {
    return _isar.downloadTasks.where().sortByCreatedAtDesc().watch(
      fireImmediately: true,
    );
  }
}
