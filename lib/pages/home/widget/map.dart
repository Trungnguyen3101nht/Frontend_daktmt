import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// =======================
// ignore: camel_case_types
class map extends StatelessWidget {
  const map({
    super.key,
    required this.gaugeHeight,
    required this.gaugeWidth,
  });

  final double gaugeHeight;
  final double gaugeWidth;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: SizedBox(
        height: gaugeHeight,
        width: gaugeWidth,
        
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(10.879569567979344, 106.80568875364565), 
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=pqZwfqHFA5XexcvOOXeb',
              subdomains: const ['a', 'b', 'c'],
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(10.880336572604842, 106.80479553251045), // Vị trí của marker
                  // Chỉ cần đảm bảo rằng bạn đã chỉ định kích thước cho Marker
                  width: 40, // Chiều rộng
                  height: 40, // Chiều cao
                  child: Icon(
                    Icons.location_on,
                    size: 40.0,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}