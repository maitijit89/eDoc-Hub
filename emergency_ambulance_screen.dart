import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:edoc_hub/core/constants.dart';
import 'package:edoc_hub/services/location_service.dart';
import 'package:provider/provider.dart';

class EmergencyAmbulanceScreen extends StatefulWidget {
  @override
  _EmergencyAmbulanceScreenState createState() => _EmergencyAmbulanceScreenState();
}

class _EmergencyAmbulanceScreenState extends State<EmergencyAmbulanceScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final locationService = Provider.of<LocationService>(context, listen: false);
    final position = await locationService.getCurrentLocation();
    
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );
      _isLoading = false;
    });

    // Add nearby hospitals
    _addNearbyHospitals();
  }

  void _addNearbyHospitals() {
    // Simulated hospital locations
    final hospitals = [
      {'name': 'City Hospital', 'lat': _currentPosition!.latitude + 0.01, 'lng': _currentPosition!.longitude + 0.01},
      {'name': 'Community Medical', 'lat': _currentPosition!.latitude - 0.015, 'lng': _currentPosition!.longitude + 0.005},
      {'name': 'General Hospital', 'lat': _currentPosition!.latitude + 0.008, 'lng': _currentPosition!.longitude - 0.012},
    ];

    for (var hospital in hospitals) {
      _markers.add(
        Marker(
          markerId: MarkerId(hospital['name']),
          position: LatLng(hospital['lat'], hospital['lng']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: hospital['name']),
        ),
      );
    }
    setState(() {});
  }

  void _callEmergency() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Emergency Call'),
        content: Text('Call emergency services at 108?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement actual call functionality
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void _requestAmbulance() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Request Ambulance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Emergency Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Additional Information',
                border: OutlineInputBorder(),
                maxLines: 3,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emergency,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ambulance requested! Tracking will begin shortly.')),
                );
              },
              child: Text('Request Ambulance'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Ambulance'),
        backgroundColor: AppColors.emergency,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) => _mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 14,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.call),
                          label: Text('Call Emergency'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emergency,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: _callEmergency,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.local_hospital),
                          label: Text('Request Ambulance'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: _requestAmbulance,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
