class Computer{

  final String brand;
  final String model;

  Computer({
    required this.brand,
    required this.model
  });

  factory Computer.fromJson(Map<String, dynamic> json) {
    return Computer(
        brand: json['brand'],
        model: json['model'],
    );
  }

}