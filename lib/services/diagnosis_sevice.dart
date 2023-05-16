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

  Future<String?> makeDiagnosisPredictionTreatment(
      DiagnosisModel diagnosis) async {
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
