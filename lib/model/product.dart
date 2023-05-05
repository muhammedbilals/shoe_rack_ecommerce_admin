class Product {
  String name;
  String subtitle;
  String discrption;
  String? id;
  String? color;
  int? size;

  Product(
      {required this.name,
      required this.subtitle,
      this.id,
      this.color,
      this.size,
      this.discrption = ''});

  static Product fromJason(Map<String, dynamic> json) => Product(
    name:json['name'],
    subtitle: json['subtitle'],
    discrption: json['discrption'],
    id: json['id'],
    color: json['color'],
    size: json['size']
    
  );

  Map<String, dynamic> toJason() => {
        'name': name,
        'subtitle': subtitle,
        'discription': discrption,
        'id': id,
        'color': color,
        'size': size
      };
}
