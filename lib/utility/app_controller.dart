import 'package:get/get.dart';
import 'package:shoppingonline/models/category_model.dart';

class AppController extends GetxController {

  RxBool acceptTermAndCondition = false.obs;

  RxBool displayErrorAccept = false.obs;

  RxBool redEye = true.obs;

  RxBool display = false.obs;

  RxInt indexBody = 0.obs;

  RxList<CategoryModel?> chooseCategoryModels = <CategoryModel?>[null].obs;

  RxList<String> urlImages = <String>[].obs;






}
