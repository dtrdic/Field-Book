// TraitObject model for trait details
class TraitObject {
  String id;
  String name;
  String? minimum;
  String? maximum;
  String? categories;
  bool? closeKeyboardOnOpen;
  bool? cropImage;

  TraitObject({
    required this.id,
    required this.name,
    this.minimum,
    this.maximum,
    this.categories,
    this.closeKeyboardOnOpen,
    this.cropImage,
  });

  factory TraitObject.fromMap(Map<String, dynamic> map) {
    return TraitObject(
      id: map['id']?.toString() ?? '',
      name: map['observation_variable_name'] ?? '',
      minimum: map['minimum'],
      maximum: map['maximum'],
      categories: map['categories'],
      closeKeyboardOnOpen:
          map['closeKeyboardOnOpen'] == 1 || map['closeKeyboardOnOpen'] == true,
      cropImage: map['cropImage'] == 1 || map['cropImage'] == true,
    );
  }
}
