// BannerItem 类
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.formJson(Map<String, dynamic> json) {
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

// 特惠推荐商品项
class PromotionGoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  PromotionGoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory PromotionGoodsItem.fromJson(Map<String, dynamic> json) {
    return PromotionGoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

// 特惠推荐商品列表
class PromotionGoodsList {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<PromotionGoodsItem> items;

  PromotionGoodsList({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory PromotionGoodsList.fromJson(Map<String, dynamic> json) {
    return PromotionGoodsList(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] == null
          ? []
          : (json["items"] as List)
                .map(
                  (item) =>
                      PromotionGoodsItem.fromJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐子类型
class PromotionSubType {
  String id;
  String title;
  PromotionGoodsList goodsItems;

  PromotionSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory PromotionSubType.fromJson(Map<String, dynamic> json) {
    return PromotionSubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: PromotionGoodsList.fromJson(json["goodsItems"] ?? {}),
    );
  }
}

// 特惠推荐结果
class PromotionResult {
  String id;
  String title;
  List<PromotionSubType> subTypes;

  PromotionResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory PromotionResult.fromJson(Map<String, dynamic> json) {
    return PromotionResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] == null
          ? []
          : (json["subTypes"] as List)
                .map(
                  (item) =>
                      PromotionSubType.fromJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐响应
class PromotionResponse {
  String code;
  String msg;
  PromotionResult? result;

  PromotionResponse({required this.code, required this.msg, this.result});

  factory PromotionResponse.fromJson(Map<String, dynamic> json) {
    return PromotionResponse(
      code: json["code"] ?? "",
      msg: json["msg"] ?? "",
      result: json["result"] == null
          ? null
          : PromotionResult.fromJson(json["result"] as Map<String, dynamic>),
    );
  }
}

// 根据json编写class对象和工厂转化函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });

  factory CategoryItem.formJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
                .map(
                  (item) => CategoryItem.formJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

class GoodDetailItem extends PromotionGoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
