// To parse this JSON data, do
//
//     final diagnosisModel = diagnosisModelFromJson(jsonString);

import 'dart:convert';

class DiagnosisModel {
    final double textureMean;
    final double perimeterMean;
    final double smoothnessMean;
    final double concavePointsMean;
    final double symmetryMean;
    final double fractalDimensionMean;

    DiagnosisModel({
        required this.textureMean,
        required this.perimeterMean,
        required this.smoothnessMean,
        required this.concavePointsMean,
        required this.symmetryMean,
        required this.fractalDimensionMean,
    });

    factory DiagnosisModel.fromRawJson(String str) => DiagnosisModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        textureMean: json["texture_mean"]?.toDouble(),
        perimeterMean: json["perimeter_mean"]?.toDouble(),
        smoothnessMean: json["smoothness_mean"]?.toDouble(),
        concavePointsMean: json["concave_points_mean"]?.toDouble(),
        symmetryMean: json["symmetry_mean"]?.toDouble(),
        fractalDimensionMean: json["fractal_dimension_mean"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "texture_mean": textureMean,
        "perimeter_mean": perimeterMean,
        "smoothness_mean": smoothnessMean,
        "concave_points_mean": concavePointsMean,
        "symmetry_mean": symmetryMean,
        "fractal_dimension_mean": fractalDimensionMean,
    };
}
