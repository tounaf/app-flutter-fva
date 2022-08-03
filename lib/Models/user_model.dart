class Member {
  final String schemaContext;
  final String schemaId;
  final String schemaType;
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String address;
  final String groupe;

  const Member({
    required this.schemaContext,
    required this.schemaId,
    required this.schemaType,
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
    required this.address,
    required this.groupe,
  });

  factory Member.fromJson(schema, Map<String, dynamic> json) {
    return Member(
      schemaContext: schema['@context'],
      schemaType: schema['@type'],
      schemaId: schema['@id'],
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      groupe: json['groupe'],
    );
  }
}