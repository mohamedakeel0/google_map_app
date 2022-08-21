class modelCategories {
  String? id;
  String? name;
  String? icon;
  String? iconName;
  String? color;


  modelCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print(id.runtimeType);
    name = json['name'];
    print(name.runtimeType);
    icon = json['icon'];
    print(icon.runtimeType);
    iconName = json['icon_name'];
    print(iconName.runtimeType);
    color = json['color'];
    print(color.runtimeType);
  }


}