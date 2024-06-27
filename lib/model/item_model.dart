
class ItemModel {
  ItemModel({
    this.uid,
    this.name,
    this.description,
  });

  String? uid;
  String? name;
  String? description;
 
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        uid: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": uid,
        "name": name,
        "description": description,
      };
}
