import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController {

  compressVideoFile(String videoFilePah) async {
    final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePah, quality: VideoQuality.LowQuality);
    return compressedVideoFilePath!.file;
  }


}