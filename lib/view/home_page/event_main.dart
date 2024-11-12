// import 'dart:async';
// import 'package:eventdesign/api_service.dart';
// import 'package:eventdesign/controller/language_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import '../../model/subCategory_model.dart';
// import '../event_details.dart';
// import 'package:provider/provider.dart';
//
// class EventMain extends StatefulWidget {
//
//   int? categoryId;
//
//   EventMain({super.key,this.categoryId});
//
//   @override
//   State<EventMain> createState() => _EventMainState();
// }
//
// int currentIndex = 0;
//
// class _EventMainState extends State<EventMain> {
//
//   bool isLoading = false;
//   String startDate = "";
//   String endDate = "";
//
//   void initState() {
//     super.initState();
//     print(" My ID iS ${widget.categoryId}");
//     getEventSubCategory(widget.categoryId!);
//   }
//
//   List<SubData> eventSubCategory = [];
//   List<String> imageList = [];
//
//   Future<void> getEventSubCategory(int categoryId) async{
//
//     String url = "https://mahakal.rizrv.in/api/v1/event/getevent";
//
//     Map<String,dynamic> data = {
//
//       "category_id": [categoryId],
//       "venue_data": [],
//       "price": [],
//       "language": [],
//       "organizer": [],
//       "upcoming": 1,
//
//     };
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try{
//
//       final res = await ApiService().postData(url,data);
//       print(res);
//
//       if(res!=null){
//         final subCategoryData = SubCategoryModel.fromJson(res);
//
//         setState(() {
//           eventSubCategory = subCategoryData.data;
//           imageList = subCategoryData.data[0].images;
//           print(" Total Length is ${eventSubCategory.length}");
//           print(" Total Length is ${imageList.length}");
//         });
//
//       }
//
//     } catch(e){
//       print(e);
//       setState(() {
//         isLoading = false;
//       });
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body:
//         isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) :
//
//         SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListView.builder(
//                                 padding: EdgeInsets.symmetric(vertical: screenwidth * 0.02),
//                                 physics: NeverScrollableScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount: eventSubCategory.length,
//                                 itemBuilder: (context, index) {
//                                   // Check if index is within bounds for eventSubCategory
//                                   if (index >= eventSubCategory.length) return SizedBox.shrink();
//
//                                   // Get the current event category
//                                   var currentEvent = eventSubCategory[index];
//                                   String startToEndDate = currentEvent.startToEndDate;
//                                   List<String> dates = startToEndDate.split(" - ");
//                                    startDate = dates.isNotEmpty ? dates[0] : 'No Start Date'; // Fallback if dates is empty
//                                    endDate = dates.length > 1 ? dates[1] : 'No End Date'; // Fallback if there's no end date
//
//                                   // Ensure allVenueData is valid
//                                   var venueData = currentEvent.allVenueData;
//                                   if (venueData.isEmpty) {
//                                     return SizedBox.shrink(); // Or some placeholder widget
//                                   }
//
//                                   // Ensure packageList is valid
//                                   var packageList = venueData[0].packageList; // Access the first venue's package list
//                                   if (packageList.isEmpty) {
//                                     return SizedBox.shrink(); // Or some placeholder widget
//                                   }
//
//                                   // Ensure that the index for packageList does not exceed its length
//                                   if (index >= packageList.length) {
//                                     return SizedBox.shrink(); // Or some placeholder widget
//                                   }
//
//                                   return GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => EventDeatils(
//                                             image: currentEvent.eventImage,
//                                             name: currentEvent.enEventName,
//                                             eventId: currentEvent.id,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02, vertical: screenwidth * 0.02), // Adjusted padding
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)), // Black border
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child:
//                                         // Column(
//                                         //   crossAxisAlignment: CrossAxisAlignment.start,
//                                         //   children: [
//                                         //     Container(
//                                         //       width: double.infinity,
//                                         //       height: screenheight * 0.3,
//                                         //       child: ClipRRect(
//                                         //         borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                                         //         child: Image.network(
//                                         //           currentEvent.eventImage,
//                                         //           fit: BoxFit.fill, // Adjusted BoxFit
//                                         //         ),
//                                         //       ),
//                                         //     ),
//                                         //     SizedBox(height: screenheight * 0.00),
//                                         //     Padding(
//                                         //       padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
//                                         //       child: Column(
//                                         //         crossAxisAlignment: CrossAxisAlignment.start,
//                                         //         children: [
//                                         //           SizedBox(
//                                         //             width: screenwidth * 0.8,
//                                         //             child: Text(
//                                         //               currentEvent.enEventName,
//                                         //               style: TextStyle(
//                                         //                 fontSize: screenwidth * 0.05,
//                                         //                 color: Colors.black87,
//                                         //                 fontWeight: FontWeight.w500,
//                                         //                 overflow: TextOverflow.ellipsis,
//                                         //               ),
//                                         //               textAlign: TextAlign.start,
//                                         //               maxLines: 1,
//                                         //             ),
//                                         //           ),
//                                         //           SizedBox(height: screenheight * 0.005), // Reduced spacing
//                                         //           Row(
//                                         //             children: [
//                                         //               Icon(Icons.calendar_month_outlined, size: screenwidth * 0.06),
//                                         //               SizedBox(width: screenwidth * 0.009),
//                                         //               Text(startDate,
//                                         //                 style: TextStyle(
//                                         //                   color: Colors.grey,
//                                         //                   fontWeight: FontWeight.w500,
//                                         //                   fontSize: screenwidth * 0.03,
//                                         //                 ),
//                                         //               ),
//                                         //             ],
//                                         //           ),
//                                         //           SizedBox(height: screenheight * 0.01), // Reduced spacing
//                                         //           Padding(
//                                         //             padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0001, vertical: screenwidth * 0.02),
//                                         //             child: Container(
//                                         //               height: screenheight * 0.06, // Set the height here
//                                         //               child: Card(
//                                         //                 shape: RoundedRectangleBorder(
//                                         //                   borderRadius: BorderRadius.circular(5),
//                                         //                 ),
//                                         //                 elevation: 5,
//                                         //                 color: Colors.orange.shade300,
//                                         //                 child: Padding(
//                                         //                   padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
//                                         //                   child: Row(
//                                         //                     children: [
//                                         //                       Text("Rs:${packageList[0].priceNo}", style: TextStyle(fontWeight: FontWeight.w600)),
//                                         //                       Spacer(),
//                                         //                       Text('|', style: TextStyle(color: Colors.deepOrange)),
//                                         //                       SizedBox(width: screenwidth * 0.01),
//                                         //                       Text('BUY NOW', style: TextStyle(fontWeight: FontWeight.w600)),
//                                         //                     ],
//                                         //                   ),
//                                         //                 ),
//                                         //               ),
//                                         //             ),
//                                         //           ),
//                                         //         ],
//                                         //       ),
//                                         //     ),
//                                         //   ],
//                                         // ),
//
//
//                                         Padding(
//                                           padding: EdgeInsets.all(screenwidth * 0.02),
//                                           child: Row(
//                                             children: [
//
//                                               Container(
//                                                 height: screenwidth * 0.3,
//                                                 width: screenwidth * 0.4,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   image: DecorationImage(image: NetworkImage(currentEvent.eventImage),fit: BoxFit.cover)
//                                                 ),
//                                               ),
//
//                                               Padding(
//                                                 padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
//                                                 child: Consumer<LanguageProvider>(
//                                                   builder: (BuildContext context, languageProvider, Widget? child) {
//                                                     return Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//
//                                                         SizedBox(
//                                                           width: screenwidth * 0.4,
//                                                           child: Text(
//                                                             languageProvider.language == "english" ? currentEvent.enEventName : currentEvent.hiEventName,
//                                                             style: TextStyle(
//                                                               fontSize: screenwidth * 0.04,
//                                                               color: Colors.black87,
//                                                               fontWeight: FontWeight.w500,
//                                                               overflow: TextOverflow.ellipsis,
//                                                             ),
//                                                             textAlign: TextAlign.start,
//                                                             maxLines: 1,
//                                                           ),
//                                                         ),
//
//                                                         Text.rich(
//                                                           TextSpan(
//                                                             children: [
//                                                               TextSpan(
//                                                                 text:  languageProvider.language == "english" ? "Start Date: " : "आरंभ करने की तिथि: ",
//                                                                 style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: screenwidth * 0.03),
//                                                               ),
//                                                               TextSpan(
//                                                                   text: startDate // Replace with your actual start date variable
//                                                               ),
//                                                               TextSpan(
//                                                                 text: "\n${languageProvider.language == "english" ? "End Date: " : "अंतिम तिथि: "}",
//                                                                 style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: screenwidth * 0.03),
//                                                               ),
//                                                               TextSpan(
//                                                                 text: endDate,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         SizedBox(height: screenwidth * 0.02,),
//                                                         Container(
//                                                           width: screenwidth * 0.47,
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(5),
//                                                             color: Colors.orangeAccent,
//                                                           ),
//                                                           child:
//
//                                                           Padding(
//                                                             padding:EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenwidth * 0.02),
//                                                             child: Row(
//                                                               children: [
//
//                                                                 Text(
//                                                                   languageProvider.language == "english" ? "Rs : ${packageList[0].priceNo}" : "₹ : ${packageList[0].priceNo}",style: TextStyle(fontWeight: FontWeight.bold),),
//
//                                                                 Spacer(),
//
//                                                                 Text('|', style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
//                                                                 SizedBox(width: screenwidth * 0.02,),
//                                                                 Text(
//                                                                   languageProvider.language == "english" ? "Buy Now" : "अभी खरीदें",style: TextStyle(fontWeight: FontWeight.bold),)
//
//                                                               ],
//                                                             ),
//                                                           ),
//
//                                                           // Consumer<LanguageProvider>(
//                                                           //   builder: (BuildContext context, languageProvider, Widget? child) {
//                                                           //     return Row(
//                                                           //       children: [
//                                                           //         Text(
//                                                           //             languageProvider.language == "english" ? "Rs : ${packageList[0].priceNo}" : "₹ : ${packageList[0].priceNo}" , style: TextStyle(fontWeight: FontWeight.w600)),
//                                                           //         Spacer(),
//                                                           //         Text('|', style: TextStyle(color: Colors.deepOrange)),
//                                                           //         SizedBox(width: screenwidth * 0.01),
//                                                           //         Text(
//                                                           //             languageProvider.language == "english" ? 'BUY NOW' : "अभी खरीदें",
//                                                           //             style: TextStyle(fontWeight: FontWeight.w600)),
//                                                           //       ],
//                                                           //     );
//                                                           //   },
//                                                           // )
//
//                                                         )
//
//                                                       ],
//                                                     );
//                                                   },
//                                                 ),
//                                               )
//
//
//                                             ],
//                                           ),
//                                         )
//
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ]),
//                   ]),
//             )
//         )
//     );
//   }
// }


