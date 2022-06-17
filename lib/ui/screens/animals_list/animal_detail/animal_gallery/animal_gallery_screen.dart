// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../custom_widgets/dialogs/gallery_confirmation_dialog.dart';
import '../../../../custom_widgets/dialogs/image_capture_option_dialog.dart';
import '../../../../custom_widgets/image_container.dart';
import 'animal_gallery_view_model.dart';

class AnimalGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalGalleryViewModel>(
      builder: (context, model, child) => Scaffold(
        body: GridView.builder(
          shrinkWrap: true,
          primary: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: model.animalGallery.length,
          itemBuilder: (context, index) => InkWell(
            onLongPress: () async {
              bool? isDelete = await Get.dialog(GalleryConfirmationDialog());

              if (isDelete != null) {
                if (isDelete) {
                  ///Todo: delete this image from list and fire store too
                  model.deleteAnimalGallery(index);
                } else {
                  ///Todo: Set This Image as a default images
                  model.updateAnimalGallery(index);
                }
              }
            },
            child: model.animalGallery[index].path == null
                ? ImageContainer(
                    width: 100.w,
                    height: 100.h,
                    url: model.animalGallery[index].imageUrl,
                    fit: BoxFit.fill,
                  )
                : Image(
                    image: FileImage(
                      model.animalGallery[index].path!,
                    ),
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            if (model.animalGallery.length > 20) {
              Get.snackbar("Limit Exceed",
                  "your gallery limit is exceeded kindly delete image from gallery",
                  colorText: Colors.white, backgroundColor: primaryColor);
            } else {
              bool? isDone = await Get.dialog(ImageCaptureOptionDialog());

              if (isDone != null) {
                if (isDone) {
                  model.pickImageFromCamera();
                } else if (!isDone) {
                  model.pickImageFromGallery();
                }
              }

            }
          },
          child: Icon(
            Icons.camera,
            size: 25.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
