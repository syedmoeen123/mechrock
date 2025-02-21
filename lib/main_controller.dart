import 'dart:ffi';
import 'dart:io';

import 'package:get/get_rx/get_rx.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'package:image/image.dart';


import 'package:image_picker/image_picker.dart';

import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/services.dart';

import 'animation.dart';
import 'image_information.dart';





class controller extends GetxController{

  RxString selectedImagePath=''.obs;
  RxString title="".obs;
  List<String> labels=['Biotite' ,'Bornite', 'Chrysocolla' ,'Malachite' ,'Muscovite' ,'Pyrite',
      'Quartz'];
  List<double> out=[0.0];


  Future getImageFromCamere() async{
    final ImagePicker picker =ImagePicker();
    final image= await picker.pickImage(source:ImageSource.camera);
    if(image?.path!=null){
      selectedImagePath.value=image?.path.toString()?? '';
    }



  }

  Future getImageFromGallery() async{
    final ImagePicker picker =ImagePicker();
    final image= await picker.pickImage(source:ImageSource.gallery);
    if(image?.path!=null){
      selectedImagePath.value=image?.path.toString()?? '';
    }



  }


  // Future<List<List<List<List<double>>>>?> preprocessImage(String path) async {
  //   try {
  //     // Load the image
  //     File imageFile = File(path);
  //     Uint8List imageBytes = await imageFile.readAsBytes();
  //
  //     // Decode and resize the image
  //     img.Image? image = img.decodeImage(imageBytes);
  //     if (image == null) throw Exception('Failed to decode image');
  //     img.Image resizedImage = img.copyResize(image, width: 150, height: 150);
  //
  //     // Create a tensor of shape [1, 150, 150, 3] and fill it with normalized pixel values
  //     List<List<List<List<double>>>> tensor = List.generate(1, (_) =>
  //         List.generate(150, (_) =>
  //             List.generate(150, (_) =>
  //                 List.generate(3, (_) => 0.0))));
  //
  //     // Populate the tensor with normalized RGB values (divide by 255 to normalize)
  //     for (int i = 0; i < 150; i++) {
  //       for (int j = 0; j < 150; j++) {
  //         Pixel pixel = resizedImage.getPixelSafe(j, i); // Safe pixel access
  //
  //         // Extract RGB components from the pixel
  //         tensor[0][i][j][0] = ((pixel >> 16) & 0xFF) / 255.0; // Red
  //         tensor[0][i][j][1] = ((pixel >> 8) & 0xFF) / 255.0;  // Green
  //         tensor[0][i][j][2] = (pixel & 0xFF) / 255.0;         // Blue
  //       }
  //     }
  //
  //     return tensor;
  //   } catch (e) {
  //     print('Error preprocessing image: $e');
  //     return null;
  //   }
  // }
  Future<Uint8List> imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) async {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = pixel.r  / 255;
        buffer[pixelIndex++] = pixel.g  / 255;
        buffer[pixelIndex++] = pixel.b  / 255;
      }
    }

    return convertedBytes.buffer.asUint8List();
  }




  String getPredictedLabel(List<double> output, List<String> labels) {
    // Find the index with the maximum value in the model output
    int predictedIndex = output.indexWhere((element) => element == output.reduce((a, b) => a > b ? a : b));

    // Return the corresponding label
    return labels[predictedIndex];
  }


  void delay(){

    Future.delayed(Duration(seconds: 2), () {
      // This code will run after 2 seconds
      Get.off(ImageInfoPage());
    });
  }



  Future<void> get_label(String inputPath) async {
    try {
      // Load the TensorFlow Lite model
      final interpreter = await tfl.Interpreter.fromAsset('assets/models/model2.tflite');

      // Preprocess the image (await the Future result)
      File imageFile = File(inputPath);
      Uint8List imageBytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      var input = await imageToByteListFloat32(image!,224,127.5,127.5);

      // Ensure input is not null (error handling)
      if (input == null) {
        throw Exception("Failed to preprocess the image");
      }

      // Prepare the output buffer (in this case 1 batch, 7 classes)
      var output = List.filled(1 * 7, 0).reshape([1, 7]);

      // Run the interpreter with the input and output tensors
      interpreter.run(input, output);
      out=output[0];













      // Optionally, print the model's output
      print("Model output: $output");

      // Close the interpreter to free resources
      interpreter.close();

      Get.to(Animation());



    } catch (e) {
      print("Error running model inference: $e");
    }
  }


  void get_largest(){

    int index=0;
    double largest=out[0];
    for (int i=0;i<out.length;i++){

      if(largest < out[i]){
        largest=out[i];
        index=i;
      }

    }

    title.value=labels[index];
    print(title.value);
    update();

  }



}

