class Book {
  final int id;
  final String name;
  final String site;



  const Book({
    this.id,
    this.name,
    this.site,


  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json['id'],
    name: json['name'],
    site: json['site'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'site': site,
  };
}
