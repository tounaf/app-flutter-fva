class Vola {
  final String schemaContext;
  final String schemaId;
  final String schemaType;
  final int id;
  final int montant;
  final String description;

  const Vola({
        required this.schemaContext,
        required this.schemaId,
        required this.schemaType,
        required this.id,
        required this.montant,
        required this.description
      });

  factory Vola.fromJson(schema, Map<String, dynamic> json) {
    return Vola(
      schemaContext: schema['@context'],
      schemaType: schema['@type'],
      schemaId: schema['@id'],
      id: json['id'],
      montant: json['montant'],
      description: json['description'],
    );
  }
}