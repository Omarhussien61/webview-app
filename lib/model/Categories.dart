class Categories {
  int? id;
  int? parentId;
  String? name;
  String? image;
  String? thumbnail;
  String? url;
  bool? isActive;
  int? position;
  int? level;
  int? productCount;
  List<Categories>? childrenData;

  Categories(
      {this.id,
        this.parentId,
        this.name,
        this.url,
        this.image,
        this.thumbnail,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = <Categories>[];
      json['children_data'].forEach((v) {
        childrenData!.add(new Categories.fromJson(v));
      });
    }
  }

}


