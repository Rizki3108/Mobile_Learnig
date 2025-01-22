import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/dashboard_controller.dart';

class AddView extends GetView {
  const AddView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    controller.nameController.clear();
    controller.descriptionController.clear();
    controller.eventDateController.clear();
    controller.locationController.clear();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Event'),
        centerTitle: true,
        backgroundColor: HexColor('#feeee8'),
      ),
      backgroundColor: HexColor('#feeee8'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 70.0),
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15),
              child: TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  border:
                      OutlineInputBorder(),
                  labelText: 'Event Name',
                  hintText: 'Masukan Nama Event',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 15),
              child: TextField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      'Description',
                  hintText: 'Masukan Deskripsi',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15),
              child: TextField(
                controller: controller.eventDateController,
                readOnly:
                    true, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event Date',
                  hintText: 'Masukan Tanggal Event',
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate:DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    controller.eventDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                controller: controller.locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                  hintText: 'Masukan Lokasi Event',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  controller.addEvent();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
