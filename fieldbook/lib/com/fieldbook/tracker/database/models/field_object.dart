class FieldObject {
  final int expId;
  final String expName;
  final String expAlias;
  final String uniqueId;
  final String primaryId;
  final String secondaryId;
  final String dateImport;
  final String? dateEdit;
  final String? dateExport;
  final String? dateSync;
  final String? importFormat;
  final String? expSource;
  final String? count;
  final String? observationLevel;
  final String? attributeCount;
  final String? traitCount;
  final String? observationCount;
  final String? trialName;
  final String? searchAttribute;

  FieldObject({
    required this.expId,
    required this.expName,
    required this.expAlias,
    required this.uniqueId,
    required this.primaryId,
    required this.secondaryId,
    required this.dateImport,
    this.dateEdit,
    this.dateExport,
    this.dateSync,
    this.importFormat,
    this.expSource,
    this.count,
    this.observationLevel,
    this.attributeCount,
    this.traitCount,
    this.observationCount,
    this.trialName,
    this.searchAttribute,
  });

  factory FieldObject.fromMap(Map<String, dynamic> map) {
    return FieldObject(
      expId: (map['exp_id'] is int)
          ? map['exp_id'] as int
          : int.tryParse(map['exp_id']?.toString() ?? '') ?? 0,
      expName: map['study_name'] ?? map['exp_name'] ?? '',
      expAlias: map['study_alias'] ?? map['exp_alias'] ?? '',
      uniqueId: map['study_unique_id_name'] ?? map['unique_id'] ?? '',
      primaryId: map['study_primary_id_name'] ?? map['primary_id'] ?? '',
      secondaryId: map['study_secondary_id_name'] ?? map['secondary_id'] ?? '',
      dateImport: map['date_import'] ?? '',
      dateEdit: map['date_edit'],
      dateExport: map['date_export'],
      dateSync: map['date_sync'],
      importFormat: map['import_format'],
      expSource: map['study_source'] ?? map['exp_source'],
      count: map['count']?.toString(),
      observationLevel: map['observation_levels'],
      attributeCount: map['attribute_count']?.toString(),
      traitCount: map['trait_count']?.toString(),
      observationCount: map['observation_count']?.toString(),
      trialName: map['trial_name'],
      searchAttribute: map['observation_unit_search_attribute'],
    );
  }
}
