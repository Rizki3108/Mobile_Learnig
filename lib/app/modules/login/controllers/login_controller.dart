import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_learning/app/modules/dashboard/views/dashboard_view.dart';
import 'package:mobile_learning/app/utils/api.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    final response = await _getConnect.post(BaseUrl.login, {
      'email': emailController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else
      (Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      ));
  }
}
