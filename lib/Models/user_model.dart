class User {
  final String schemaContext;
  final String schemaId;
  final String schemaType;
  final int id;
  final int username;
  final int firstname;
  final String lastname;
  final String phone;

  const User({
        required this.schemaContext,
        required this.schemaId,
        required this.schemaType,
        required this.id,
        required this.username,
        required this.firstname,
        required this.lastname,
        required this.phone
      });

  factory User.fromJson(schema, Map<String, dynamic> json) {
    print('==== json ');
    print(json);
    print('==== schema ');
    print(schema);
    return User(
      schemaContext: schema['@context'],
      schemaType: schema['@type'],
      schemaId: schema['@id'],
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
    );
  }
}