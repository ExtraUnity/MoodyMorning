//import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:moody_morning/widgets/logo_app_bar.dart';




class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState(){
    startCamera();
    super.initState();
  }

  void startCamera() async{
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0], 
      ResolutionPreset.high,
            enableAudio: false
      );

    await cameraController.initialize().then((value){
      if (!mounted){
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e){
      print(e);
  
    });
  
  }
  @override
  void dispose(){
    cameraController.dispose();
    super.dispose();
  }

class SolveQRcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(cameraController.value.isInitialized){
      return Scaffold(
          body: Stack(
            children: [
              CameraPreview(cameraController),
            ],
          ),
      );
    } else {
      return const SizedBox();

  }
}
}