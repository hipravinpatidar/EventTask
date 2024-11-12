import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'event_details.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key,});


  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  Widget build(BuildContext context) {


    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.only(left: screenwidth * 0.04,top: screenheight * 0.02 ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenheight * 0.07,
              width: screenwidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: screenwidth * 0.06),
                child: Row(
                  children: [
                    Icon(Icons.local_offer,color: Colors.deepOrange,),

                    SizedBox(width: screenwidth * 0.04,),

                    Padding(
                      padding:  EdgeInsets.only(top: screenheight * 0.01),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Get 10% off',style: TextStyle(color: Colors.black,fontSize: screenwidth * 0.05,fontWeight: FontWeight.w600),),

                          Text('Maximum discount will be Rs. 150',style: TextStyle(color: Colors.black,fontSize: screenwidth * 0.03),),



                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            SizedBox(height: screenheight * 0.03,),

            Text('Expires on 30 Sep Sep 2024',style: TextStyle(color: Colors.grey,fontSize: screenwidth * 0.04),),

            SizedBox(height: screenheight * 0.02,),


            Container(
              width: screenwidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.03,vertical: screenheight * 0.01),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coupon Code',style: TextStyle(color: Colors.black87),),

                    Row(
                      children: [
                        Text('BMS10',style: TextStyle(color: Colors.black87),),


                        Spacer(),

                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: 'BMS10'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You have copied the code successfully'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                          },
                          child: Text('Copy code',style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    ),

                    Divider(
                      thickness: screenwidth * 0.0002,
                      color: Colors.black,
                    ),

                    Text('Paste the coupon code in Apply offers',style: TextStyle(color: Colors.black87),),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenheight * 0.03),


            Container(
              height: screenheight * 0.07,
              width: screenwidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(7)
              ),


              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenheight * 0.01),
                child: Text('Note: This coupin can be used only for one\n transaction',style: TextStyle(color: Colors.black),),
              ),
            ),

            SizedBox(height: screenheight * 0.02,),

            Row(
              children: [
                Container(
                  width: screenwidth * 0.01,
                  height: screenheight * 0.01,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                  ),
                ),

                SizedBox(width: screenwidth * 0.02,),

                Text('Maximum discount will be Rs 150'),
              ],
            ),

            SizedBox(height: screenheight * 0.02),


            Row(
              children: [
                Container(
                  width: screenwidth * 0.01,
                  height: screenheight * 0.01,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                  ),
                ),

                SizedBox(width: screenwidth * 0.02,),

                Text('Offer is valid till 30 Nov 2024 '),

                Spacer(), // Add a spacer to push the button to the right

              ],
            ),






          ],
        ),
      ),

      floatingActionButton: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenheight * 0.01),
        child: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Navigate to new screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDeatils()),
              );
            },
            label: Text('Continue Booking', style: TextStyle(fontSize: screenwidth * 0.04, color: Colors.white, fontWeight: FontWeight.w600)),
            icon: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.orange,
            elevation: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }
}
