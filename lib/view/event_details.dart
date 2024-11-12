import 'dart:async';
import 'package:eventdesign/api_service.dart';
import 'package:eventdesign/controller/language_provider.dart';
import 'package:flutter/material.dart';
import '../model/single_details_model.dart';
import '../model/subCategory_model.dart';
import 'BottomSheetPage.dart';
import 'ProceedPage.dart';
import 'SeeScreen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDeatils extends StatefulWidget {
  final int? eventId;

  List<SubData>? eventSubCategory = [];

   EventDeatils(
      {super.key, this.eventId, this.eventSubCategory});

  get imageDescription => null;
  get imageTitle => null;

  @override
  State<EventDeatils> createState() => _EventDeatilsState();
}

class _EventDeatilsState extends State<EventDeatils> {

  late DateTime eventStartDateTime;
  late Duration timeRemaining;
  late String countdownText;

  late int days;
  late int hours;
  late int minutes;
  late int seconds;

  bool isLoading = false;
  bool _isExpanded = false;
  bool _isCitySelected = false;

  String startDate = "";
  String endDate = "";
  String myendDate = "";
  String mystartDate = "";
  String venueSelected = "";
  String venuehindiSelected = "";
  String selectStartDate = "";
  String selectEndTime = "";
  String selectTime = "";
  String eventDuration = "";

  int _selectedIndex = -1;
  int totalCount = 0;

  double totalAmount = 0.0;

  List<bool> _isAdded = [];
  List<int> quantity = [];
  List<double> prices = [];

  Data? singleEventData;

  Data? selectedEventData;

