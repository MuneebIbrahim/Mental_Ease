import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_ease/user/AppointmentConfirmationScreen.dart';
import 'package:mental_ease/user/UserDashboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mental_ease/user/paymentgateway.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String doctorId; // Pass the doctor's ID when navigating to this screen

  DoctorDetailsScreen({required this.doctorId});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  List<String> availableDays = [];
  String? selectedDay;
  String? clinicTiming;
  String? appointmentFee;
  String? doctorName;

  @override
  void initState() {
    super.initState();
    _fetchDoctorDetails();
  }

  // Fetch the doctor's details from Firestore
  void _fetchDoctorDetails() async {
    print('📡 Fetching from Realtime Database...');
    final dbRef = FirebaseDatabase.instance.ref();

    try {
      final snapshot = await dbRef.child('users/${widget.doctorId}').get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        final String rawWeekDays = data['weekDays'] ?? '';
        final List<String> parsedDays = rawWeekDays
            .split(',')
            .map((day) => day.trim())
            .where((day) => day.isNotEmpty)
            .toList();

        setState(() {
          availableDays = parsedDays;
          clinicTiming = data['clinicTiming'] ?? 'Not available';
          appointmentFee = data['appointmentFee'] ?? 'Not available';
          doctorName = data['name'] ?? 'Unknown Doctor';
        });

        print('✅ Realtime Clinic Timing: $clinicTiming');
        print('✅ Realtime Appointment Fee: $appointmentFee');
        print('✅ Realtime Week Days: $availableDays');
      } else {
        print('❌ User not found in Realtime Database!');
      }
    } catch (e) {
      print('🔥 Error fetching doctor from Realtime DB: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;
    final crossAxisCount = isDesktop ? 4 : 2;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.2),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(screenHeight * 0.03),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0F7FA), Color(0xFF80DEEA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Meet your ',
                                    style: TextStyle(
                                      fontFamily: "CustomFont",
                                      color: Color(0xFF006064),
                                      fontSize: screenHeight * 0.035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Doctor",
                                    style: TextStyle(
                                      fontFamily: "CustomFont",
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          width: screenWidth * 0.7,
                          child: Divider(
                            thickness: 2,
                            height: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clinic Timing: $clinicTiming', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Appointment Fee: $appointmentFee', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Available Days:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Expanded(
              child: availableDays.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: availableDays.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = availableDays[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedDay == availableDays[index]
                            ? Color(0xFF006064)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        availableDays[index],
                        style: TextStyle(
                          color: selectedDay == availableDays[index]
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedDay != null) {
                          await StripeService.instance.makePayment(25, 'USD');
                          print('Payment Status: ${StripeService.instance.isSuccess}');
                          if (StripeService.instance.isSuccess) {
                            _bookAppointment();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a day!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF006064),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                      child: Text('Book Appointment'),
                    ),
                  ),
                  SizedBox(width: 16), // Space between the buttons
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedDay != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentConfirmationScreen(
                                doctorName: doctorName ?? 'Unknown Doctor',
                                selectedDay: selectedDay!,
                                appointmentToken: _generateToken(),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a day first!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF006064),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                      child: Text("Check Appointment"),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  // Function to handle booking the appointment
  void _bookAppointment() {
    // Generate a unique token for the appointment
    String appointmentToken = _generateToken();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentConfirmationScreen(
          doctorName: doctorName ?? 'Unknown Doctor', // Pass doctor name
          selectedDay: selectedDay ?? 'No day selected', // Pass selected day
          appointmentToken: appointmentToken, // Pass appointment token
        ),
      ),
    );


  }

  // Generate a unique token for the appointment
  String _generateToken() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        '_' +
        (1000 + (DateTime.now().second % 1000)).toString();
  }
}
