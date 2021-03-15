import 'dart:async';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class CartRepository extends BaseDataRepository<CartModel> {
  final IConfig config;
  final IRepositoryOptions options;

  CartRepository({
    required this.config,
    required this.options,
  }) : super(config, options) {
    this.data = CartModel(
      Id: "c01",
      Products: [],
      Total: "0",
      TotalNumber: 0,
    );
    this.dataSC.add(this.data);
  }

  Future<void> mockAddToCart(String productID, {int quantity: 1}) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      Map<String, dynamic> raw = [
        ...mockProducts,
        ...mockBestSellerProducts,
        ...mockNewArrivalProducts
      ].firstWhere((p) => productID == p["product_id"]);

      CartProductModel product = CartProductModel.fromJson(raw);
      CartProductModel? cartProduct;
      int? cpIndex;

      for (int i = 0; i < this.data!.Products.length; i++) {
        if (this.data!.Products[i].Id == product.Id) {
          cartProduct = this.data!.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex == null) {
        cartProduct = product;
        cartProduct.Quantity = quantity;
        this.data!.Products.add(cartProduct);
        this.dataSC.add(this.data!);
      } else {
        this.data!.Products[cpIndex].Quantity += quantity;
        this.dataSC.add(this.data!);
      }

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }

  Future<void> mockRemoveToCart(String productID) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      Map<String, dynamic> raw = [
        ...mockProducts,
        ...mockBestSellerProducts,
        ...mockNewArrivalProducts
      ].firstWhere((p) => productID == p["product_id"]);

      CartProductModel product = CartProductModel.fromJson(raw);
      int? cpIndex;

      for (int i = 0; i < this.data!.Products.length; i++) {
        if (this.data!.Products[i].Id == product.Id) {
          if (this.data!.Products[i].Quantity <= 1) {
            this.data!.Products.removeAt(i);
            this.dataSC.add(this.data!);
            break;
          }

          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        this.data!.Products[cpIndex].Quantity -= 1;
        this.dataSC.add(this.data!);
      }

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
    }
  }
}
