import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class DiagnosisPrediction {
  Future<String?> makeDiagnosisPrediction(DiagnosisModel diagnosis) async {
    final url =
        Uri.parse('https://breast-cancer-detection.up.railway.app/diagnosis');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(diagnosis.toJson());
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // final DiagnosisModel diagnosis = DiagnosisModel.fromJson(json.decode(response.body));
      final prediction = json.decode(response.body);
      return prediction;
    } else {
      return null;
    }
  }

  Future<List<String>?> makeDiagnosisPredictionTreatment(
      int age,
      cohort,
      erStatus,
      neoplas,
      lymph,
      mutation,
      prStatus,
      genType,
      nottingham,
      oncotree,
      tumorStage) async {
    List<String> finalResults = [];
    List<String> results = [];
    List<String> possibilities = [
      '000',
      '001',
      '010',
      '111',
      '100',
      '101',
      '110',
      '011'
    ];
    bool allTreatment = false;
    for (String combination in possibilities) {
      String result = '';
      int chemo = int.parse(combination[0]);
      int hormo = int.parse(combination[1]);
      int radio = int.parse(combination[2]);
      result = await makeDiagnosisPredictionTreatmentForEveryCase(
              TreatmentModel(
                  ageAtDiagnosis: age,
                  chemotherapy: chemo,
                  cohort: cohort,
                  erStatus: erStatus,
                  neoplasmHistologicGrade: neoplas,
                  hormoneTherapy: hormo,
                  lymphNodesExaminedPositive: lymph,
                  mutationCount: mutation,
                  nottinghamPrognosticIndex: nottingham,
                  oncotreeCode: oncotree,
                  overallSurvivalMonths: 10,
                  prStatus: prStatus,
                  radioTherapy: radio,
                  geneClassifierSubtype: genType,
                  tumorStage: tumorStage)) ??
          '';

      if (result == 'SOBREVIVE') {
        results.add(combination);
      }
    }
    for (String result in results) {
      switch (result) {
        case '000':
          // finalResults.add('Ninguno');

          // Combination 000
          // Run function for this combination
          break;
        case '001':
          finalResults.add('Radio Terapia');

          // Combination 001
          // Run function for this combination
          break;
        case '010':
          finalResults.add('Terapia Hormonal');

          // Combination 010
          // Run function for this combination
          break;
        case '111':
          // finalResults.add('Todos');
          

          // Combination 111
          // Run function for this combination
          break;
        case '100':
          finalResults.add('Quimioterapia');

          // Combination 100
          // Run function for this combination
          break;
        case '101':
          finalResults.add('Quimioterapia - Radio Terapia');

          // Combination 101
          // Run function for this combination
          break;
        case '110':
          finalResults.add('Quimioterapia - Terapia Hormonal');

          // Combination 110
          // Run function for this combination
          break;
        case '011':
          finalResults.add('Terapia Hormonal - Radio Terapia');

          // Combination 011
          // Run function for this combination
          break;
        default:
          finalResults.add('Otra Terapia');

        // Invalid combination
        // Handle error or do nothing
      }
    }
    for (String finalResult in finalResults) {
      // print(finalResult);
      if (finalResult == 'Todos') {
        allTreatment = true;
      }
    }
    if (allTreatment == true) {
      finalResults.clear();
      finalResults.add('Quimioterapia - Terapia Hormonal - Radio Tearpia');
    }
    return finalResults;
  }

  Future<String?> makeDiagnosisPredictionTreatmentForEveryCase(
      TreatmentModel diagnosis) async {
    final url =
        Uri.parse('https://breast-cancer-detection.up.railway.app/treatment');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(diagnosis.toJson());
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // final DiagnosisModel diagnosis = DiagnosisModel.fromJson(json.decode(response.body));
      final prediction = json.decode(response.body);
      return prediction;
    } else {
      return null;
    }
  }
}
