import 'package:annaluxstore/app/modules/home/models/product_model.dart';
import 'package:mobx/mobx.dart';
part 'product_store_model.g.dart';

class ProductModelStore = _ProductModelStoreBase with _$ProductModelStore;

abstract class _ProductModelStoreBase with Store {
  @observable
  String id;
  @observable
  String title;
  @observable
  String description;
  @observable
  List images;
  @observable
  double price;
  @observable
  String categorie;
  @observable
  int quantity = 1;
  @observable
  double totalPrice = 0;

  _ProductModelStoreBase({
    this.id,
    this.title,
    this.description,
    this.images,
    this.price,
    this.categorie,
  });

  @action
  calcTotalPricePlus() {
    totalPrice = price;
    //print(totalPrice);
    quantity++;
    totalPrice = totalPrice * quantity;
  }

  @action
  calcTotalPriceSub() {
    totalPrice = price;
    if (quantity == 1) {
      return;
    }
    quantity--;
    totalPrice = totalPrice * quantity;
  }

  ProductModelStore transformModel(ProductModel productModel) {
    return ProductModelStore(
      id: productModel.id ?? "",
      title: productModel.title ?? "",
      description: productModel.description ?? "",
      images: productModel.images ?? [],
      price: productModel.price ?? 0,
      categorie: productModel.categorie ?? "",
    );
  }

  Map<String, dynamic> toOrder() {
    return {
      'title': this.title,
      'price': this.price,
      'quantity': this.quantity,
      'totalprice': this.totalPrice == 0 ? this.price : this.totalPrice,
      'image': this.images[0],
    };
  }
}
