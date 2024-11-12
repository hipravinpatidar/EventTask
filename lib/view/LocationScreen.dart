import 'package:flutter/material.dart';
// import 'package:pvrdesign/frontpage.dart';

import 'useless_code/frontpage.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  List<String> cities = ['Agra', 'Delhi', 'Mumbai', 'Chennai', 'Kolkata', 'Hyderabad', 'Bangalore', 'Pune', 'Jaipur', 'Lucknow',
    'Bangkok', 'England', 'Hongkong','Goa','India', 'Bhopal','Jaipur','Jabalpur','Australia','China','Bhutan','Japan' ];

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ujjain', style: TextStyle(color: Colors.orange)),
        leading: GestureDetector(
            onTap: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => Frontpage()),);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 16),
                          suffixIcon: Icon(Icons.keyboard_voice_outlined),
                        ),
                      ),
                      Positioned(
                        left: 40, // adjust this value to match the icon width
                        child: Text(
                          'Search by Temples/Search by city',
                          style: TextStyle(color: Colors.grey,fontSize: screenwidth * 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: screenwidth * 1,
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.03),
              child: Row(
                children: [
                  Icon(Icons.share_location_sharp, color: Colors.red),
                  SizedBox(width: screenwidth * 0.03),
                  Text(
                    'Auto detect my location',
                    style: TextStyle(color: Colors.red, fontSize: screenwidth * 0.04),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.03),
              child: Row(
                children: [
                  Container(
                    height: screenheight * 0.03,
                    width: screenwidth * 0.01,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(width: screenwidth * 0.03),
                  Text(
                    'Popular Cities',
                    style: TextStyle(color: Colors.black, fontSize: screenwidth * 0.04, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            // Using Container instead of Expanded to prevent pushing the "Other Cities" text out of view
            Container(
              height: screenheight * 0.4, // Adjust the height as needed
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  crossAxisSpacing: 0, // Horizontal space between items
                  mainAxisSpacing: 0, // Vertical space between items
                  childAspectRatio: 0.9, // Decrease the aspect ratio to make the containers taller
                ),
                itemCount: 10, // Number of items in the grid
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(0), // Remove margin
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.4), // Reduce border width to 0.5
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Image.network('https://s3-alpha-sig.figma.com/img/7888/aa56/6467e793c77dd9f5011b0ee622e1da7e?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mBwjcclIvzG0v26bnjbvV18I93gtYkNA2Ajm0trTVlIwozIeT0vYZKBheAZ2qgmAAo83kk~RXjdBQrAKgBRfQxgamrboE~LJzwIA78acVrynU-KyAQSmCm-DJBV66baK5koI2dXgJ0faohWpTdbXvYzoPt-1CaXuXGI6seqHjalvH1SoLQkbhMIjgN4FkajhlWykREMIRjpxVeH~54F0LQxjyRPswzw1cBeE~Gt8WJxnWwD6ctPGHpJ1HvrIwdNfiEsdxYdeiY~8pnQtgm0NGSohZ58rvEYqT7mYNdabE0~hhi2HtFLoGq0dyvi7VxaDCMHJDw~Zy~MtcbPollEhLg__',width: screenwidth * 0.2,), // Replace with valid image URL
                        ),
                        Text('Mumbai'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenheight * 0.01),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.03),
              child: Row(
                children: [
                  Container(
                    height: screenheight * 0.03,
                    width: screenwidth * 0.01,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(width: screenwidth * 0.03),
                  Text(
                    'Other Cities',
                    style: TextStyle(color: Colors.black, fontSize: screenwidth * 0.05, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenheight * 0.01,),

            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.07),
              child: Container(
                height: screenheight * 0.4, // Give a specific height to the container
                child: ListView.builder(
                  itemCount: cities.length, // Use the length of your cities array
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: screenheight * 0.02,
                              width: screenwidth * 0.02,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle
                              ),
                            ),

                            SizedBox(width: screenwidth * 0.02,),

                            Text(cities[index], style: TextStyle(color: Colors.black),), // Use the city at the current index
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
