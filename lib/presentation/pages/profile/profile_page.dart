import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(StringConstants.profile,
            style: GoogleFonts.montserrat(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 35),
            Text("Aditya Eka Ramadhan",
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            Container(height: 5),
            Text(
              "Flutter Developer / Native Android",
              style: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            Container(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(Icons.chat, color: Colors.lightGreen[600]),
                  ),
                  onTap: () async {
                    Uri sms = Uri.parse('sms:08179276441?body=');
                    await launchUrl(sms);
                    //app opened

                  },
                ),
                Container(width: 10),
                const AvatarView(
                  radius: 52,
                  borderColor: Colors.grey,
                  avatarType: AvatarType.CIRCLE,
                  backgroundColor: Colors.red,
                  imagePath: "assets/images/profile.jpg",
                  placeHolder: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  errorWidget: Icon(
                    Icons.error,
                    size: 50,
                  ),
                ),
                Container(width: 10),
                InkWell(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(Icons.call, color: Colors.lightGreen[600]),
                  ),
                  onTap: () {
                    _makePhoneCall('08179276441');
                  },
                ),
              ],
            ),
            const Divider(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                'Team oriented, self-motivated, helping people, hardworking',
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 50),
            Row(
              children: <Widget>[
                Container(width: 40),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(StringConstants.phone,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                      Container(height: 5),
                      const Text(
                        "08179276441",
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(StringConstants.email,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                      Container(height: 5),
                      const Text(
                        "aditya.eka.r@gmail.com",
                      )
                    ],
                  ),
                ),
                Container(width: 40)
              ],
            ),
            Container(height: 30),
            Row(
              children: <Widget>[
                Container(width: 40),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(StringConstants.location,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                      Container(height: 5),
                      const Text(
                        "Bandung, Indonesia",
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(StringConstants.zipCode,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                      Container(height: 5),
                      const Text(
                        "40238",
                      )
                    ],
                  ),
                ),
                Container(width: 40)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
