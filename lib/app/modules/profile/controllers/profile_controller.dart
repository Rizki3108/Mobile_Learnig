import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_learning/app/data/profile_response.dart';
import 'package:mobile_learning/app/utils/api.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final box = GetStorage();
  final _getconnect = GetConnect();
  final token = GetStorage().read('token');
  final isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _getconnect.get(
        BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.body);
      } else {
        throw Exception("Failed to load profile: ${response.statusText}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }
}
