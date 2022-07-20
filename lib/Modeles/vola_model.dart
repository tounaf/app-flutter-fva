class Vola {
  final int id;
  final int montant;
  final String description;

  const Vola({required this.id, required this.montant, required this.description});

  factory Vola.fromJson(Map<String, dynamic> json) {
    print('==== json ');
    print(json);
    return Vola(
      id: json['id'],
      montant: json['montant'],
      description: json['description'],
    );
  }
}