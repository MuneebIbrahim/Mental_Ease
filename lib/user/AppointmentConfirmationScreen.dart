import 'package:flutter/material.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String selectedDay;
  final String appointmentToken;

  const AppointmentConfirmationScreen({
    Key? key,
    required this.doctorName,
    required this.selectedDay,
    required this.appointmentToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                                    text: 'Your Appointment ',
                                    style: TextStyle(
                                      fontFamily: "CustomFont",
                                      color: Color(0xFF006064),
                                      fontSize: screenHeight * 0.035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Details",
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Icon(Icons.check_circle_rounded, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Appointment Booked Successfully!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _infoRow("👨‍⚕️ Doctor", doctorName),
                    SizedBox(height: 12),
                    _infoRow("📅 Day", selectedDay),
                    SizedBox(height: 12),
                    _infoRow("🎫 Token", appointmentToken),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: screenWidth * 0.6,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006064),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                child: Text(
                  "Go to Dashboard",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
