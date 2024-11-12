import 'dart:async';
import 'package:eventdesign/api_service.dart';
import 'package:eventdesign/controller/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/subCategory_model.dart';
import '../SeeScreen.dart';
import '../event_details.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AllScreen extends StatefulWidget {

  AllScreen({super.key,});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

int currentIndex = 0;
int _currentIndex = 0;

List<String> imageUrls = [
  'https://assets-in.bmscdn.com/promotions/cms/creatives/1722350498229_copyofwebshowcase1240x300.jpg',
  'https://assets-in.bmscdn.com/promotions/cms/creatives/1717080055549_playcardweb.jpg'
];

List<String> imageUrlArray = [
  "https://tfipost.com/wp-content/uploads/2022/10/Shastri.jpg",
  "https://feeds.abplive.com/onecms/images/uploaded-images/2023/01/25/a1e3eac6ff7fb51b67c9168d7284be701674615845561646_original.jpg?impolicy=abp_cdn&imwidth=1200&imheight=628"  'https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-VGh1LCA4IEF1ZyBvbndhcmRz,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00394631-zaggltnknm-portrait.jpg',
  "https://topbiographyblog.com/wp-content/uploads/2022/12/Aniruddhacharya-Ji-2.jpg",
  "https://1.bp.blogspot.com/-2rKNdBOjmvE/XfUYW9V724I/AAAAAAAAAXM/hdYBxnj3YKAw8sCdP3mhCjnUJAp4iJNRwCLcBGAsYHQ/s1600/jaya%2Bkishori.jpg"];

List<String> dateArray = [
  'Radhe Govind- Celebrating ',
  'Sun, 11 Aug',
  'Mon, 12 Aug',
  'Tue, 13 Aug',
  'Wed, 14 Aug',
  'Thu, 15 Aug',
];

List<String> eventArray = [
  'Pradeep Mishra Live',
  'Pradeep Mishra Live',
  'Anirudh Mishra',
  'Jaya Kishori Live',
  'Jaya Kishori Live',
];

List<String> imageUrlimage = [
  "https://s3-alpha-sig.figma.com/img/a708/e200/b2067ff2b8ef7d0a90c66cf55f30a82c?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fXwjOSWULlRMQtINVMpOCSEQajIB~JzzB~zke8ilNuuVWmAtgLfdPdTMQQHZk3bE11pHqGGjRIJWaObkrnH-E-JYjMCnLg7tZJef0T2wJ29P3iUUF~-zqaQcD1BMPZ7VV0B6OJrqM3SS6QUWwdrJDdx270KOjRPyaWdZrtAWVScGGDFuei36jKwMAKthj7xP5NoneP~aWHOaGm3QxOZSTdmvV1AsfqwWERkSQI0VdxWDpSAGqMQs0ThACn3OeL9hQMKvtzDOG6tYPVJcl-nlgWanH68YYCrz2doVyt8BLUITLNiBkwOPLmbQVKz0Ke2pFUbDyUU-IF0kjcy0N4x80w__",
  "https://s3-alpha-sig.figma.com/img/a708/e200/b2067ff2b8ef7d0a90c66cf55f30a82c?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fXwjOSWULlRMQtINVMpOCSEQajIB~JzzB~zke8ilNuuVWmAtgLfdPdTMQQHZk3bE11pHqGGjRIJWaObkrnH-E-JYjMCnLg7tZJef0T2wJ29P3iUUF~-zqaQcD1BMPZ7VV0B6OJrqM3SS6QUWwdrJDdx270KOjRPyaWdZrtAWVScGGDFuei36jKwMAKthj7xP5NoneP~aWHOaGm3QxOZSTdmvV1AsfqwWERkSQI0VdxWDpSAGqMQs0ThACn3OeL9hQMKvtzDOG6tYPVJcl-nlgWanH68YYCrz2doVyt8BLUITLNiBkwOPLmbQVKz0Ke2pFUbDyUU-IF0kjcy0N4x80w__",
];

class _AllScreenState extends State<AllScreen> {

  bool isLoading = false;
  String startDate = "";
  String endDate = "";

  List<SubData> eventSubCategory = [];

