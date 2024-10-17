import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend_daktmt/custom_card.dart';

// ignore: camel_case_types
class map extends StatefulWidget {
  const map({super.key, required this.mapHeight, required this.mapWidth});

  final double mapHeight;
  final double mapWidth;

  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  LatLng? _deviceLocation;
  final LatLng _locationA =
      const LatLng(10.880336572604842, 106.80479553251045); // Vị trí A

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Yêu cầu quyền truy cập vị trí ngay khi khởi tạo
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra xem dịch vụ định vị có được bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dịch vụ định vị chưa bật.')),
      );
      return;
    }

    // Kiểm tra quyền truy cập vị trí
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quyền truy cập vị trí đã bị từ chối.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Quyền truy cập vị trí bị từ chối vĩnh viễn.')),
      );
      return;
    }

    _getCurrentLocation(); // Lấy vị trí của người dùng nếu quyền đã được cấp
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _deviceLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể lấy vị trí: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        height: widget.mapHeight,
        width: widget.mapWidth,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: _deviceLocation ??
                _locationA, // Trung tâm là vị trí của thiết bị nếu có
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=pqZwfqHFA5XexcvOOXeb',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                if (_deviceLocation != null)
                  Marker(
                    point: _deviceLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      size: 40.0,
                      color: Colors.blue,
                    ),
                  ),
                Marker(
                  point: _locationA,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    size: 40.0,
                    color: Colors.red,
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
