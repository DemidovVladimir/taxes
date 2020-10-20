import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

class LabelScreen extends StatefulWidget {
  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  File _imageFile;
  // List<Barcode> _barcodes;
  // BarcodeDetector barcodeDetector;
  // List<Barcode> barcodes;

  void _detectLabel() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);

    // try {
    //   final FirebaseVisionImage visionImage =
    //       FirebaseVisionImage.fromFile(pickedImageFile);

    //   barcodeDetector = FirebaseVision.instance.barcodeDetector();
    //   barcodes = await barcodeDetector.detectInImage(visionImage);
    // } catch (e) {
    //   print(e);
    //   throw (e);
    // }

    if (mounted) {
      setState(() {
        _imageFile = pickedImageFile;
        // _barcodes = barcodes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[ImageDraw(imageFile: _imageFile)]),
        // ImagesAndLabels(_imageFile, _barcodes),
        floatingActionButton: FloatingActionButton(
          onPressed: _detectLabel,
          tooltip: 'Pick an image',
          child: Icon(Icons.add_a_photo),
        ));
  }

  @override
  void dispose() {
    // barcodeDetector.close();
    super.dispose();
  }
}

class ImagesAndLabels extends StatelessWidget {
  ImagesAndLabels(this.imageFile, this.barcodes);
  final File imageFile;
  final List<Barcode> barcodes;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageDraw(imageFile: imageFile),
        BarcodeViewer(barcodes: barcodes),
      ],
    );
  }
}

class BarcodeViewer extends StatelessWidget {
  const BarcodeViewer({
    Key key,
    @required this.barcodes,
  }) : super(key: key);

  final List<Barcode> barcodes;

  @override
  Widget build(BuildContext context) {
    if (barcodes != null) {
      return Flexible(
          flex: 1,
          child: Container(
              constraints: BoxConstraints.expand(),
              child: ListView.builder(
                  itemCount: barcodes.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new Text('barcodes[index].toString()');
                  })));
    } else {
      return Flexible(
        flex: 1,
        child: Container(
            constraints: BoxConstraints.expand(), child: Text('Barcodes...')),
      );
    }
  }
}

class ImageDraw extends StatelessWidget {
  const ImageDraw({
    Key key,
    @required this.imageFile,
  }) : super(key: key);

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return Flexible(
          flex: 1,
          child: Container(
              constraints: BoxConstraints.expand(),
              child: Image.file(imageFile, fit: BoxFit.cover)));
    } else {
      return Flexible(
          flex: 1,
          child: Container(
              constraints: BoxConstraints.expand(),
              child: Text('Parse image here...')));
    }
  }
}
