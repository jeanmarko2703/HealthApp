import 'dart:convert';

class TreatmentModel {
  final int ageAtDiagnosis;
  final int chemotherapy;
  final int cohort;
  final int erStatus;
  final int neoplasmHistologicGrade;
  final int hormoneTherapy;
  final int lymphNodesExaminedPositive;
  final int mutationCount;
  final int nottinghamPrognosticIndex;
  final int oncotreeCode;
  final int overallSurvivalMonths;
  final int prStatus;
  final int radioTherapy;
  final int geneClassifierSubtype;
  final int tumorStage;

  TreatmentModel({
    required this.ageAtDiagnosis,
    required this.chemotherapy,
    required this.cohort,
    required this.erStatus,
    required this.neoplasmHistologicGrade,
    required this.hormoneTherapy,
    required this.lymphNodesExaminedPositive,
    required this.mutationCount,
    required this.nottinghamPrognosticIndex,
    required this.oncotreeCode,
    required this.overallSurvivalMonths,
    required this.prStatus,
    required this.radioTherapy,
    required this.geneClassifierSubtype,
    required this.tumorStage,
  });

  factory TreatmentModel.fromRawJson(String str) =>
      TreatmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
        ageAtDiagnosis: json["AgeAtDiagnosis"]?.toDouble(),
        chemotherapy: json["Chemotherapy"]?.toDouble(),
        cohort: json["Cohort"]?.toDouble(),
        erStatus: json["ERStatus"]?.toDouble(),
        neoplasmHistologicGrade: json["NeoplasmHistologicGrade"]?.toDouble(),
        hormoneTherapy: json["HormoneTherapy"]?.toDouble(),
        lymphNodesExaminedPositive:
            json["LymphNodesExaminedPositive"]?.toDouble(),
        mutationCount: json["MutationCount"]?.toDouble(),
        nottinghamPrognosticIndex:
            json["NottinghamPrognosticIndex"]?.toDouble(),
        oncotreeCode: json["OncotreeCode"]?.toDouble(),
        overallSurvivalMonths: json["OverallSurvival_Months"]?.toDouble(),
        prStatus: json["PRStatus"]?.toDouble(),
        radioTherapy: json["RadioTherapy"]?.toDouble(),
        geneClassifierSubtype: json["GeneClassifierSubtype"]?.toDouble(),
        tumorStage: json["TumorStage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "AgeAtDiagnosis": ageAtDiagnosis,
        "Chemotherapy": chemotherapy,
        "Cohort": cohort,
        "ERStatus": erStatus,
        "NeoplasmHistologicGrade": neoplasmHistologicGrade,
        "HormoneTherapy": hormoneTherapy,
        "LymphNodesExaminedPositive": lymphNodesExaminedPositive,
        "MutationCount": mutationCount,
        "NottinghamPrognosticIndex": nottinghamPrognosticIndex,
        "OncotreeCode": oncotreeCode,
        "OverallSurvival_Months": overallSurvivalMonths,
        "PRStatus": prStatus,
        "RadioTherapy": radioTherapy,
        "GeneClassifierSubtype": geneClassifierSubtype,
        "TumorStage": tumorStage,
      };
}
