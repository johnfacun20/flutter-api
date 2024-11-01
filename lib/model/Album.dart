class Album {

  final String name;
  final String alpha_two_code;
  final String country;

  Album({
    required this.name,
    required this.alpha_two_code,
    required this.country
  });

  factory Album.fromJson(Map<String, dynamic> json){
    return Album(
        name: json['name'],
        alpha_two_code: json['alpha_two_code'],
        country: json['country']
    );
  }

}
