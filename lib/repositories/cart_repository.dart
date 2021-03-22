import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class CartRepository extends BaseDataRepository<CartModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  late CartModel? cart;

  CartRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options) {
    this.cart = CartModel(
      Id: "c01",
      Products: [],
      Total: 0,
    );
    this.dataSC.add(this.cart);
  }

  @override
  List<CartModel> transforms(tss) {
    return CartModel.toList(tss);
  }

  @override
  CartModel? transform(ts) {
    return this.cart;
  }

  bool get isAllSelected {
    bool s = true;

    if (this.cart == null || this.cart?.Products.length == 0) {
      return false;
    } else {
      for (int i = 0; i < this.cart!.Products.length; i++) {
        if (!this.cart!.Products[i].isSelected) {
          s = false;
        }
      }
    }

    return s;
  }

  Future<void> mockFetch() async {
    CartModel cart = this.cart!;
    cart.Total = 0;

    await TimeHelper.sleep();

    for (int i = 0; i < cart.Products.length; i++) {
      cart.Products[i].Total =
          cart.Products[i].Quantity * cart.Products[i].Price;
      if (cart.Products[i].isSelected) {
        cart.Total += cart.Products[i].Total;
      }
    }

    this.cart = cart;
    this.dataSC.add(this.cart);
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

      for (int i = 0; i < this.cart!.Products.length; i++) {
        if (this.cart!.Products[i].Id == product.Id) {
          cartProduct = this.cart!.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex == null) {
        cartProduct = product;
        cartProduct.Quantity = quantity;
        this.cart!.Products.add(cartProduct);
      } else {
        this.cart!.Products[cpIndex].Quantity += quantity;
      }
      this.dataSC.add(this.cart!);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
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

      for (int i = 0; i < this.cart!.Products.length; i++) {
        if (this.cart!.Products[i].Id == product.Id) {
          if (this.cart!.Products[i].Quantity <= 1) {
            this.cart!.Products.removeAt(i);
            this.dataSC.add(this.cart!);
            break;
          }

          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        this.cart!.Products[cpIndex].Quantity -= 1;
        this.dataSC.add(this.cart!);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> selectProduct(String id) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      CartProductModel? cartProduct;
      int? cpIndex;
      for (int i = 0; i < this.cart!.Products.length; i++) {
        if (id == this.cart!.Products[i].Id) {
          cartProduct = this.cart!.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        cartProduct!.isSelected = true;
        this.cart!.Products[cpIndex] = cartProduct;
        this.dataSC.add(this.cart!);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> unSelectProduct(String id) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      CartProductModel? cartProduct;
      int? cpIndex;
      for (int i = 0; i < this.cart!.Products.length; i++) {
        if (id == this.cart!.Products[i].Id) {
          cartProduct = this.cart!.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        cartProduct!.isSelected = false;
        this.cart!.Products[cpIndex] = cartProduct;
        this.dataSC.add(this.cart!);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> selectAllProduct() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      for (int i = 0; i < this.cart!.Products.length; i++) {
        this.cart!.Products[i].isSelected = true;
      }
      this.dataSC.add(this.cart!);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> unSelectAllProduct() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      for (int i = 0; i < this.cart!.Products.length; i++) {
        this.cart!.Products[i].isSelected = false;
      }
      this.dataSC.add(this.cart!);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockCheckout() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      this.cart!.Products.removeWhere((cp) => cp.isSelected);
      this.dataSC.add(this.cart!);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }
}
