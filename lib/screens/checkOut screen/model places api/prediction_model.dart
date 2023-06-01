class AutoCompletePrediction {
  final String? description;
  final String? placeId;
  final String? reference;
  final StructuredFormation? structuredFormatting;

  AutoCompletePrediction({
    this.structuredFormatting,
    this.description,
    this.placeId,
    this.reference,
  });

  factory AutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutoCompletePrediction(
      description: json['description'],
      placeId: json['placeId'],
      reference: json['reference'],
      structuredFormatting: json['structuredFormation'] != null
          ? StructuredFormation.fromJson(json['structured_formatting'])
          : null,
    );
  }
}

class StructuredFormation {
  final String? mainText;
  final String? secondaryText;

  StructuredFormation({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormation.fromJson(Map<String, dynamic>json){
    return StructuredFormation(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
}
