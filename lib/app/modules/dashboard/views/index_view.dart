import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_learning/app/data/event_response.dart';
import 'package:mobile_learning/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mobile_learning/app/modules/dashboard/views/event_detail_view.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class IndexView extends GetView {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<EventClass>(
          future: controller.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              );
            }

            if (snapshot.data!.events!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.events!.length,
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final event = snapshot.data!.events![index];
                return ZoomTapAnimation(
                  onTap: () {
                    // Pass event object ke EventDetailView
                    Get.to(() => EventDetailView(event: event));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://picsum.photos/id/${event.id}/700/300',
                        fit: BoxFit.cover,
                        height: 200,
                        width: 500,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 200,
                            child: Center(child: Text('Image not found')),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        event.name!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              event.location!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 10),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
