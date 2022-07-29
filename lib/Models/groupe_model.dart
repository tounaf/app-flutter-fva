class Groupe {
  final String schemaContext;
  final String schemaId;
  final String schemaType;
  final int id;
  final String name;

  const Groupe({
        required this.schemaContext,
        required this.schemaId,
        required this.schemaType,
        required this.id,
        required this.name,
      });

  factory Groupe.fromJson(schema, Map<String, dynamic> json) {
    return Groupe(
      schemaContext: schema['@context'],
      schemaType: schema['@type'],
      schemaId: schema['@id'],
      id: json['id'],
      name: json['name'],
    );
  }
}