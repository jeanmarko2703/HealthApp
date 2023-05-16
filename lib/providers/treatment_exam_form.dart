import 'package:flutter/cupertino.dart';

class TreatmentExamFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ageAtDiagnosis = TextEditingController();
  TextEditingController cohort = TextEditingController();
  TextEditingController erStatus = TextEditingController();
  TextEditingController neoplasmHistologicGrade = TextEditingController();
  TextEditingController lymphPositive = TextEditingController();
  TextEditingController mutationCount = TextEditingController();
  TextEditingController prStatus = TextEditingController();
  TextEditingController geneClassifier = TextEditingController();
  TextEditingController nottinghamPrognostic = TextEditingController();
  TextEditingController oncotree = TextEditingController();

  String ageAtDiagnosisValidatorError = '';
  String cohortValidatorError = '';
  String erStatusValidatorError = '';
  String neoplasmHistologicGradeValidatorError = '';
  String lymphPositiveValidatorError = '';
  String mutationCountValidatorError = '';
  String prStatusValidatorError = '';
  String geneClassifierValidatorError = '';
  String nottinghamPrognosticValidatorError = '';
  String oncotreeValidatorError = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  cleanControllers() {
    formKey = GlobalKey<FormState>();
    ageAtDiagnosis = TextEditingController();
    cohort = TextEditingController();
    erStatus = TextEditingController();
    neoplasmHistologicGrade = TextEditingController();
    lymphPositive = TextEditingController();
    mutationCount = TextEditingController();
    prStatus = TextEditingController();
    geneClassifier = TextEditingController();
    nottinghamPrognostic = TextEditingController();
    oncotree = TextEditingController();

    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
