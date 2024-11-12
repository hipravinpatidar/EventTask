import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/language_provider.dart';
import '../model/single_details_model.dart';
import 'event_details.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ProceedPage extends StatefulWidget {

  List? genralQuantity;
  var selectedPackageList = <PackageList>[];
  List? priceData;
  String? eventVenue;
  String? eventhiVenue;
  String? eventStartDate;
  String? eventEndTime;
  String? eventTime;
  String? eventDuration;
  int? totalTickets;

   ProceedPage({super.key,required this.totalAmount,this.genralQuantity,this.priceData,required this.selectedPackageList,this.eventVenue,this.eventStartDate,this.eventTime,this.eventEndTime,this.eventDuration,this.eventhiVenue,this.totalTickets});

  final String totalAmount;

  @override
  State<ProceedPage> createState() => _ProceedPageState();
}

class _ProceedPageState extends State<ProceedPage> {
  String? selectedState; // Variable to hold the selected state

  final List<String> states = [
    'Rajasthan',
    'Gujarat',
    'Maharashtra',
    'Punjab',
    'Karnataka',
    'Uttar Pradesh',
    'Tamil Nadu'
  ];

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade50,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Cancel Transaction?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  content: Text(
                    "Your selected seats will be unblocked and may not be available later if you cancel.",
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.red, width: 1),
                      ),
                      child: Text("Yes Cancel",
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventDeatils()),);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text("No", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.arrow_back_ios, size: screenwidth * 0.04),
        ),
        title: Consumer<LanguageProvider>(
          builder: (BuildContext context, languageProvider, Widget? child) {
            return Text(
              languageProvider.language == "english" ? 'Tickets options' : "टिकट के विकल्प",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: screenwidth * 0.05,color: Colors.orange),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenwidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Container(
                      width: screenwidth * 0.03,
                      height: screenheight * 0.03,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: screenwidth * 0.02),

                    Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider, Widget? child) {
                      return Text(
                        languageProvider.language == "english" ? 'M-Ticket' : 'M-टिकट',style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenwidth * 0.05),);
                    },
                    ),

                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.sunny, size: screenwidth * 0.03),
                    SizedBox(width: screenwidth * 0.02),
                    Consumer<LanguageProvider>(
                      builder: (BuildContext context, languageProvider, Widget? child) {
                        return  Expanded(
                          child: Text(
                              languageProvider.language == "english" ? 'Save the planet use your phone as a ticket' : "ग्रह को बचाएं अपने फ़ोन को टिकट के रूप में उपयोग करें",
                              style: TextStyle(fontSize: screenwidth * 0.03)),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.02),
                Container(
                  width: screenwidth * 0.92,
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenwidth * 0.04,
                        vertical: screenheight * 0.02),
                    child: Consumer<LanguageProvider>(
                      builder: (BuildContext context, languageProvider, Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                languageProvider.language == "english" ? 'M-Ticket information' : "M-टिकट की जानकारी",
                                style: TextStyle(
                                    fontSize: screenwidth * 0.04,
                                    fontWeight: FontWeight.w500)),

                            SizedBox(height: screenheight * 0.01),
                            Text(
                              languageProvider.language == "english" ? '1. Total Price: The total cost of the tickets, which is calculated by multiplying the ticket price by the ticket quantity.' : "1. कुल कीमत: टिकटों की कुल लागत, जिसकी गणना टिकट की कीमत को टिकट की मात्रा से गुणा करके की जाती है।"),
                            SizedBox(height: screenheight * 0.02),
                            Text(
                              languageProvider.language == "english" ? '2. Ticket Quantity: The number of tickets you want to book, which can be incremented or decremented using the "+" and "-" buttons.' : "2. टिकट की मात्रा: आप जितने टिकट बुक करना चाहते हैं, उसे ${"'+'"} और ${"'--'"} बटन का उपयोग करके बढ़ाया या घटाया जा सकता है।"),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenheight * 0.03),
                Container(
                  width: screenwidth * 0.92,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenwidth * 0.04,
                        vertical: screenheight * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                     //   Text(widget.eventTime!, style: TextStyle(color: Colors.black)),

                        // Text.rich(
                        //   TextSpan(
                        //
                        //     children: [
                        //       TextSpan(
                        //         text: ""
                        //       )
                        //     ]
                        //
                        //   )
                        // ),

                        Consumer<LanguageProvider>(
                          builder: (BuildContext context, languageProvider, Widget? child) {

                            String startToEndDate = widget.eventStartDate!;

                            // Define the input and output date formats
                            final inputFormat = DateFormat('yyyy-MM-dd');
                            final outputFormat = DateFormat('d MMM yyyy');

                            // Parse and format start date
                           String startDate = startToEndDate.isNotEmpty
                                ? outputFormat.format(inputFormat.parse(startToEndDate)) // "10 Nov 2024"
                                : 'No Start Date';

                            return Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: languageProvider.language == "english" ? "Start Date: " : "आरंभ करने की तिथि: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: screenwidth * 0.04),),
                                  TextSpan(text: startDate,style: TextStyle(fontWeight: FontWeight.w400)),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: screenwidth * 0.02,),
                        Consumer<LanguageProvider>(
                          builder: (BuildContext context, languageProvider, Widget? child) {

                            return Text.rich(
                              TextSpan(
                                children: [

                                  TextSpan(text: "${languageProvider.language == "english" ? "Start Time: " : "शुरू होने का समय: "}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: screenwidth * 0.04),),
                                  TextSpan(text: widget.eventTime,style: TextStyle(fontWeight: FontWeight.w400)),

                                  TextSpan(text: "\n${languageProvider.language == "english" ? "Close Time: " : "बंद होने का समय: "}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: screenwidth * 0.04),),
                                  TextSpan(text: widget.eventEndTime,style: TextStyle(fontWeight: FontWeight.w400)),

                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: screenwidth * 0.02,),
                        Consumer<LanguageProvider>(
                          builder: (BuildContext context, languageProvider, Widget? child) {

                            return Text.rich(
                              TextSpan(
                                children: [

                                  TextSpan(text: "${languageProvider.language == "english" ? "Event Duration: " : "आयोजन की अवधि: "}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),),
                                  TextSpan(text: widget.eventDuration,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.red)),

                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: screenheight * 0.01),
                        Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider, Widget? child) {
                          return Text(
                            languageProvider.language == "english" ? widget.eventVenue! : widget.eventhiVenue!,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: screenwidth * 0.04));
                        },
                        ),
                        Divider(
                          color: Colors.grey,
                          height: screenheight * 0.02,
                          thickness: screenwidth * 0.001,
                        ),

                        ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,itemCount: widget.selectedPackageList.length,itemBuilder: (context, index) {
                          return  Consumer<LanguageProvider>(
                            builder: (BuildContext context, languageProvider, Widget? child) {
                              return  Row(
                                children: [

                                  Text.rich(
                                      TextSpan(
                                          children: [

                                            TextSpan(text: "${index + 1}.",style: TextStyle(fontWeight: FontWeight.bold)),
                                            TextSpan(text: languageProvider.language == "english" ? " ${widget.selectedPackageList[index].enPackageName}" : " ${widget.selectedPackageList[index].hiPackageName}",style: TextStyle(fontWeight: FontWeight.w500)),
                                            TextSpan(text: " ${widget.genralQuantity![index]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                                            TextSpan(text: languageProvider.language == "english" ? " TICKETS" : " टिकट",style: TextStyle(fontWeight: FontWeight.w500)),

                                          ]
                                      )
                                  ),

                                  //  Text('${index + 1}. ${widget.selectedPackageList[index].enPackageName} ${widget.genralQuantity![index]} TICKETS', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
                                  Spacer(),
                                  Text("${widget.priceData![index]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500))
                                ],
                              );
                            },
                          );
                        },),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Text('Total TICKETS'),
                          Spacer(),
                          SizedBox(width: screenwidth * 0.02,),
                          Text('${widget.totalTickets}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenwidth * 0.04),),
                            ],
                      ),

                      Divider(
                        color: Colors.grey,
                        height: screenheight * 0.02,
                        thickness: screenwidth * 0.001,
                      ),

                      Row(
                        children: [
                          Text('Total Amount'),
                          Spacer(),
                          Text('₹ ${widget.totalAmount}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenwidth * 0.04),),                      ],
                      ),

                      SizedBox(height: screenwidth * 0.01,),
                      Row(
                        children: [
                          Text('Apply Coupon code'),
                          Spacer(),
                          SizedBox(width: screenwidth * 0.02,),

                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)
                            ),
                            child: Center(child: Text("-------",style: TextStyle(fontSize: screenwidth * 0.08,color: Colors.grey),))
                          ),

                          // Text('${widget.totalTickets}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenwidth * 0.04),),
                        ],
                      ),

                      SizedBox(
                        height: screenheight * 0.02,
                      ),

                      Row(
                        children: [
                          Text('Total Payable Amount'),
                          Spacer(),
                          Text('₹ ${widget.totalAmount}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenwidth * 0.04),),                      ],
                      ),

                      Divider(
                        color: Colors.grey,
                        height: screenheight * 0.02,
                        thickness: screenwidth * 0.001,
                      ),

                      SizedBox(height: screenheight * 0.08,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.02,
          vertical: screenheight * 0.01,
        ),
        child: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Show a dialog box
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Congratulations'),
                    content: Text('Your Ticket is successfully Booked',style: TextStyle(fontWeight: FontWeight.w500),),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('More Tickets Booked'),
                        onPressed: () {
                          // Navigate to new screen
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => Frontpage()),);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text('Proceed to Pay',
              style: TextStyle(
                fontSize: screenwidth * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.red,
            elevation: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
