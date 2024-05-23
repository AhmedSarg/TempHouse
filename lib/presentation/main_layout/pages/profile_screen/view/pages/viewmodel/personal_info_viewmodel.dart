import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_house/domain/usecase/change_account_info_usecase.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../../../../../app/sl.dart';
import '../../../../../../../data/network/failure.dart';

class PersonalInfoViewModel extends BaseCubit
    implements PersonalInfoViewModelInput, PersonalInfoViewModelOutput {
  static PersonalInfoViewModel get(context) => BlocProvider.of(context);

  final ChangeAccountInfoUseCase _changeAccountInfoUseCase =
      sl<ChangeAccountInfoUseCase>();

  final TextEditingController _emailController = TextEditingController(
    text: DataIntent.getUser().email,
  );
  final TextEditingController _phoneNumberController = TextEditingController(
    text: DataIntent.getUser().phoneNumber,
  );
  File? _userImage;
  bool _imageChanged = false;
  final String _imageUrl = DataIntent.getUser().imageUrl;

  Future<String> _getImagesFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery);
      return pickedImage!.path;
    } catch (e) {
      throw Exception(e);
    }
  }

  chooseNewPicture() async {
    try {
      String path = await _getImagesFromGallery();
      _userImage = File(path);
      _imageChanged = true;
      emit(ContentState());
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  Future<void> update() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _changeAccountInfoUseCase(
      ChangeAccountInfoUseCaseInput(
        userId: DataIntent.getUser().uid,
        emailChanged:
            _emailController.text.trim() != DataIntent.getUser().email,
        email: _emailController.text.trim().isEmpty
            ? DataIntent.getUser().email
            : _emailController.text.trim(),
        phoneNumber: DataIntent.getUser().phoneNumber,
        pictureChanged: _imageChanged,
        picture: _userImage,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            emit(
              SuccessState('Profile Updated Successfully'),
            );
          },
        );
      },
    );
  }

  @override
  void start() {}

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  String get getImageUrl => _imageUrl;

  @override
  bool get getImageChanged => _imageChanged;

  @override
  File get getSelectedImage => _userImage!;
}

abstract class PersonalInfoViewModelInput {}

abstract class PersonalInfoViewModelOutput {
  TextEditingController get getEmailController;

  TextEditingController get getPhoneNumberController;

  String get getImageUrl;

  bool get getImageChanged;

  File get getSelectedImage;
}