  List<AllVenueDatum> allVenueData = [];
  var selectedPackageList = <PackageList>[];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedIndex;
    print(" My Event Id is ${widget.eventId}");
    getSingleEventData(widget.eventId!);
  }

  @override
  void dispose() {
    // Dispose the controller when done
    _scrollController.dispose();
    super.dispose();
  }

  // Function to update the countdown
  void updateCountdown() {
    DateTime currentTime = DateTime.now();
    timeRemaining = eventStartDateTime.difference(currentTime);

    // Calculate the remaining time in days, hours, minutes, and seconds
    if (timeRemaining.isNegative) {
      countdownText = "Event has started!";
    } else {
      days = timeRemaining.inDays;
      hours = timeRemaining.inHours % 24;
      minutes = timeRemaining.inMinutes % 60;
      seconds = timeRemaining.inSeconds % 60;
    }
  }

  // Method to show event details
  void showEventDetails(Data eventData) {
    setState(() {
      selectedEventData = eventData; // Set the selected event data
    });
  }

  void _scrollToSelectedIndex(int index) {
    // Calculate the offset for the item based on its index and item width
    double screenwidth = MediaQuery.of(context).size.width;
    double itemWidth = screenwidth * 0.36; // Adjust this based on actual item width
    double targetPosition = index * itemWidth;

    // Scroll to the calculated position with animation
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Function to keep updating the countdown every second
  void _updateCountdownEverySecond() {
    setState(() {
      updateCountdown();
    });

    // Keep calling the function every second to update the countdown
    Future.delayed(Duration(seconds: 1), _updateCountdownEverySecond);
  }

  // Function to toggle Read More/Read Less for the additional sections
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

// Increment quantity function
  void incrementQuantity(int index) {
    setState(() {
      if (quantity[index] < double.infinity) quantity[index]++;
      updateTotalAmount();
    });
  }

// Decrement quantity function
  void decrementQuantity(int index) {
    setState(() {
      if (quantity[index] > 0) {
        quantity[index]--;
        updateTotalAmount();
      } else {
        _isAdded[index] =
            false; // Reset to "Add" button if quantity goes below 1
      }
    });
  }

  // void updateTotalAmount() {
  //   totalAmount = 0.0; // Reset total amount
  //   totalCount = quantity.reduce((sum, item) => sum + item); // Update total count
  //
  //   totalAmount = quantity.asMap().entries.map((entry) {
  //     int index = entry.key;
  //     int count = entry.value;
  //     return count * prices[index]; // Calculate total price for each item
  //   }).reduce((sum, item) => sum + item); // Sum up all the prices
  //
  //   print('Total Count: $totalCount'); // Print total count
  //   print('Total Amount: $totalAmount'); // Print total amount after calculation
  // }

  // Define a new list to store the amounts for each package type
  List<double> amounts = []; // Initialize with zeros

  void updateTotalAmount() {
    totalAmount = 0.0; // Reset total amount
    totalCount = quantity.reduce((sum, item) => sum + item); // Update total count

    // Calculate total price for each item and store it in the amounts list
    amounts = quantity.asMap().entries.map((entry) {
      int index = entry.key;
      int count = entry.value;
      double amount = count * prices[index]; // Calculate total price for each item
      return amount; // Return the calculated amount
    }).toList(); // Convert to a list

    // Now sum up all the amounts for the total amount
    totalAmount = amounts.reduce((sum, item) => sum + item); // Sum up all the prices

    print('Total Count: $totalCount'); // Print total count
    print('Total Amount: $totalAmount'); // Print total amount after calculation
    print('Individual Amounts: $amounts'); // Print individual amounts for each package
  }

  // void updateTotalAmount() {
  //   totalAmount = 0.0; // Reset total amount
  //   totalCount = quantity.reduce((sum, item) => sum + item); // Update total count
  //
  //   totalAmount = quantity.asMap().entries.map((entry) {
  //     int index = entry.key;
  //     int count = entry.value;
  //     return count > 0 ? (count * prices[index]).toDouble() : 0.0; // Ensure it's double
  //   }).reduce((sum, item) => sum + item).toDouble(); // Sum up all the prices
  //
  //   print('Total Count: $totalCount'); // Print total count
  //   print('Total Amount: $totalAmount'); // Print total amount after calculation
  // }

  Future<void> getSingleEventData(int eventDetailsId) async {
    String url = "https://mahakal.rizrv.in/api/v1/event/geteventbyid";

    Map<String, dynamic> data = {"event_id": eventDetailsId};

    setState(() {
      isLoading = true;
    });
    try {
      final res = await ApiService().postData(url, data);

      print(res);

      if (res != null) {
        final singleData = SingleDetailsModel.fromJson(res);
        setState(() {
          singleEventData = singleData.data as Data?;

          allVenueData = singleData.data.allVenueData;
          print(singleEventData?.enEventName);
          print(allVenueData.length);


          String startToEndDate = "2024-11-17 - 2024-11-19";
              //singleEventData!.startToEndDate;
          List<String> dates = startToEndDate.split(" - ");

          // Define the input and output date formats
          final inputFormat = DateFormat('yyyy-MM-dd');
          final outputFormat = DateFormat('d MMM yyyy');

          // Parse and format start date
          mystartDate = dates.isNotEmpty
              ? outputFormat.format(inputFormat.parse(dates[0])) // "10 Nov 2024"
              : 'No Start Date';

          // Parse and format end date if available
          myendDate = dates.length > 1
              ? outputFormat.format(inputFormat.parse(dates[1])) // "15 Nov 2024"
              : 'No End Date';


          startDate = dates[0]; // "2024-11-10"
          endDate = dates[1]; // "2024-11-11"

          print("Start Date: $startDate");
          print("End Date: $endDate");

          // Set the event start date (use the start of the event)
          eventStartDateTime =
              DateTime.parse(startDate); // Event start date (2024-11-10)

          // Initialize the countdown
          updateCountdown();

          // Update the countdown every second (you can also use Timer)
          Future.delayed(Duration(seconds: 1), _updateCountdownEverySecond);
        });
      }
    } catch (e) {
      print(" Error in SingleDetails ${e}");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void>interestedEvent(int EventId) async{

    String url = "https://mahakal.rizrv.in/api/v1/event/addinterested";

    Map<String,dynamic> data = {
      "event_id": EventId,
      "user_id":40   // Here we have to pass user Id
    };

    try{
      final res = await ApiService().postData(url, data);
      print(res);

    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: Image.network(
                            singleEventData!.eventImage,
                            fit: BoxFit.fill,
                          ),
                          height: screenheight * 0.4,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: screenheight * 0.05,
                          left: screenwidth * 0.05,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: screenwidth * 0.06,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03,vertical: screenwidth * 0.02),
                      child: Consumer<LanguageProvider>(
                        builder: (BuildContext context, languageProvider, Widget? child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languageProvider.language == "english" ? singleEventData!.enEventName : singleEventData!.hiEventName,
                                style: TextStyle(
                                    fontSize: screenwidth * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(255, 118, 10, 1)),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01,vertical: screenwidth * 0.02),
                                child: Container(
                                    width: screenwidth * double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenwidth * 0.03,
                                          vertical: screenheight * 0.01),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            languageProvider.language == "english" ? 'Mark intrested to know more about this event' : "इस इवेंट के बारे में अपडेट रहने के लिए इच्छुक पर क्लिक करें",
                                            style: TextStyle(
                                                fontSize: screenwidth * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: screenwidth * 0.02,
                                              ),
                                              Text(
                                                languageProvider.language == "english" ? "${singleEventData!.eventInterested} People Intrested" : "${singleEventData!.eventInterested} लोगों ने हाल ही मेंरुचि दिखाई है",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: screenwidth * 0.04),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  interestedEvent(singleEventData!.id);
                                                  getSingleEventData(widget.eventId!);
                                                },
                                                child: Container(
                                                  width: screenwidth * 0.2,
                                                  height: screenheight * 0.05,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    border:
                                                    Border.all(color: Colors.red),
                                                    color: Color.fromRGBO(
                                                        239, 232, 221, 1.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        languageProvider.language == "english" ? "Intrested?" : "इच्छुक?",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                  ),

                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),


                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.black,
                                      size: screenwidth * 0.04),
                                  SizedBox(width: screenwidth * 0.02),
                                  Expanded(
                                    child: Text(
                                      languageProvider.language == "english" ? singleEventData!.allVenueData[0].enEventVenue :  singleEventData!.allVenueData[0].hiEventVenue,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenwidth * 0.04,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),

                              SizedBox(height: screenheight * 0.01),

                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      color: Colors.black,
                                      size: screenwidth * 0.04),
                                  SizedBox(width: screenwidth * 0.02),

                                  Text.rich(
                                    TextSpan(
                                      children: [

                                        TextSpan(
                                          text:languageProvider.language == "english" ? "Event booking will close: " : "इवेंट बुकिंग बंद हो जाएगी: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: screenwidth * 0.04)
                                        ),

                                        TextSpan(
                                          text: mystartDate,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)
                                        )

                                      ]
                                    )
                                  )

                                ],
                              ),

                              SizedBox(height: screenheight * 0.02),

                              timeRemaining.isNegative
                                  ? Container()
                                  : Row(
                                children: [
                                  Container(
                                    height: screenheight * 0.05,
                                    width: screenwidth * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Color.fromRGBO(255, 238, 211, 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                          languageProvider.language == "english" ? '${days} Days' : "${days} दिन",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenwidth * 0.04),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Container(
                                    height: screenheight * 0.05,
                                    width: screenwidth * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Color.fromRGBO(255, 238, 211, 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                          languageProvider.language == "english" ? '${hours} Hours' : "${hours} घंटे",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenwidth * 0.04),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Container(
                                    height: screenheight * 0.05,
                                    width: screenwidth * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Color.fromRGBO(255, 238, 211, 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                          languageProvider.language == "english" ? '${minutes} Mins' : "${minutes} मिनट",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenwidth * 0.04),
                                  ),
                                  SizedBox(
                                    width: screenwidth * 0.01,
                                  ),
                                  Container(
                                    height: screenheight * 0.05,
                                    width: screenwidth * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Color.fromRGBO(255, 238, 211, 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                          languageProvider.language == "english" ? '${seconds} Sec' : "${seconds} सेकेंड",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: screenheight * 0.02,
                              ),

                              Text(
                                languageProvider.language == "english" ? 'Top Offers For You' : "आपके लिए शीर्ष ऑफर",
                                style: TextStyle(
                                    fontSize: screenwidth * 0.05,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenwidth * 0.03),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20.0)),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      backgroundColor: Colors.white,
                                      elevation: 10,
                                      builder: (context) => BottomSheetPage(),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: screenwidth * 0.02,horizontal: screenwidth * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [

                                              Icon(Icons.local_offer_outlined),

                                              SizedBox(width: screenwidth * 0.01,),

                                              Text(
                                                languageProvider.language == "english" ? 'Enjoy Coupons' : "कूपन का आनंद लें",
                                                style: TextStyle(
                                                    fontSize: screenwidth * 0.04,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              languageProvider.language == "english" ? 'Tap to view details' : "विवरण देखने के लिए टैप करें",
                                          ),
                                          //  SizedBox(height: screenheight * 0.01,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: screenheight * 0.03,
                                    width: screenwidth * 0.01,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(width: screenwidth * 0.02),
                                  Text(
                                    languageProvider.language == "english" ? 'About these Event' : "इन इवेंट के बारे में",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenwidth * 0.05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),

                              Html(data:
                              languageProvider.language == "english" ? singleEventData!.enEventAbout : singleEventData!.hiEventAbout,
                              ),

                              Row(
                                children: [
                                  Container(
                                    height: screenheight * 0.03,
                                    width: screenwidth * 0.01,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(width: screenwidth * 0.02),
                                  Text(
                                    languageProvider.language == "english" ? "Multiple Venues" : "स्थल का पता",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenwidth * 0.05,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenwidth * 0.02,horizontal: screenwidth * 0.02),
                                child: Container(
                                  height:
                                  screenheight * 0.05, // Adjust height as needed
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: allVenueData.length, // Number of items
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                            width: screenwidth * 0.04,
                                            height: screenheight * 0.04,
                                            decoration: BoxDecoration(
                                                color: _selectedIndex == index
                                                    ? Colors.black
                                                    : Colors.grey,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                "${index + 1}",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenwidth * 0.01),
                                          Text(
                                              languageProvider.language == "english" ? "Venue" : "कार्यक्रम का स्थान",
                                              style: TextStyle(
                                                  color: _selectedIndex == index
                                                      ? Colors.black
                                                      : Colors.grey)),
                                          SizedBox(width: screenwidth * 0.02),
                                          Icon(Icons.arrow_forward_ios_rounded,
                                              size: screenwidth * 0.03,
                                              color: Colors.grey),
                                          SizedBox(width: screenwidth * 0.02),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),

                              Text(
                                  languageProvider.language == "english" ? "Select Venue" : "स्थान चुनें",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),

                              SizedBox(height: screenwidth * 0.02,),
                              Container(
                                height:
                                screenheight * 0.07, // Adjust height as needed
                                child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allVenueData.length, // Number of items
                                  itemBuilder: (context, index) {
                                    var event = allVenueData[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = index;
                                          _isCitySelected = true;
                                          selectedPackageList = event.packageList;

                                          venueSelected = allVenueData[index].enEventVenue;
                                          venuehindiSelected = allVenueData[index].hiEventVenue;
                                          selectStartDate = allVenueData[index].date.toString();
                                          selectEndTime = allVenueData[index].endTime;
                                          selectTime = allVenueData[index].startTime;
                                          eventDuration = allVenueData[index].eventDuration;

                                          _isAdded = List.generate(selectedPackageList.length, (index) => false);
                                          quantity = List.generate(selectedPackageList.length, (index) => 0);
                                          prices = selectedPackageList.map((package) => double.parse(package.priceNo)).toList(); // Convert priceNo to double

                                          print("My package list length is ${selectedPackageList.length}");
                                        });
                                        _scrollToSelectedIndex(index);
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: _selectedIndex == index
                                              ? BorderSide(
                                              color: Colors.deepOrange,
                                              width: screenwidth * 0.01)
                                              : BorderSide(color: Colors.grey),
                                        ),
                                        color: _selectedIndex == index
                                            ? Colors.orange[100]
                                            : Colors.white,
                                        elevation: 4,
                                        child: Container(
                                          width: screenwidth * 0.36,
                                          child: SizedBox(
                                            width: screenwidth * 0.03,
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                                child: Text(
                                                  languageProvider.language == "english" ?  event.enEventVenue :  event.hiEventVenue,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: screenwidth * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                               selectedPackageList.isNotEmpty
                                   ?
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: selectedPackageList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth * 0.02),
                                    child: Container(
                                      width: screenwidth * 0.93,
                                      margin: EdgeInsets.only(
                                          bottom: screenheight * 0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenheight * 0.01),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  screenwidth * 0.02),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        languageProvider.language == "english" ? selectedPackageList[index].enPackageName : selectedPackageList[index].hiPackageName,
                                                        style: TextStyle(
                                                          color:
                                                          _isCitySelected
                                                              ? Colors
                                                              .black87
                                                              : Colors
                                                              .grey,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                          screenheight *
                                                              0.01),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            selectedPackageList[
                                                            index]
                                                                .priceNo,
                                                            style: TextStyle(
                                                              //fontSize: screenwidth * 0.03,
                                                              color: _isCitySelected
                                                                  ? Colors
                                                                  .black87
                                                                  : Colors
                                                                  .grey,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                              screenwidth *
                                                                  0.01),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  //add button
                                                  _isAdded[index]
                                                      ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        screenwidth *
                                                            0.06,
                                                        bottom:
                                                        screenwidth *
                                                            0.02),
                                                    child: Container(
                                                        width:
                                                        screenwidth *
                                                            0.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green),
                                                            color: Colors
                                                                .green),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                              screenwidth *
                                                                  0.0002),
                                                          child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Text(
                                                                  "Add",
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w700,
                                                                      fontFamily: 'Roboto',
                                                                      color: Colors.white),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  2,
                                                                ),
                                                                Spacer(),
                                                                GestureDetector(
                                                                  child:
                                                                  Container(
                                                                    width:
                                                                    screenwidth * 0.1,
                                                                    decoration:
                                                                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
                                                                    child:
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: screenwidth * 0.01),
                                                                      child: Icon(
                                                                        Icons.add,
                                                                        color: Colors.green,
                                                                        size: 30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap:
                                                                      () {
                                                                    setState(() {
                                                                      _isAdded[index] = !_isAdded[index];
                                                                       updateTotalAmount();
                                                                      print(_isAdded[index]);

                                                                    });
                                                                  },
                                                                )
                                                              ]),
                                                        )),
                                                  )
                                                      : Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        screenwidth *
                                                            0.09,
                                                        bottom:
                                                        screenwidth *
                                                            0.02),
                                                    child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                                border: Border.all(
                                                                    color:
                                                                    Colors.green)),
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    decrementQuantity(index);
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: screenwidth * 0.01,
                                                                      horizontal: screenwidth * 0.01),
                                                                  child:
                                                                  const Icon(
                                                                    Icons.remove,
                                                                    size:
                                                                    26,
                                                                    color:
                                                                    Colors.black,
                                                                  ),
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            screenwidth *
                                                                0.02,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green),
                                                                color: Colors
                                                                    .green),
                                                            child: Center(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: screenwidth *
                                                                          0.02,
                                                                      horizontal:
                                                                      screenwidth * 0.1),
                                                                  child:
                                                                  Text(
                                                                    "${quantity[index]}"
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.white,
                                                                        fontSize: 16),
                                                                  ),
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            screenwidth *
                                                                0.02,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                                border: Border.all(
                                                                    color:
                                                                    Colors.green)),
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    incrementQuantity(index);
                                                                  });

                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: screenwidth * 0.01,
                                                                      horizontal: screenwidth * 0.01),
                                                                  child:
                                                                  Icon(
                                                                    Icons.add,
                                                                    size:
                                                                    26,
                                                                    color:
                                                                    Colors.black,
                                                                  ),
                                                                )),
                                                          ),
                                                        ]),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenheight * 0.01),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                                  : Container(),
                              Consumer<LanguageProvider>(
                                builder: (BuildContext context, languageProvider, Widget? child) {
                                  return  ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenwidth * 0.001),
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      // First section
                                      Html(
                                          data: languageProvider.language == "english" ? singleEventData!.enEventAttend :  singleEventData!.hiEventAttend
                                      ),

                                      // Only show the following sections when expanded
                                      if (_isExpanded) ...[
                                        Html(data: languageProvider.language == "english" ? singleEventData!.enEventSchedule : singleEventData!.hiEventSchedule)
                                      ],

                                      // "Read More" button that toggles the visibility of the next two sections
                                      Padding(
                                        padding:
                                        EdgeInsets.only(left: screenwidth * 0.7),
                                        child: GestureDetector(
                                          onTap: _toggleExpand,
                                          child: Row(
                                            children: [
                                              Icon(
                                                _isExpanded
                                                    ? Icons.keyboard_arrow_up_outlined
                                                    : Icons.keyboard_arrow_down,
                                                color: Colors.blue,
                                              ),
                                              Text(
                                                _isExpanded ?
                                                 (languageProvider.language == "english" ? "Read Less" : "कम पढ़ें") :
                                                     (languageProvider.language == "english" ? "Read More" : "और पढ़ें"),
                                                    style: TextStyle(
                                                    color: Colors.blue, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // SizedBox(height: screenheight * 0.02),
                              // Container(
                              //   width: screenwidth * double.infinity,
                              //   decoration: BoxDecoration(
                              //       color: Colors.purple.shade50,
                              //       borderRadius: BorderRadius.circular(7)),
                              //   child: Padding(
                              //     padding:
                              //     EdgeInsets.only(left: screenwidth * 0.04),
                              //     child: Padding(
                              //       padding:
                              //       EdgeInsets.only(top: screenheight * 0.005),
                              //       child: Row(
                              //         children: [
                              //           Icon(
                              //             Icons.lightbulb_outline,
                              //             color: Colors.yellow.shade900,
                              //             size: screenwidth * 0.07,
                              //           ),
                              //           SizedBox(width: screenwidth * 0.03),
                              //           Padding(
                              //             padding: EdgeInsets.only(
                              //                 top: screenheight * 0.001),
                              //             child: Column(
                              //               crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   'You should Know',
                              //                   style: TextStyle(
                              //                       fontSize: screenwidth * 0.04,
                              //                       fontWeight: FontWeight.w500),
                              //                 ),
                              //                 Text(
                              //                   'Seating is on a first come first serve basis in that\nrespective sector.',
                              //                   style: TextStyle(
                              //                     fontSize: screenwidth * 0.03,
                              //                   ),
                              //                 ),
                              //                 SizedBox(height: screenheight * 0.01),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              SizedBox(height: screenheight * 0.02),
                              Row(
                                children: [
                                  Container(
                                    height: screenheight * 0.03,
                                    width: screenwidth * 0.01,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(width: screenwidth * 0.02),
                                  Text(
                                    'Artist',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenwidth * 0.04,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenheight * 0.02),
                              // GestureDetector(
                              //   onTap: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return Dialog(
                              //           child: Column(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: [
                              //               Image.network(widget.image),
                              //               SizedBox(height: 16),
                              //               Text('Image Title: ${widget.name}',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.w600)),
                              //             ],
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              //   child: Container(
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.circular(7),
                              //       child: Image.network(
                              //         widget.image,
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //     width: screenwidth * 0.3,
                              //     decoration: BoxDecoration(
                              //       border: Border.all(color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                              // Text(
                              //   widget.name,
                              //   style: TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.w500),
                              // ),
                             // Text('Actor'),
                              SizedBox(height: screenheight * 0.02),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    builder: (context) => Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Html(data: languageProvider.language == "english" ? singleEventData!.enEventTeamCondition : singleEventData!.hiEventTeamCondition ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: screenwidth * 0.93,
                                  height: screenheight * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth * 0.02),
                                    child: Row(
                                      children: [
                                        Text(
                                            languageProvider.language == "english" ? 'Terms & Conditions' : "नियम एवं शर्तें",
                                          style: TextStyle(fontSize: screenwidth * 0.04,fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                            size: screenwidth * 0.04)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenwidth * 0.03,vertical: screenwidth * 0.02),
                      child: Consumer<LanguageProvider>(
                        builder: (BuildContext context, languageProvider, Widget? child) {
                          return Row(
                            children: [
                              Container(
                                height: screenheight * 0.03,
                                width: screenwidth * 0.01,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(
                                width: screenwidth * 0.02,
                              ),
                              Text(
                                languageProvider.language == "english" ? 'You might also like' : "आप इसे भी पसंद कर सकते हैं",
                                style: TextStyle(
                                    fontSize: screenwidth * 0.05,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeeScreen(),
                                      ));
                                },
                                child: Text(
                                  languageProvider.language == "english" ? 'See All' : "सभी देखें",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 139, 33, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenheight * 0.19,
                          child:

                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: widget.eventSubCategory!.length,
                            itemBuilder: (context, index) {
                              var currentEvent = widget.eventSubCategory![index];
                              String startToEndDate = currentEvent.startToEndDate;
                              List<String> dates = startToEndDate.split(" - ");
                              String startDate = dates.isNotEmpty ? dates[0] : 'No Start Date';
                              String endDate = dates.length > 1 ? dates[1] : 'No End Date';

                              var venueData = currentEvent.allVenueData;
                              if (venueData.isEmpty) {
                                return SizedBox.shrink();
                              }

                              var packageList = venueData[0].packageData;
                              if (packageList.isEmpty) {
                                return SizedBox.shrink();
                              }

                              return GestureDetector(
                                onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => EventDeatils(eventId: currentEvent.id, eventSubCategory: widget.eventSubCategory,),),);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02, vertical: screenwidth * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(screenwidth * 0.02),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: screenwidth * 0.3,
                                            width: screenwidth * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              image: DecorationImage(image: NetworkImage(currentEvent.eventImage), fit: BoxFit.cover),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                            child: Consumer<LanguageProvider>(
                                              builder: (BuildContext context, languageProvider, Widget? child) {
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: screenwidth * 0.4,
                                                      child: Text(
                                                        languageProvider.language == "english" ? currentEvent.enEventName : currentEvent.hiEventName,
                                                        style: TextStyle(
                                                          fontSize: screenwidth * 0.04,
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.w500,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        textAlign: TextAlign.start,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: languageProvider.language == "english" ? "Start Date: " : "आरंभ करने की तिथि: ",
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.03),
                                                          ),
                                                          TextSpan(text: startDate),
                                                          TextSpan(
                                                            text: "\n${languageProvider.language == "english" ? "End Date: " : "अंतिम तिथि: "}",
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.03),
                                                          ),
                                                          TextSpan(text: endDate),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: screenwidth * 0.02),
                                                    Container(
                                                      width: screenwidth * 0.47,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: Colors.orangeAccent,
                                                        boxShadow: [
                                                          BoxShadow(

                                                            color: Colors.black.withOpacity(0.2), // Adjust shadow color and opacity
                                                            spreadRadius: 2,                      // Adjust how much the shadow spreads
                                                            blurRadius: 5,                         // Adjust the blur intensity
                                                            offset: Offset(0, 3),

                                                          )
                                                        ]
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02, vertical: screenwidth * 0.02),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              languageProvider.language == "english" ? "Rs : ${packageList[0].priceNo}" : "₹ : ${packageList[0].priceNo}",
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            Spacer(),
                                                            Text('|', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                                                            SizedBox(width: screenwidth * 0.02),
                                                            Text(
                                                              languageProvider.language == "english" ? "Buy Now" : "अभी खरीदें",
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: screenheight * 0.09,
                    )
                  ],
                ),
              ),
         floatingActionButton:
            Padding(
          padding: EdgeInsets.only(
            left: screenwidth * 0.08
          ),
          child: Container(
            width: double.infinity,
            height: screenheight * 0.07,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenwidth * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              screenwidth * 0.04, // Add padding to the left side
                        ),
                        child: Text(
                          '${totalCount} Ticket(s) | ₹ ${totalAmount.toStringAsFixed(2)}', // Display count and total price
                          style: TextStyle(
                            fontSize: screenwidth * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right:
                              screenwidth * 0.04, // Add padding to the right side
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (totalCount == 0 || _selectedIndex == -1) {
                              // Show error dialog if no tickets or venue selected
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content:
                                        Text("Please select tickets and venue"),
                                    actions: [
                                      ElevatedButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Navigate to next screen if tickets and venue selected
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProceedPage(
                                      totalAmount:  totalAmount.toStringAsFixed(2),genralQuantity: quantity,priceData: amounts,selectedPackageList: selectedPackageList,eventVenue: venueSelected,eventStartDate: selectStartDate,eventTime: selectTime,eventEndTime: selectEndTime,eventDuration: eventDuration,eventhiVenue: venuehindiSelected,totalTickets: totalCount,)),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Consumer<LanguageProvider>(
                            builder: (BuildContext context, languageProvider, Widget? child) {
                              return  Text(
                                languageProvider.language == "english" ? 'Proceed': 'आगे बढे',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        );
  }
}

// import 'dart:async';
// import 'package:eventdesign/api_service.dart';
// import 'package:eventdesign/controller/language_provider.dart';
// import 'package:flutter/material.dart';
// import '../model/single_details_model.dart';
// import '../model/subCategory_model.dart';
// import 'BottomSheetPage.dart';
// import 'ProceedPage.dart';
// import 'SeeScreen.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class EventDeatils extends StatefulWidget {
//   final int? eventId;
//   List<SubData>? eventSubCategory = [];
//
//   EventDeatils({super.key, this.eventId, this.eventSubCategory});
//
//   @override
//   State<EventDeatils> createState() => _EventDeatilsState();
// }
//
// class _EventDeatilsState extends State<EventDeatils> {
//   late DateTime eventStartDateTime;
//   late Duration timeRemaining;
//   late String countdownText;
//
//   late int days;
//   late int hours;
//   late int minutes;
//   late int seconds;
//
//   bool isLoading = false;
//   bool _isExpanded = false;
//   bool _isCitySelected = false;
//
//   String startDate = "";
//   String endDate = "";
//   String myendDate = "";
//   String mystartDate = "";
//
//   int _selectedIndex = -1;
//   int totalCount = 0;
//
//   double totalAmount = 0.0;
//
//   List<bool> _isAdded = [];
//   List<int> quantity = [];
//   List<double> prices = [];
//
//   Data? singleEventData;
//   Data? selectedEventData; // State variable for selected event data
//
//   List<AllVenueDatum> allVenueData = [];
//   var selectedPackageList = <PackageList>[];
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     print(" My Event Id is ${widget.eventId}");
//     getSingleEventData(widget.eventId!);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   // Function to update the countdown
//   void updateCountdown() {
//     DateTime currentTime = DateTime.now();
//     timeRemaining = eventStartDateTime.difference(currentTime);
//
//     if (timeRemaining.isNegative) {
//       countdownText = "Event has started!";
//     } else {
//       days = timeRemaining.inDays;
//       hours = timeRemaining.inHours % 24;
//       minutes = timeRemaining.inMinutes % 60;
//       seconds = timeRemaining.inSeconds % 60;
//     }
//   }
//
//   // Method to show event details
//   void showEventDetails(Data eventData) {
//     setState(() {
//       selectedEventData = eventData; // Set the selected event data
//     });
//   }
//
//   void _scrollToSelectedIndex(int index) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     double itemWidth = screenwidth * 0.36;
//     double targetPosition = index * itemWidth;
//
//     _scrollController.animateTo(
//       targetPosition,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   // Function to keep updating the countdown every second
//   void _updateCountdownEverySecond() {
//     setState(() {
//       updateCountdown();
//     });
//
//     Future.delayed(Duration(seconds: 1), _updateCountdownEverySecond);
//   }
//
//   // Function to toggle Read More/Read Less for the additional sections
//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }
//
//   // Increment quantity function
//   void incrementQuantity(int index) {
//     setState(() {
//       if (quantity[index] < double.infinity) quantity[index]++;
//       updateTotalAmount();
//     });
//   }
//
//   // Decrement quantity function
//   void decrementQuantity(int index) {
//     setState(() {
//       if (quantity[index] > 0) {
//         quantity[index]--;
//         updateTotalAmount();
//       } else {
//         _isAdded[index] = true; // Reset to "Add" button if quantity goes below 1
//       }
//     });
//   }
//
//   void updateTotalAmount() {
//     totalAmount = 0.0; // Reset total amount
//     totalCount = quantity.reduce((sum, item) => sum + item); // Update total count
//
//     totalAmount = quantity.asMap().entries.map((entry) {
//       int index = entry.key;
//       int count = entry.value;
//       return count * prices[index]; // Calculate total price for each item
//     }).reduce((sum, item) => sum + item); // Sum up all the prices
//
//     print('Total Count: $totalCount'); // Print total count
//     print('Total Amount: $totalAmount'); // Print total amount after calculation
//   }
//
//   Future<void> getSingleEventData(int eventDetailsId) async {
//     String url = "https://mahakal.rizrv.in/api/v1/event/geteventbyid";
//
//     Map<String, dynamic> data = {"event_id": eventDetailsId};
//
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final res = await ApiService().postData(url, data);
//
//       if (res != null) {
//         final singleData = SingleDetailsModel.fromJson(res);
//         setState(() {
//           singleEventData = singleData.data as Data?;
//           allVenueData = singleData.data.allVenueData;
//
//           String startToEndDate = "2024-11-17 - 2024-11-19";
//           List<String> dates = startToEndDate.split(" - ");
//
//           final inputFormat = DateFormat('yyyy-MM-dd');
//           final outputFormat = DateFormat('d MMM yyyy');
//
//           mystartDate = dates.isNotEmpty
//               ? outputFormat.format(inputFormat.parse(dates[0]))
//               : 'No Start Date';
//
//           myendDate = dates.length > 1
//               ? outputFormat.format(inputFormat.parse(dates[1]))
//               : 'No End Date';
//
//           startDate = dates[0];
//           endDate = dates[1];
//
//           eventStartDateTime = DateTime.parse(startDate);
//           updateCountdown();
//           Future.delayed(Duration(seconds: 1), _updateCountdownEverySecond);
//         });
//       }
//     } catch (e) {
//       print("Error in SingleDetails: ${e}");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: isLoading
//           ? const Center(
//           child: CircularProgressIndicator(
//             color: Colors.black,
//             backgroundColor: Colors.white,
//           ))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   child: Image.network(
//                     singleEventData!.eventImage,
//                     fit: BoxFit.fill,
//                   ),
//                   height: screenheight * 0.4,
//                   width: double.infinity,
//                 ),
//                 Positioned(
//                   top: screenheight * 0.05,
//                   left: screenwidth * 0.05,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                       size: screenwidth * 0.06,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenwidth * 0.03,
//                   vertical: screenwidth * 0.02),
//               child: Consumer<LanguageProvider>(
//                 builder: (BuildContext context, languageProvider, Widget? child) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         languageProvider.language == "english"
//                             ? singleEventData!.enEventName
//                             : singleEventData!.hiEventName,
//                         style: TextStyle(
//                             fontSize: screenwidth * 0.05,
//                             fontWeight: FontWeight.w600,
//                             color: Color.fromRGBO(255, 118, 10, 1)),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: screenwidth * 0.01,
//                             vertical: screenwidth * 0.02),
//                         child: Container(
//                             width: screenwidth * double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.grey.shade300,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: screenwidth * 0.03,
//                                   vertical: screenheight * 0.01),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     languageProvider.language == "english"
//                                         ? 'Mark interested to know more about this event'
//                                         : "इस इवेंट के बारे में अपडेट रहने के लिए इच्छुक पर क्लिक करें",
//                                     style: TextStyle(
//                                         fontSize: screenwidth * 0.03,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.thumb_up,
//                                         color: Colors.green,
//                                       ),
//                                       SizedBox(
//                                         width: screenwidth * 0.02,
//                                       ),
//                                       Text(
//                                         languageProvider.language == "english"
//                                             ? "${singleEventData!.eventInterested} People Interested"
//                                             : "${singleEventData!.eventInterested} लोगों ने हाल ही में रुचि दिखाई है",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: screenwidth * 0.04),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         width: screenwidth * 0.2,
//                                         height: screenheight * 0.05,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.red),
//                                           color: Color.fromRGBO(239, 232, 221, 1.0),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             languageProvider.language == "english" ? "Interested?" : "इच्छुक?",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.red),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.location_on_outlined,
//                               color: Colors.black,
//                               size: screenwidth * 0.04),
//                           SizedBox(width: screenwidth * 0.02),
//                           Expanded(
//                             child: Text(
//                               languageProvider.language == "english"
//                                   ? singleEventData!.allVenueData[0].enEventVenue
//                                   : singleEventData!.allVenueData[0].hiEventVenue,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: screenwidth * 0.04,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenheight * 0.01),
//                       Row(
//                         children: [
//                           Icon(Icons.calendar_month_outlined,
//                               color: Colors.black,
//                               size: screenwidth * 0.04),
//                           SizedBox(width: screenwidth * 0.02),
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                     text: languageProvider.language == "english"
//                                         ? "Event booking will close: "
//                                         : "इवेंट बुकिंग बंद हो जाएगी: ",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: screenwidth * 0.04)),
//                                 TextSpan(
//                                     text: mystartDate,
//                                     style: TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenheight * 0.02),
//                       timeRemaining.isNegative
//                           ? Container()
//                           : Row(
//                         children: [
//                           Container(
//                             height: screenheight * 0.05,
//                             width: screenwidth * 0.2,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(9),
//                               color: Color.fromRGBO(255, 238, 211, 1),
//                             ),
//                             child: Center(
//                                 child: Text(
//                                   languageProvider.language == "english"
//                                       ? '${days} Days'
//                                       : "${days} दिन",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Text(
//                             ':',
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: screenwidth * 0.04),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Container(
//                             height: screenheight * 0.05,
//                             width: screenwidth * 0.2,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(9),
//                               color: Color.fromRGBO(255, 238, 211, 1),
//                             ),
//                             child: Center(
//                                 child: Text(
//                                   languageProvider.language == "english"
//                                       ? '${hours} Hours'
//                                       : "${hours} घंटे",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Text(
//                             ':',
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: screenwidth * 0.04),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Container(
//                             height: screenheight * 0.05,
//                             width: screenwidth * 0.2,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(9),
//                               color: Color.fromRGBO(255, 238, 211, 1),
//                             ),
//                             child: Center(
//                                 child: Text(
//                                   languageProvider.language == "english"
//                                       ? '${minutes} Mins'
//                                       : "${minutes} मिनट",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Text(
//                             ':',
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: screenwidth * 0.04),
//                           ),
//                           SizedBox(width: screenwidth * 0.01),
//                           Container(
//                             height: screenheight * 0.05,
//                             width: screenwidth * 0.2,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(9),
//                               color: Color.fromRGBO(255, 238, 211, 1),
//                             ),
//                             child: Center(
//                                 child: Text(
//                                   languageProvider.language == "english"
//                                       ? '${seconds} Sec'
//                                       : "${seconds} सेकेंड",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenheight * 0.02),
//                       Text(
//                         languageProvider.language == "english"
//                             ? 'Top Offers For You'
//                             : "आपके लिए शीर्ष ऑफर",
//                         style: TextStyle(
//                             fontSize: screenwidth * 0.05,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: screenwidth * 0.03),
//                         child: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(20.0)),
//                               ),
//                               clipBehavior: Clip.antiAlias,
//                               backgroundColor: Colors.white,
//                               elevation: 10,
//                               builder: (context) => BottomSheetPage(),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.red),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: screenwidth * 0.02,
//                                   horizontal: screenwidth * 0.02),
//                               child: Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         languageProvider.language ==
//                                             "english"
//                                             ? 'Enjoy 10% off coupon'
//                                             : "10% छूट वाले कूपन का आनंद लें",
//                                         style: TextStyle(
//                                             fontSize: screenwidth * 0.04,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     languageProvider.language == "english"
//                                         ? 'Tap to view details'
//                                         : "विवरण देखने के लिए टैप करें",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             height: screenheight * 0.03,
//                             width: screenwidth * 0.01,
//                             color: Colors.deepOrange,
//                           ),
//                           SizedBox(width: screenwidth * 0.02),
//                           Text(
//                             languageProvider.language == "english"
//                                 ? 'About this Event'
//                                 : "इस इवेंट के बारे में",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: screenwidth * 0.05,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       Html(
//                         data: languageProvider.language == "english"
//                             ? singleEventData!.enEventAbout
//                             : singleEventData!.hiEventAbout,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             height: screenheight * 0.03,
//                             width: screenwidth * 0.01,
//                             color: Colors.deepOrange,
//                           ),
//                           SizedBox(width: screenwidth * 0.02),
//                           Text(
//                             languageProvider.language == "english"
//                                 ? "Multiple Venues"
//                                 : "स्थल का पता",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: screenwidth * 0.05,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: screenwidth * 0.02,
//                             horizontal: screenwidth * 0.02),
//                         child: Container(
//                           height: screenheight * 0.05,
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             scrollDirection: Axis.horizontal,
//                             itemCount: allVenueData.length,
//                             itemBuilder: (context, index) {
//                               return Row(
//                                 children: [
//                                   Container(
//                                     width: screenwidth * 0.04,
//                                     height: screenheight * 0.04,
//                                     decoration: BoxDecoration(
//                                         color: _selectedIndex == index
//                                             ? Colors.black
//                                             : Colors.grey,
//                                         shape: BoxShape.circle),
//                                     child: Center(
//                                       child: Text(
//                                         "${index + 1}",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: screenwidth * 0.01),
//                                   Text(
//                                       languageProvider.language == "english"
//                                           ? "Venue"
//                                           : "कार्यक्रम का स्थान",
//                                       style: TextStyle(
//                                           color: _selectedIndex == index
//                                               ? Colors.black
//                                               : Colors.grey)),
//                                   SizedBox(width: screenwidth * 0.02),
//                                   Icon(Icons.arrow_forward_ios_rounded,
//                                       size: screenwidth * 0.03,
//                                       color: Colors.grey),
//                                   SizedBox(width: screenwidth * 0.02),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Text(
//                           languageProvider.language == "english"
//                               ? "Select Venue"
//                               : "स्थान चुनें",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500)),
//                       SizedBox(height: screenwidth * 0.02),
//                       Container(
//                         height: screenheight * 0.07,
//                         child: ListView.builder(
//                           controller: _scrollController,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: allVenueData.length,
//                           itemBuilder: (context, index) {
//                             var event = allVenueData[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _selectedIndex = index;
//                                   _isCitySelected = true;
//                                   selectedPackageList = event.packageList;
//
//                                   _isAdded = List.generate(selectedPackageList.length, (index) => false);
//                                   quantity = List.generate(selectedPackageList.length, (index) => 0);
//                                   prices = selectedPackageList.map((package) => double.parse(package.priceNo)).toList();
//                                 });
//                                 _scrollToSelectedIndex(index);
//                               },
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   side: _selectedIndex == index
//                                       ? BorderSide(color: Colors.deepOrange, width: screenwidth * 0.01)
//                                       : BorderSide(color: Colors.grey),
//                                 ),
//                                 color: _selectedIndex == index ? Colors.orange[100] : Colors.white,
//                                 elevation: 4,
//                                 child: Container(
//                                   width: screenwidth * 0.36,
//                                   child: Center(
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
//                                       child: Text(
//                                         languageProvider.language == "english" ? event.enEventVenue : event.hiEventVenue,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: screenwidth * 0.04,
//                                             fontWeight: FontWeight.w500,
//                                             overflow: TextOverflow.ellipsis),
//                                         maxLines: 1,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       selectedPackageList.isNotEmpty
//                           ? ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: selectedPackageList.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(right: screenwidth * 0.04),
//                             child: Container(
//                               width: screenwidth * 0.93,
//                               margin: EdgeInsets.only(bottom: screenheight * 0.02),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: screenheight * 0.01),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
//                                         child: Row(
//                                           children: [
//                                           Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                         Text(
//                                         languageProvider.language == "english" ? selectedPackageList[index].enPackageName : selectedPackageList[index].hiPackageName,
//                                           style: TextStyle(
//                                             color: _isCitySelected ? Colors.black87 : Colors.grey,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         SizedBox(height: screenheight * 0.01),
//                                         Row(
//                                           children: [
//                                           Text(
//                                           selectedPackageList[index].priceNo,
//                                           style: TextStyle(
//                                             color: _isCitySelected ? Colors.black87 : Colors.grey,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                     SizedBox(width: screenwidth * 0.01),
//                                   ],
//                                 )
//                                 ],
//                               ),
//                               Spacer(),
//                               _isAdded[index]
//                                   ? Padding(
//                                 padding: EdgeInsets.only(
//                                     left: screenwidth * 0.06,
//                                     bottom: screenwidth * 0.02),
//                                 child: Container(
//                                     width: screenwidth * 0.5,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(color: Colors.green),
//                                         color: Colors.green),
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: screenwidth * 0.0002),
//                                       child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             SizedBox(width: 10),
//                                             Text(
//                                               "Add",
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w700,
//                                                   fontFamily: 'Roboto',
//                                                   color: Colors.white),
//                                             ),
//                                             SizedBox(width: 2),
//                                             Spacer(),
//                                             GestureDetector(
//                                               child: Container(
//                                                 width: screenwidth * 0.1,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius: BorderRadius.only(
//                                                         topRight: Radius.circular(10),
//                                                         bottomRight: Radius.circular(10))),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: screenwidth * 0.01),
//                                                   child: Icon(
//                                                     Icons.add,
//                                                     color: Colors.green,
//                                                     size: 30,
//                                                   ),
//                                                 ),
//                                               ),
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isAdded[index] = !_isAdded[index];
//                                                   updateTotalAmount();
//                                                 });
//                                               },
//                                             )
//                                           ]),
//                                     )),
//                               )
//                                   : Padding(
//                                 padding: EdgeInsets.only(
//                                     left: screenwidth * 0.09,
//                                     bottom: screenwidth * 0.02),
//                                 child: Row(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             border: Border.all(color: Colors.green)),
//                                         child: GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 decrementQuantity(index);
//                                               });
//                                             },
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: screenwidth * 0.01,
//                                                   horizontal: screenwidth * 0.01),
//                                               child: const Icon(
//                                                 Icons.remove,
//                                                 size: 26,
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                       ),
//                                       SizedBox(width: screenwidth * 0.02),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             border: Border.all(color: Colors.green),
//                                             color: Colors.green),
//                                         child: Center(
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: screenwidth * 0.02,
//                                                   horizontal: screenwidth * 0.1),
//                                               child: Text(
//                                                 "${quantity[index]}".toString(),
//                                                 style: TextStyle(
//                                                     color: Colors.white, fontSize: 16),
//                                               ),
//                                             )),
//                                       ),
//                                       SizedBox(width: screenwidth * 0.02),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             border: Border.all(color: Colors.green)),
//                                         child: GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 incrementQuantity(index);
//                                               });
//                                             },
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: screenwidth * 0.01,
//                                                   horizontal: screenwidth * 0.01),
//                                               child: Icon(
//                                                 Icons.add,
//                                                 size: 26,
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                       ),
//                                     ]),
//                               ),
//                             ]),
//                           ),
//                           ]),
//
//                           ),
//                           ),
//                           );
//                         },
//                       )
//                           : Container(),
//                       Consumer<LanguageProvider>(
//                         builder: (BuildContext context, languageProvider, Widget? child) {
//                           return ListView(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               padding: EdgeInsets.symmetric(vertical: screenwidth * 0.001),
//                               physics: NeverScrollableScrollPhysics(),
//                               children: [
//                           Html(
//                           data: languageProvider.language == "english"
//                           ? singleEventData!.enEventAttend
//                               : singleEventData!.hiEventAttend),
//                           if (_isExpanded) ...[
//                           Html(
//                           data: languageProvider.language == "english"
//                           ? singleEventData!.enEventSchedule
//                               : singleEventData!.hiEventSchedule)
//                           ],
//                           Padding(
//                           padding: EdgeInsets.only(left: screenwidth * 0.7),
//                           child: GestureDetector(
//                           onTap: _toggleExpand,
//                           child: Row(
//                           children: [
//                           Icon(
//                           _isExpanded
//                           ? Icons.keyboard_arrow_up_outlined
//                               : Icons.keyboard_arrow_down,
//                           color: Colors.blue,
//                           ),
//                           Text(
//                           _isExpanded
//                           ? (languageProvider.language == "english" ? "Read Less" : "कम पढ़ें")
//                               : (languageProvider.language == "english" ? "Read More" : "और पढ़ें"),
//                           style: TextStyle(color: Colors.blue, fontSize: 14),
//                           ),
//                           ],
//                           ),
//                           ),
//                           ),
//                           ],
//                           );
//                         },
//                       ),
//                       SizedBox(height: screenheight * 0.02),
//                       Container(
//                         width: screenwidth * double.infinity,
//                         decoration: BoxDecoration(
//                             color: Colors.purple.shade50,
//                             borderRadius: BorderRadius.circular(7)),
//                         child: Padding(
//                           padding: EdgeInsets.only(left: screenwidth * 0.04),
//                           child: Padding(
//                             padding: EdgeInsets.only(top: screenheight * 0.005),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.lightbulb_outline,
//                                   color: Colors.yellow.shade900,
//                                   size: screenwidth * 0.07,
//                                 ),
//                                 SizedBox(width: screenwidth * 0.03),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: screenheight * 0.001),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'You should Know',
//                                         style: TextStyle(
//                                             fontSize: screenwidth * 0.04,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                       Text(
//                                         'Seating is on a first come first serve basis in that\nrespective sector.',
//                                         style: TextStyle(
//                                           fontSize: screenwidth * 0.03,
//                                         ),
//                                       ),
//                                       SizedBox(height: screenheight * 0.01),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenheight * 0.02),
//                       Row(
//                         children: [
//                           Container(
//                             height: screenheight * 0.03,
//                             width: screenwidth * 0.01,
//                             color: Colors.deepOrange,
//                           ),
//                           SizedBox(width: screenwidth * 0.02),
//                           Text(
//                             'Artist',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: screenwidth * 0.04,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenheight * 0.02),
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//                             ),
//                             clipBehavior: Clip.antiAlias,
//                             backgroundColor: Colors.white,
//                             elevation: 10,
//                             builder: (context) => Container(
//                               color: Colors.white,
//                               child: Column(
//                                 children: [
//                                   Html(
//                                       data: languageProvider.language == "english"
//                                           ? singleEventData!.enEventTeamCondition
//                                           : singleEventData!.hiEventTeamCondition),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           width: screenwidth * 0.93,
//                           height: screenheight * 0.05,
//                           decoration: BoxDecoration(
//                             color: Colors.purple.shade50,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   languageProvider.language == "english" ? 'Terms & Conditions' : "नियम एवं शर्तें",
//                                   style: TextStyle(fontSize: screenwidth * 0.04, fontWeight: FontWeight.bold),
//                                 ),
//                                 Spacer(),
//                                 Icon(Icons.arrow_forward_ios_rounded, size: screenwidth * 0.04)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03, vertical: screenwidth * 0.02),
//               child: Consumer<LanguageProvider>(
//                 builder: (BuildContext context, languageProvider, Widget? child) {
//                   return Row(
//                     children: [
//                       Container(
//                         height: screenheight * 0.03,
//                         width: screenwidth * 0.01,
//                         color: Colors.deepOrange,
//                       ),
//                       SizedBox(width: screenwidth * 0.02),
//                       Text(
//                         languageProvider.language == "english" ? 'You might also like' : "आप इसे भी पसंद कर सकते हैं",
//                         style: TextStyle(fontSize:
//                             screenwidth * 0.05, fontWeight: FontWeight.w600),
//                       ),
//                       Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SeeScreen(),
//                               ));
//                         },
//                         child: Text(
//                           languageProvider.language == "english" ? 'See All' : "सभी देखें",
//                           style: TextStyle(
//                               color: Color.fromRGBO(255, 139, 33, 1),
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: screenheight * 0.19,
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     physics: AlwaysScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     itemCount: widget.eventSubCategory!.length,
//                     itemBuilder: (context, index) {
//                       var currentEvent = widget.eventSubCategory![index];
//                       String startToEndDate = currentEvent.startToEndDate;
//                       List<String> dates = startToEndDate.split(" - ");
//                       String startDate = dates.isNotEmpty ? dates[0] : 'No Start Date';
//                       String endDate = dates.length > 1 ? dates[1] : 'No End Date';
//
//                       var venueData = currentEvent.allVenueData;
//                       if (venueData.isEmpty) {
//                         return SizedBox.shrink();
//                       }
//
//                       var packageList = venueData[0].packageData;
//                       if (packageList.isEmpty) {
//                         return SizedBox.shrink();
//                       }
//
//                       return GestureDetector(
//                         onTap: () {
//                           showEventDetails(currentEvent); // Show details of the selected event
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02, vertical: screenwidth * 0.02),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(screenwidth * 0.02),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     height: screenwidth * 0.3,
//                                     width: screenwidth * 0.4,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       image: DecorationImage(image: NetworkImage(currentEvent.eventImage), fit: BoxFit.cover),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
//                                     child: Consumer<LanguageProvider>(
//                                       builder: (BuildContext context, languageProvider, Widget? child) {
//                                         return Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                           SizedBox(
//                                           width: screenwidth * 0.4,
//                                           child: Text(
//                                             languageProvider.language == "english" ? currentEvent.enEventName : currentEvent.hiEventName,
//                                             style: TextStyle(
//                                               fontSize: screenwidth * 0.04,
//                                               color: Colors.black87,
//                                               fontWeight: FontWeight.w500,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             textAlign: TextAlign.start,
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                         Text.rich(
//                                         TextSpan(
//                                         children: [
//                                         TextSpan(
//                                         text: languageProvider.language == "english" ? "Start Date: " : "आरंभ करने की तिथि: ",
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.03),
//                                         ),
//                                         TextSpan(text: startDate),
//                                         TextSpan(
//                                         text: "\n${languageProvider.language == "english" ? "End Date: " : "अंतिम तिथि: "}",
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.03),
//                                         ),
//                                         TextSpan(text: endDate),
//                                         ],
//                                         ),
//                                         ),
//                                         SizedBox(height: screenwidth * 0.02),
//                                         Container(
//                                         width: screenwidth * 0.47,
//                                         decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: Colors.orangeAccent,
//                                         boxShadow: [
//                                         BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: Offset(0, 3),
//                                         )
//                                         ]
//                                         ),
//                                         child:
//                                         Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02, vertical: screenwidth * 0.02),
//                                         child: Row(
//                                         children: [
//                                         Text(
//                                         languageProvider.language == "english" ? "Rs : ${packageList[0].priceNo}" : "₹ : ${packageList[0].priceNo}",
//                                         style: TextStyle(fontWeight: FontWeight.bold),
//                                         ),
//                                         Spacer(),
//                                         Text('|', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
//                                         SizedBox(width: screenwidth * 0.02),
//                                         Text(
//                                         languageProvider.language == "english" ? "Buy Now" : "अभी खरीदें",
//                                         style: TextStyle(fontWeight: FontWeight.bold),
//                                         ),
//                                         ],
//                                         ),
//                                         ),
//                                         ),
//                                         ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenheight * 0.09),
//           ],
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: EdgeInsets.only(left: screenwidth * 0.08),
//         child: Container(
//           width: double.infinity,
//           height: screenheight * 0.07,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
//             ],
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: screenwidth * 0.01),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: screenwidth * 0.04),
//                       child: Text(
//                         '${totalCount} Ticket(s) | ₹ ${totalAmount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: screenwidth * 0.04,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: screenwidth * 0.04),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (totalCount == 0 || _selectedIndex == -1) {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Error"),
//                                   content: Text("Please select tickets and venue"),
//                                   actions: [
//                                     ElevatedButton(
//                                       child: Text("OK"),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ProceedPage(
//                                     totalAmount: totalAmount.toStringAsFixed(2),
//                                   )),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Text(
//                           'Proceed',
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }