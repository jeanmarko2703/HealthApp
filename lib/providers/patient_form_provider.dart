import 'package:flutter/cupertino.dart';

class PatientFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();

  String namelValidatorError = '';
  String genderValidatorError = '';
  String ageValidatorError = '';
  String idValidatorError = '';
  String hospitalValidatorError = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void cleanControllers() {
    nameController = TextEditingController();
    genderController = TextEditingController();
    ageController = TextEditingController();
    idController = TextEditingController();
    hospitalController = TextEditingController();

    namelValidatorError = '';
    genderValidatorError = '';
    ageValidatorError = '';
    idValidatorError = '';
    hospitalValidatorError = '';
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