import 'dart:async';
import 'package:eventdesign/api_service.dart';
import 'package:eventdesign/controller/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/subCategory_model.dart';
import '../event_details.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class EventMain extends StatefulWidget {
  int? categoryId;

  EventMain({super.key, this.categoryId});

  @override
  State<EventMain> createState() => _EventMainState();
}

class _EventMainState extends State<EventMain> {

  bool isLoading = false;
  bool isLoadingMore = false;

  int currentPage = 1; // Current page for pagination

  String startDate = "";
  String endDate = "";

  List<SubData> eventSubCategory = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("My ID is ${widget.categoryId}");
    getEventSubCategory(widget.categoryId!);

    // Add listener to the scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Load more data when scrolled to the bottom
        getEventSubCategory(widget.categoryId!, loadMore: true);
      }
    });
  }

  Future<void> getEventSubCategory(int categoryId, {bool loadMore = false}) async {
    String url = "https://mahakal.rizrv.in/api/v1/event/getevent";

    Map<String, dynamic> data = {
      "category_id": [categoryId],
      "venue_data": [],
      "price": [],
      "language": [],
      "organizer": [],
      "upcoming": 1,
      "page": currentPage, // Add pagination
    };

    if (!loadMore) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoadingMore = true; // Set loading more state
      });
    }

    try {
      final res = await ApiService().postData(url, data);
      print(res);

      if (res != null) {
        final subCategoryData = SubCategoryModel.fromJson(res);

        setState(() {
          if (loadMore) {
            // If loading more, increment the current page and add new items
            currentPage++;
            eventSubCategory.addAll(subCategoryData.data);
          } else {
            // If not loading more, reset the list and set the current page to 1
            eventSubCategory = subCategoryData.data;
            currentPage = 2; // Set to 2 since we will fetch the next page on the first load
          }
          print("Total Length is ${eventSubCategory.length}");
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false; // Reset loading more state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.black, backgroundColor: Colors.white))
            : SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController, // Attach the scroll controller
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: screenwidth * 0.02),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: eventSubCategory.length + (isLoadingMore ? 1 : 0), // Add one for loading indicator
                      itemBuilder: (context, index) {
                        if (index >= eventSubCategory.length) {
                          return Center(child: CircularProgressIndicator()); // Loading indicator
                        }

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

                        var currentEvent = eventSubCategory[index];

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDeatils(
                                  eventId: currentEvent.id,
                                  eventSubCategory: eventSubCategory,
                                ),
                              ),
                            );
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
                                                      text: languageProvider.language == "english" ? "Start Date: " : "आरंभ तिथि: ",
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                    ),
                                                    TextSpan(text: startDate,style: TextStyle(fontWeight: FontWeight.w400)),
                                                    TextSpan(
                                                      text: "\n${languageProvider.language == "english" ? "Start Time: " : "समय: "}",
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: screenwidth * 0.04),
                                                    ),
                                                    TextSpan(text: currentEvent.allVenueData[0].startTime,style: TextStyle(fontWeight: FontWeight.w400)),
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
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}