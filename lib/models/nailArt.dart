class NailArt {
  int id;
  String brandName;
  String colorName;
  String nailType;
  
  NailArt(this.id, this.brandName, this.colorName, this.nailType);

  NailArt.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    brandName = map['brand_name'];
    colorName = map['color_name'];
    nailType = map['nail_type'];
  }
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'brand_name': brandName,
      'color_name': colorName,
      'nail_type': nailType
    };
    if (id != null){
      map['id'] = id;
    }
    return map;
  }

  NailArt.fromObject(dynamic o){
    this.id = o['id'];
    this.brandName = o['brand_name'];
    this.colorName = o['color_name'];
    this.nailType = o['nail_type'];
  }
}