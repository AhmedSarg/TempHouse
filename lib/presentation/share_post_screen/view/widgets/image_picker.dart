import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/share_post_screen/viewmodel/share_view_model.dart';

class ImagePickerField extends StatefulWidget {
  final void Function(String) onImagePicked; // Define the callback

  const ImagePickerField({
    super.key,
    required this.onImagePicked,
    required this.viewModel,
  });

  final ShareViewModel viewModel;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  Future<void> _getImagesFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var pickedFile in pickedFiles) {
        if (widget.viewModel.getImages.length < 10) {
          widget.onImagePicked(
            pickedFile.path);
        }
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _getImagesFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      widget.onImagePicked(
          pickedFile.path); // Invoke the callback with the image path
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.viewModel.getImages.length);
    return FormField(
      validator: (_) {
        if (widget.viewModel.getImages.isEmpty) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      builder: (errorContext) => Container(
        height: AppSize.s120,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: errorContext.hasError
                  ? ColorManager.error
                  : ColorManager.grey),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (widget.viewModel.getImages.length < 10) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.photo_library),
                              onPressed: () {
                                _getImagesFromGallery(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () {
                                _getImagesFromCamera(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.add_photo_alternate,
                size: AppSize.s50,
                color: Colors.grey,
              ),
            ),
            Text(
              AppStrings.addPhotos.tr(),
              style: AppTextStyles.sharePostTextStyle(context),
            )
          ],
        ),
      ),
    );
  }
}