  void initState() {
    super.initState();
    startImageChange();
    getEventSubCategory();
    getSunderKandData(10,6);
  }

  List<SubData> sunderKandData = [];
  List<SubData> satsangData = [];
  List<String> imageList = [];

  Future<void> getEventSubCategory() async{

    String url = "https://mahakal.rizrv.in/api/v1/event/getevent";

    Map<String,dynamic> data = {

      "category_id": [],
      "venue_data": [],
      "price": [],
      "language": [],
      "organizer": [],
      "upcoming": 1,

    };

    setState(() {
      isLoading = true;
    });

    try{

      final res = await ApiService().postData(url,data);
      print(" My All Data ${res}");

      if(res!=null){
        final subCategoryData = SubCategoryModel.fromJson(res);

        setState(() {
          eventSubCategory = subCategoryData.data;
          // imageList = subCategoryData.data[index].images;
          print(" Total Length is ${eventSubCategory.length}");
          print(" Total Length is ${imageList.length}");

        });
      }

    } catch(e){
      print("Eorror Occuring ${e}");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getSunderKandData(int categoryId1, int categoryId2) async {
    String url = "https://mahakal.rizrv.in/api/v1/event/getevent";

    Map<String, dynamic> data1 = {
      "category_id": [categoryId1],
      "venue_data": [],
      "price": [],
      "language": [],
      "organizer": [],
      "upcoming": 1,
    };

    Map<String, dynamic> data2 = {
      "category_id": [categoryId2],
      "venue_data": [],
      "price": [],
      "language": [],
      "organizer": [],
      "upcoming": 1,
    };

    setState(() {
      isLoading = true;
    });

    try {
      // Using Future.wait to run both API calls simultaneously
      final responses = await Future.wait([
        ApiService().postData(url, data1),
        ApiService().postData(url, data2),
      ]);

      // Check if both responses are not null
      if (responses[0] != null && responses[1] != null) {
        final sunderKandData1 = SubCategoryModel.fromJson(responses[0]);
        final sunderKandData2 = SubCategoryModel.fromJson(responses[1]);

        setState(() {
          sunderKandData.addAll(sunderKandData1.data);
          satsangData.addAll(sunderKandData2.data);
          print("Total Sunder Kand data items: ${sunderKandData.length}");
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startImageChange() {
    const interval = Duration(seconds: 1);

    Timer.periodic(interval, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % imageUrls.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body:
        isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) :

        SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200.0,
                              enableInfiniteScroll: true,
                              animateToClosest: true,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),

                            items: imageList
                                .map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      image: DecorationImage(
                                          image: NetworkImage(i),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),

                          SizedBox(height: screenheight * 0.01,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < imageList.length; i++)
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == i
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(height: screenheight * 0.01,),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                            child: Row(
                              children: [
                                Container(
                                  height: screenheight * 0.03,
                                  width: screenwidth * 0.01,
                                  color: Colors.deepOrange,
                                ),

                                SizedBox(width: screenwidth * 0.02,),

                                Consumer<LanguageProvider>(
                                  builder: (BuildContext context, languageProvider, Widget? child) {
                                    return Text(
                                      languageProvider.language == "english" ? 'Events Near by You' : "आपके आस-पास की घटनाएँ",
                                      style: TextStyle(
                                          fontSize: screenwidth * 0.05,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                ),

                                Spacer(),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeeScreen(eventSubCategory: eventSubCategory,),
                                        ));
                                  },
                                  child: Consumer<LanguageProvider>(
                                    builder: (BuildContext context, languageProvider, Widget? child) {
                                      return Text(
                                        languageProvider.language == "english" ? 'See All' : "सभी देखें",
                                        style:
                                        TextStyle(color: Color.fromRGBO(255, 139, 33, 1),fontWeight: FontWeight.bold,fontSize: screenwidth * 0.04),
                                      );
                                    },
                                  ),
                                ),],
                            ),
                          ), // add your text here

                          SizedBox(
                            height: screenheight * 0.02,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenheight * 0.36, // Height for ListView
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: eventSubCategory.length,
                                  itemBuilder: (context, index) {
                                    // Ensure the index is within bounds for eventSubCategory
                                    if (index >= eventSubCategory.length) return SizedBox.shrink();

                                    // String startToEndDate = eventSubCategory[index].startToEndDate;
                                    // List<String> dates = startToEndDate.split(" - ");
                                    // startDate = dates.isNotEmpty ? dates[0] : 'No Start Date'; // Fallback if dates is empty
                                    //  endDate = dates.length > 1 ? dates[1] : 'No End Date'; // Fallback if there's no end date

                                    imageList = eventSubCategory[index].images;

                                    String startToEndDate = eventSubCategory[index].startToEndDate;
                                    List<String> dates = startToEndDate.split(" - ");

                                    // Define the input and output date formats
                                    final inputFormat = DateFormat('yyyy-MM-dd');
                                    final outputFormat = DateFormat('d MMM yyyy');

                                    // Parse and format start date
                                    startDate = dates.isNotEmpty
                                        ? outputFormat.format(inputFormat.parse(dates[0])) // "10 Nov 2024"
                                        : 'No Start Date';

                                    // Parse and format end date if available
                                    endDate = dates.length > 1
                                        ? outputFormat.format(inputFormat.parse(dates[1])) // "15 Nov 2024"
                                        : 'No End Date';

                                    // Ensure allVenueData is valid
                                    var venueData = eventSubCategory[index].allVenueData;
                                    if (venueData.isEmpty) {
                                      return SizedBox.shrink(); // Or some placeholder widget
                                    }

                                    // Ensure packageList is valid
                                    var packageList = venueData[0].packageData; // Access the first venue's package list
                                    if (packageList.isEmpty) {
                                      return SizedBox.shrink(); // Or some placeholder widget
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EventDeatils(
                                              eventId: eventSubCategory[index].id,
                                              eventSubCategory: eventSubCategory,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8), // Adjusted padding
                                        child: Container(
                                          width: screenwidth * 0.7,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)), // Black border
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: screenheight * 0.2,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                                  child: Image.network(
                                                    eventSubCategory[index].eventImage,
                                                    fit: BoxFit.fill, // Adjusted BoxFit
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: screenheight * 0.00),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: screenwidth * 0.6,
                                                      child: Consumer<LanguageProvider>(
                                                        builder: (BuildContext context, languageProvider, Widget? child) {
                                                          return  Text(
                                                            languageProvider.language == "english" ? eventSubCategory[index].enEventName : eventSubCategory[index].hiEventName,
                                                            style: TextStyle(
                                                              fontSize: screenwidth * 0.05,
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight.w500,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            textAlign: TextAlign.start,
                                                            maxLines: 1,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: screenheight * 0.005),
                                                    // Reduced spacing
                                                    // Row(
                                                    //   children: [
                                                    //     Icon(Icons.calendar_month_outlined, size: screenwidth * 0.06),
                                                    //     SizedBox(width: screenwidth * 0.009),
                                                    //     Text(startDate,
                                                    //       style: TextStyle(
                                                    //         color: Colors.grey,
                                                    //         fontWeight: FontWeight.w500,
                                                    //         fontSize: screenwidth * 0.03,
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),

                                                    Consumer<LanguageProvider>(
                                                      builder: (BuildContext context, languageProvider, Widget? child) {
                                                        return Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: languageProvider.language == "english" ? "Start Date: " : "आरंभ करने की तिथि: ",
                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                              ),
                                                              TextSpan(text: startDate,style: TextStyle(fontWeight: FontWeight.w400)),
                                                              TextSpan(
                                                                text: "\n${languageProvider.language == "english" ? "Start Time: " : "समय: "}",
                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                              ),
                                                              TextSpan(text: eventSubCategory[index].allVenueData[0].startTime,style: TextStyle(fontWeight: FontWeight.w400)),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0001),
                                                      child: Container(
                                                        height: screenheight * 0.05, // Set the height here
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          elevation: 5,
                                                          color: Colors.orange.shade300,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                                                            child: Consumer<LanguageProvider>(
                                                              builder: (BuildContext context, languageProvider, Widget? child) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                      languageProvider.language == "english" ? "Rs : ${packageList[0].priceNo}" : "₹ : ${packageList[0].priceNo}" , style: TextStyle(fontWeight: FontWeight.w600)),
                                                                    Spacer(),
                                                                    Text('|', style: TextStyle(color: Colors.deepOrange)),
                                                                    SizedBox(width: screenwidth * 0.01),
                                                                    Text(
                                                                        languageProvider.language == "english" ? 'BUY NOW' : "अभी खरीदें",
                                                                        style: TextStyle(fontWeight: FontWeight.w600)),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                        ]),

                    SizedBox(height: screenheight * 0.00,),

                    Padding(
                      padding: EdgeInsets.only(left: screenwidth * 0.00),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // black background

                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: double.infinity, // infinite width
                        height: screenheight *
                            0.33, // adjust the height as needed
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenwidth * 0.03,
                              vertical: screenheight * 0.03),
                          child: Column(
                            children: [
                              // Title Section
                              Row(
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
                                    'Top offers for you',
                                    style: TextStyle(
                                        color: Colors.black87,
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
                                      'See All',
                                      style:
                                      TextStyle(color: Color.fromRGBO(255, 139, 33, 1),fontWeight: FontWeight.bold,fontSize: screenwidth * 0.04),
                                    ),
                                  ),
                                ],
                              ),
                              // Horizontal ListView
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets
                                      .zero, // remove padding from ListView
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigate to a different screen for each container
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EventDeatils(
                                              )),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right:
                                            8), // add space between containers
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenheight * 0.03),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            screenwidth *
                                                                0.02),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius:
                                                              screenwidth *
                                                                  0.1,
                                                              backgroundColor:
                                                              Colors
                                                                  .white,
                                                              backgroundImage:
                                                              NetworkImage(
                                                                "https://tfipost.com/wp-content/uploads/2022/10/Shastri.jpg",
                                                              ),
                                                              foregroundColor:
                                                              Colors.red,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              screenwidth *
                                                                  0.02,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Dhirendra Shastri- Katha\nNew Show',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  'Katha | 18 Aug 2024',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  'Nesco Centre Hall 4: Mumbai',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      height:
                                                      screenheight * 0.12,
                                                      width: screenwidth * 1,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.deepOrange,
                                                            offset: Offset(0, 2), // adjust the offset as per your requirement
                                                            blurRadius: 0, // adjust the blur radius as per your requirement
                                                          ),
                                                        ],
                                                        color: Color.fromRGBO(255, 236, 218, 1),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          screenwidth *
                                                              0.02,
                                                          vertical:
                                                          screenheight *
                                                              0.01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                '10%',
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .deepOrange,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  screenwidth *
                                                                      0.06,
                                                                ),
                                                              ),
                                                              Text(
                                                                'off',
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .deepOrange,
                                                                  fontSize:
                                                                  screenwidth *
                                                                      0.05,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                  Colors
                                                                      .deepOrange, // Use backgroundColor instead of primary
                                                                  foregroundColor:
                                                                  Colors
                                                                      .white, // Use foregroundColor instead of onPrimary
                                                                  elevation:
                                                                  5,
                                                                ),
                                                                child: Text(
                                                                  'Book Now',
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    screenwidth *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () {}, // add your onPressed callback here
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                width: screenwidth * 0.8,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromRGBO(231, 231, 231, 1)),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenheight * 0.00,),

                    SizedBox(height: screenheight * 0.00,),

                    Padding(
                      padding: EdgeInsets.only(left: screenwidth * 0.00),
                      child: Container(
                        width: double.infinity, // infinite width
                        height: screenheight * 0.39,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 236, 208, 1), // background color
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenwidth * 0.03,
                            vertical: screenheight * 0.01,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Section
                              Text(
                                'Live Theater Play',
                                style: TextStyle(
                                  fontSize: screenwidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '"Experience the Magic Live!"',
                                style: TextStyle(
                                  fontSize: screenwidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              SizedBox(height: screenheight * 0.02,),

                              // Horizontal ListView
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets
                                      .zero, // remove padding from ListView
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigate to a different screen for each container
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EventDeatils(
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right:
                                            8), // add space between containers
                                        child: Container(
                                          width: screenwidth * 0.8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        10)),
                                                child: Image.network(
                                                  imageUrlimage[
                                                  index], // use the image URL array
                                                  width: double.infinity,
                                                  height: screenheight * 0.2,
                                                  fit: BoxFit
                                                      .cover, // adjust as needed
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenheight *
                                                      0.02), // space between image and text
                                              Padding(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                      screenwidth *
                                                          0.02),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'HUMARE RAM LIVE PLAY',
                                                        style: TextStyle(
                                                            fontSize:
                                                            screenwidth *
                                                                0.04,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        textAlign: TextAlign
                                                            .center, // center text if needed
                                                      ),
                                                      Text(
                                                        'DRAMA|HINDI|3yrs|3hrs',
                                                        style: TextStyle(
                                                            fontSize:
                                                            screenwidth *
                                                                0.04,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        textAlign: TextAlign
                                                            .center, // center text if needed
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenheight * 0.02,
                    ),

                  Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                child: Row(
                  children: [
                    Container(
                      height: screenheight * 0.03,
                      width: screenwidth * 0.01,
                      color: Colors.deepOrange,
                    ),

                    SizedBox(width: screenwidth * 0.02,),

                    Consumer<LanguageProvider>(
                      builder: (BuildContext context, languageProvider, Widget? child) {
                        return Text(
                          languageProvider.language == "english" ? 'Sundar Kand' : "सुंदर कांड",
                          style: TextStyle(
                              fontSize: screenwidth * 0.05,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),

                    Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeScreen(eventSubCategory: eventSubCategory,),
                            ));
                      },
                      child: Consumer<LanguageProvider>(
                        builder: (BuildContext context, languageProvider, Widget? child) {
                          return Text(
                            languageProvider.language == "english" ? 'See All' : "सभी देखें",
                            style:
                            TextStyle(color: Color.fromRGBO(255, 139, 33, 1),fontWeight: FontWeight.bold,fontSize: screenwidth * 0.04),
                          );
                        },
                      ),
                    ),],
                ),
              ), // add your text here

                    SizedBox(
                      height: screenheight * 0.02,
                    ),

                    // add your text here

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenheight * 0.36, // Height for ListView
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: sunderKandData.length, // Add one for loading indicator
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventDeatils(eventId: sunderKandData[index].id,eventSubCategory: eventSubCategory,)),);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8), // Adjusted padding
                                  child: Container(
                                    width: screenwidth * 0.60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)), // Black border
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: screenheight * 0.23,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(screenheight * 0.01), // Half of the height
                                            child: Stack(
                                              fit: StackFit.expand, // Ensures the stack fills the container
                                              children: [
                                                Image.network(sunderKandData[index].eventImage,
                                                  fit: BoxFit.cover, // Adjusted BoxFit
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Consumer<LanguageProvider>(
                                                    builder: (BuildContext context, languageProvider, Widget? child) {
                                                      return SizedBox(
                                                        width: screenwidth * 0.5,
                                                        child: Text(
                                                          languageProvider.language == "english" ? sunderKandData[index].enEventName : sunderKandData[index].hiEventName,
                                                          style: TextStyle(
                                                              fontSize: screenwidth * 0.05,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                          textAlign: TextAlign.start,maxLines: 1,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),


                                        SizedBox(height: screenheight * 0.00),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              SizedBox(height: screenheight * 0.01),

                                              Consumer<LanguageProvider>(
                                                builder: (BuildContext context, languageProvider, Widget? child) {
                                                  return Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: languageProvider.language == "english" ? "Start Date: " : "आरंभ तिथि: ",
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                        ),
                                                        TextSpan(text: startDate),
                                                        TextSpan(
                                                          text: "\n${languageProvider.language == "english" ? "Start Time: " : "समय: "}",
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                        ),
                                                        TextSpan(text: sunderKandData[index].allVenueData[0].startTime),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),

                                              Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.00),
                                                  child: Container(
                                                    height: screenheight * 0.05, // Set the height here

                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      elevation: 5,
                                                      color: Colors.orange.shade300,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                                                        child:
                                                        Consumer<LanguageProvider>(
                                                          builder: (BuildContext context, languageProvider, Widget? child) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    languageProvider.language == "english" ? "Rs : ${sunderKandData[index].allVenueData[0].packageData[0].priceNo}" : "₹ : ${sunderKandData[index].allVenueData[index].packageData[0].priceNo}" , style: TextStyle(fontWeight: FontWeight.w600)),
                                                                Spacer(),
                                                                Text('|', style: TextStyle(color: Colors.deepOrange)),
                                                                SizedBox(width: screenwidth * 0.01),
                                                                Text(
                                                                    languageProvider.language == "english" ? 'BUY NOW' : "अभी खरीदें",
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                      height: screenheight * 0.02,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LIVE Streaming Events',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: screenheight * 0.01,
                            ),
                            Text(
                              '"Be there, without being there!"',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: screenheight * 0.01,
                            ),

                            //
                            // CarouselSlider(
                            //   options: CarouselOptions(
                            //     viewportFraction: 1,
                            //     height: 355.0,
                            //     enableInfiniteScroll: true,
                            //     animateToClosest: true,
                            //     autoPlay: true,
                            //     autoPlayAnimationDuration:
                            //     const Duration(milliseconds: 600),
                            //     onPageChanged: (index, reason) {
                            //       setState(() {
                            //         _currentIndex = index;
                            //       });
                            //     },
                            //   ),
                            //   items: [
                            //     "https://tse4.mm.bing.net/th?id=OIP.8TwS_phcUzFHvwBe6yXeYQHaJQ&pid=Api&P=0&h=180",
                            //     "https://tse4.mm.bing.net/th?id=OIP.GkkduUsxEozpcrQAh-tjWAHaFj&pid=Api&P=0&h=180",
                            //   ].map((i) {
                            //     return Builder(
                            //       builder: (BuildContext context) {
                            //         return Column(
                            //           children: [
                            //             Row(
                            //               children: [
                            //                 Container(
                            //                   height: 280,
                            //                   width: 173,
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                     BorderRadius.circular(10),
                            //                     color: Colors.grey.shade400,
                            //                     image: DecorationImage(
                            //                         image: NetworkImage(i),
                            //                         fit: BoxFit.cover),
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: 13,
                            //                 ),
                            //                 Column(
                            //                   crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       "Pandit Dhirendra\nShastri",
                            //                       style: TextStyle(
                            //                           color: Colors.white,
                            //                           fontWeight:
                            //                           FontWeight.w700,
                            //                           fontSize:
                            //                           screenwidth * 0.04),
                            //                     ),
                            //                     Text(
                            //                       "Pandal",
                            //                       style: TextStyle(
                            //                           color: Colors.white,
                            //                           fontSize:
                            //                           screenwidth * 0.06),
                            //                     ),
                            //                     SizedBox(
                            //                       height: screenheight * 0.01,
                            //                     ),
                            //                     Text(
                            //                       "25 November to 1 Dec\nfrom 02:55 PM",
                            //                       style: TextStyle(
                            //                           color: Colors.white),
                            //                     ),
                            //                     SizedBox(
                            //                       height: screenheight * 0.01,
                            //                     ),
                            //                     Text(
                            //                       "Venue - Shree Tara Baba\nKi Kutiya, Ramangiryan\nVillage Rania road\nSirsa, Haryana",
                            //                       style: TextStyle(
                            //                           color: Colors.white),
                            //                     ),
                            //                   ],
                            //                 )
                            //               ],
                            //             ),
                            //             SizedBox(
                            //               height: 5,
                            //             ),
                            //             GestureDetector(
                            //               onTap: () {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           FillingPage1(image: '', name: '',)),
                            //                 );
                            //               },
                            //               child: Container(
                            //                 margin: EdgeInsets.all(10),
                            //                 height: 45,
                            //                 width: double.infinity,
                            //                 decoration: BoxDecoration(
                            //                   borderRadius:
                            //                   BorderRadius.circular(8.0),
                            //                   color: Colors.orange,
                            //                 ),
                            //                 child: Center(
                            //                   child: Text(
                            //                     "Book Your Slote",
                            //                     style: TextStyle(
                            //                       fontSize: screenwidth * 0.04,
                            //                       fontWeight: FontWeight.w500,
                            //                       color: Colors.white,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   }).toList(),
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 2; i++)
                                  Container(
                                    width: 15,
                                    height: 7,
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == i
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: screenheight * 0.01,),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenheight * 0.02,),

                   Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                child: Row(
                  children: [
                    Container(
                      height: screenheight * 0.03,
                      width: screenwidth * 0.01,
                      color: Colors.deepOrange,
                    ),

                    SizedBox(width: screenwidth * 0.02,),

                    Consumer<LanguageProvider>(
                      builder: (BuildContext context, languageProvider, Widget? child) {
                        return Text(
                          languageProvider.language == "english" ? 'Satsang' : "सत्संग",
                          style: TextStyle(
                              fontSize: screenwidth * 0.05,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),

                    Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeScreen(eventSubCategory: eventSubCategory,),
                            ));
                      },
                      child: Consumer<LanguageProvider>(
                        builder: (BuildContext context, languageProvider, Widget? child) {
                          return Text(
                            languageProvider.language == "english" ? 'See All' : "सभी देखें",
                            style:
                            TextStyle(color: Color.fromRGBO(255, 139, 33, 1),fontWeight: FontWeight.bold,fontSize: screenwidth * 0.04),
                          );
                        },
                      ),
                    ),],
                ),
              ), // add your text here

                    SizedBox(
                      height: screenheight * 0.02,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenheight * 0.36, // Height for ListView
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: satsangData.length, // Add one for loading indicator
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventDeatils(eventId: satsangData[index].id,eventSubCategory: eventSubCategory,)),);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8), // Adjusted padding
                                  child: Container(
                                    width: screenwidth * 0.60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)), // Black border
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: screenheight * 0.23,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(screenheight * 0.01), // Half of the height
                                            child: Stack(
                                              fit: StackFit.expand, // Ensures the stack fills the container
                                              children: [
                                                Image.network(satsangData[index].eventImage,
                                                  fit: BoxFit.cover, // Adjusted BoxFit
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Consumer<LanguageProvider>(
                                                    builder: (BuildContext context, languageProvider, Widget? child) {
                                                      return SizedBox(
                                                        width: screenwidth * 0.5,
                                                        child: Text(
                                                          languageProvider.language == "english" ? satsangData[index].enEventName : satsangData[index].hiEventName,
                                                          style: TextStyle(
                                                              fontSize: screenwidth * 0.05,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                          textAlign: TextAlign.start,maxLines: 1,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: screenheight * 0.00),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              SizedBox(height: screenheight * 0.01),

                                              Consumer<LanguageProvider>(
                                                builder: (BuildContext context, languageProvider, Widget? child) {
                                                  return Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: languageProvider.language == "english" ? "Start Date: " : "आरंभ तिथि: ",
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                        ),
                                                        TextSpan(text: startDate),
                                                        TextSpan(
                                                          text: "\n${languageProvider.language == "english" ? "Start Time: " : "समय: "}",
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                        ),
                                                        TextSpan(text: satsangData[index].allVenueData[0].startTime),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),

                                              Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.00),
                                                  child: Container(
                                                    height: screenheight * 0.05, // Set the height here

                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      elevation: 5,
                                                      color: Colors.orange.shade300,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                                                        child:
                                                        Consumer<LanguageProvider>(
                                                          builder: (BuildContext context, languageProvider, Widget? child) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    languageProvider.language == "english" ? "Rs : ${satsangData[index].allVenueData[0].packageData[0].priceNo}" : "₹ : ${satsangData[index].allVenueData[0].packageData[0].priceNo}" , style: TextStyle(fontWeight: FontWeight.w600)),
                                                                Spacer(),
                                                                Text('|', style: TextStyle(color: Colors.deepOrange)),
                                                                SizedBox(width: screenwidth * 0.01),
                                                                Text(
                                                                    languageProvider.language == "english" ? 'BUY NOW' : "अभी खरीदें",
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                      height: screenheight * 0.02,
                    ),
                  ]),
            )
        )
    );
  }
}
