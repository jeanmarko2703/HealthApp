import 'package:flutter/cupertino.dart';

class TumorExamFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController perimeter = TextEditingController();
  TextEditingController texture = TextEditingController();
  TextEditingController smoothhness = TextEditingController();
  TextEditingController concavityPoints = TextEditingController();
  TextEditingController symetri = TextEditingController();
  TextEditingController fractalDimension = TextEditingController();

  String perimeterValidatorError = '';
  String textureValidatorError = '';
  String smoothhnessValidatorError = '';
  String concavityPointsValidatorError = '';
  String symetriValidatorError = '';
  String fractalDimensionValidatorError = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  cleanControllers() {
    formKey = GlobalKey<FormState>();
    perimeter = TextEditingController();
    texture = TextEditingController();
    smoothhness = TextEditingController();
    concavityPoints = TextEditingController();
    symetri = TextEditingController();
    fractalDimension = TextEditingController();
    notifyListeners();
  }

  bool isValidForm() {
    print('el valor es perimeter: ${perimeter.text}');
    print('el valor de la textura: ${texture.text}');

    return formKey.currentState?.validate() ?? false;
  }
}
