import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart' as pathpro;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rafik/View/Compenents/theme.dart';

class DownloadContract extends StatefulWidget {
  const DownloadContract({super.key});

  @override
  State<DownloadContract> createState() => _DownloadContractState();
}

class _DownloadContractState extends State<DownloadContract>
    with TickerProviderStateMixin {
  late AnimationController _settingController;

  @override
  void initState() {
    super.initState();

    _settingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _settingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //PdfViewerPlugin.registerWith();

// Pdf view with re-render pdf texture on zoom (not loose quality on zoom)
// Not supported on windows

    return Scaffold(
      //s  appBar: AppBar(),
      backgroundColor: lightgreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              'Download Contract',
              style: Get.textTheme.titleLarge!.copyWith(color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Yay you are one of us now one more step to go now please download this form and fill it then send it to this email to confirm your account',
                  style: Get.textTheme.bodyMedium!.copyWith(color: white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'azzouzmerw@gmail.com',
                  style: Get.textTheme.bodyMedium!.copyWith(color: white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width * 0.5,
              child: Lottie.asset(
                Icons8.download_iOS,
                controller: _settingController,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                elevation: 10,
                minimumSize: Size(Get.width * 0.6, Get.width * 0.15)),
            onPressed: () async {
              print(Platform.isAndroid);
              if (Platform.isAndroid) {
                var status = await Permission.manageExternalStorage.status;
                print("Status is $status");
                if (status != PermissionStatus.granted) {
                  status = await Permission.manageExternalStorage
                      .request()
                      .then((value) {
                    print("Status is $value");

                    return value;
                  });
                } else {
                  if (status.isGranted) {
                    Directory generalDownloadDir = Directory(
                        '/storage/emulated/0/'); //! THIS WORKS for android only !!!!!!

                    var downloadsFolderPath = generalDownloadDir.path;
                    print('The path is $downloadsFolderPath');

                    Directory dir = Directory(downloadsFolderPath);
                    var file = File('${dir.path}/c.pdf');
                    final byteData = await rootBundle.load('assets/c.pdf');
                    try {
                      var rsp = await file.writeAsBytes(byteData.buffer
                          .asUint8List(
                              byteData.offsetInBytes, byteData.lengthInBytes));
                      print(rsp.path);
                      Get.snackbar(
                          'All done', 'Go to Inernal Storage/contract.pdf');
                      Get.offAllNamed('/signup');
                    } on FileSystemException catch (err) {
                      // handle error
                      print(err);
                    }
                  }
                }
              }
            },
            child: Text('Download'),
          ),
        ],
      ),
    );
  }

  Future<List<Directory>?> getExternalStorageDirectories({
    /// Optional parameter. See [StorageDirectory] for more informations on
    /// how this type translates to Android storage directories.
    StorageDirectory? type,
  }) async {
    final List<Directory>? paths =
        await pathpro.getExternalStorageDirectories(type: type);
    if (paths == null) {
      return null;
    }

    return paths;
  }
}
