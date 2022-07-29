class Entries {
  final String schemaContext;
  final String schemaId;
  final String schemaType;
  final int id;
  final int amount;
  final String description;
  final String type;

  const Entries({
        required this.schemaContext,
        required this.schemaId,
        required this.schemaType,
        required this.id,
        required this.amount,
        required this.description,
        required this.type,
      });

  factory Entries.fromJson(schema, Map<String, dynamic> json) {
    return Entries(
      schemaContext: schema['@context'],
      schemaType: schema['@type'],
      schemaId: schema['@id'],
      id: json['id'],
      amount: json['amount'],
      description: json['description'],
      type: json['type'],
    );
  }
}