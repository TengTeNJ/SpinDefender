import 'dart:io';
import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

/// 1. 本地视频 → Uint8List（内存）
Future<Uint8List?> generateThumbData(String videoPath) async {
  try {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      quality: 80,
      timeMs: 0,          // 第 0 毫秒
    );
  } catch (e) {
    print('generateThumbData error: $e');
    return null;
  }
}

/// 2. 本地视频 → File（磁盘）
Future<File?> generateThumbFile(String videoPath) async {
  try {
    final tmpDir = await getTemporaryDirectory();
    final outPath = '${tmpDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final result = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: outPath,
      imageFormat: ImageFormat.JPEG,
      quality: 80,
      timeMs: 0,
    );
    return result == null ? null : File(result);
  } catch (e) {
    print('generateThumbFile error: $e');
    return null;
  }
}

// /// 3. 可选：把封面保存到相册
// Future<bool> saveThumbToGallery(File thumbFile) async {
//   final result = await ImageGallerySaver.saveFile(thumbFile.path);
//   return result['isSuccess'] ?? false;
// }