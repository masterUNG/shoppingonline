import 'package:get/get.dart';
import 'package:shoppingonline/models/address_delivery_model.dart';
import 'package:shoppingonline/models/cart_model.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/models/user_model.dart';

class AppController extends GetxController {
  RxBool acceptTermAndCondition = false.obs;

  RxBool displayErrorAccept = false.obs;

  RxBool redEye = true.obs;

  RxBool display = false.obs;

  RxInt indexBody = 0.obs;

  RxInt amount = 1.obs;

  RxList<CategoryModel?> chooseCategoryModels = <CategoryModel?>[null].obs;

  RxList<String> urlImages = <String>[].obs;

  RxList<UserModel> currentUserModels = <UserModel>[].obs;

  RxList<CartModel> cartModels = <CartModel>[].obs;

  RxList<num> amounts = <num>[].obs;

  RxList<num> cartCosts = <num>[0.0].obs;

  RxList<num> deliveryCosts = <num>[0.0].obs;

  RxList<ProductModel> productModels = <ProductModel>[].obs;

  RxList<AddressDeliveryModel> addressDeliveryModels = <AddressDeliveryModel>[].obs;

  RxList<String?> chooseDocIdAddressDelicerys = <String?>[].obs;

  RxInt indexChoosePaymentMethod = 0.obs;

  RxList<OrderModel> orderModels = <OrderModel>[].obs;









}
