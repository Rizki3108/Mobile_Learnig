import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:mobile_learning/app/data/detail_event_response.dart';
import 'package:mobile_learning/app/data/event_response.dart';
import 'package:mobile_learning/app/data/profile_response.dart';
import 'package:mobile_learning/app/utils/api.dart';
import 'package:mobile_learning/app/modules/dashboard/views/index_view.dart';
import 'package:mobile_learning/app/modules/dashboard/views/profile_view.dart';
import 'package:mobile_learning/app/modules/dashboard/views/your_event_view.dart';

class DashboardController extends GetxController {
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  var selectedIndex = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
  ];

  Future<EventClass> getEvent() async {
    final response = await _getConnect.get(
      BaseUrl.events,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return EventClass.fromJson(response.body);
  }

  var yourEvents = <Events>[].obs;
  Future<void> getYourEvent() async {
    final response = await _getConnect.get(
      BaseUrl.yourEvent,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    final eventClass = EventClass.fromJson(response.body);
    yourEvents.value = eventClass.events ?? [];
  }

  Future<DetailResponse> getDetailEvent({required int id}) async {
    final response = await _getConnect.get(
      '${BaseUrl.detailEvents}/$id',
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return DetailResponse.fromJson(response.body);
  }

  void addEvent() async {
    final response = await _getConnect.post(
      BaseUrl.events,
      {
        'name': nameController.text,
        'description': descriptionController.text,
        'event_date': eventDateController.text,
        'location': locationController.text
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Event Added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();
      update();
      getEvent();
      getYourEvent();
      Get.close(1);
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Add',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void editEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.events}/$id',
      {
        'name': nameController.text,
        'description': descriptionController.text,
        'event_date': eventDateController.text,
        'location': locationController.text,
        '_method': 'PUT',
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Event Updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();

      update();
      getEvent();
      getYourEvent();
      Get.close(1);
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Update',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi buat hapus event, tinggal kasih ID-nya
  void deleteEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.deleteEvents}/$id',
      {
        '_method': 'delete',
      },
      headers: {
        'Authorization': "Bearer $token"
      },
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Event Deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      update();
      getEvent();
      getYourEvent();
    } else {
      
      Get.snackbar(
        'Failed',
        'Event Failed to Delete',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<ProfileResponse> getProfile({required int id}) async {
    try {
      final response = await _getConnect.get(
        '${BaseUrl.profile}/$id',
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

  void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }

  @override
  void onInit() {
    getEvent();
    getYourEvent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
