import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';

class CountrySelectionModal {
  void show(BuildContext context, Function(String) onSelect) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        onSelect(country.name);
      },
    );
  }
}
