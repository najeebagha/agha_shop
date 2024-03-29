// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:agha_shop/model/produc_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../model/category_model.dart';
import '../../utils/styles.dart';
import '../../widgets/agha_button.dart';
import '../../widgets/agha_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String id = "addproduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;

  String? selectedValue;
  bool isSaving = false;
  bool isUploading = false;

  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Column(
                children: [
                  const Text(
                    "ADD PRODUCT",
                    style: AghaStyle.boldStyle,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField(
                        hint: const Text("choose category"),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "category must be selected";
                          }
                          return null;
                        },
                        value: selectedValue,
                        items: categories
                            .map((e) => DropdownMenuItem<String>(
                                value: e.title, child: Text(e.title!)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        }),
                  ),
                  AghaTextField(
                    controller: productNameC,
                    hintText: "enter product name...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaTextField(
                    maxLines: 5,
                    controller: detailC,
                    hintText: "enter product detail...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaTextField(
                    controller: priceC,
                    hintText: "enter product price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaTextField(
                    controller: discountPriceC,
                    hintText: "enter product discount Price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaTextField(
                    controller: serialCodeC,
                    hintText: "enter product serial code...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaTextField(
                    controller: brandC,
                    hintText: "enter product brand...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  AghaButton(
                    title: "PICK IMAGES",
                    onPress: () {
                      pickImage();
                    },
                    isLoginButton: true,
                  ),
                  // EcoButton(
                  //   title: "UPLOAD IMAGES",
                  //   isLoading: isUploading,
                  //   onPress: () {
                  //     uploadImages();
                  //   },
                  //   isLoginButton: true,
                  // ),
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SwitchListTile(
                      title: const Text("Is this Product on Sale?"),
                      value: isOnSale,
                      onChanged: (v) {
                        setState(() {
                          isOnSale = !isOnSale;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Is this Product Popular?"),
                      value: isPopular,
                      onChanged: (v) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      }),
                  AghaButton(
                    title: "SAVE",
                    isLoginButton: true,
                    onPress: () {
                      save();
                    },
                    isLoading: isSaving,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.addProducts(Products(
            category: selectedValue,
            id: uuid.v4(),
            brand: brandC.text,
            productName: productNameC.text,
            detail: detailC.text,
            price: int.parse(priceC.text),
            discountPrice: int.parse(discountPriceC.text),
            serialCode: serialCodeC.text,
            imageUrls: imageUrls,
            isSale: isOnSale,
            isPopular: isPopular,
            isFavourite: isFavourite))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        imageUrls.clear();
        images.clear();
        clearFields();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
      });
    });
    // await FirebaseFirestore.instance
    //     .collection("products")
    //     .add({"images": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    // });
  }

  clearFields() {
    setState(() {
      // selectedValue = "";
      productNameC.clear();
    });
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      log("no images selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downLoadUrl) => imageUrls.add(downLoadUrl));
    }
  }
}
