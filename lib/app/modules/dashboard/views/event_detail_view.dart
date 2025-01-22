import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:mobile_learning/app/data/event_response.dart';
// import 'package:mobile_learning/app/modules/dashboard/controllers/dashboard_controller.dart';

class EventDetailView extends StatelessWidget {
  final Events event; // Parameter untuk menerima data event

  const EventDetailView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/id/${event.id}/700/300',
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 250,
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
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    event.eventDate!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
