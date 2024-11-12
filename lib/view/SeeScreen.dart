import 'package:eventdesign/controller/language_provider.dart';
import 'package:eventdesign/view/event_details.dart';
import 'package:flutter/material.dart';
import '../model/subCategory_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class SeeScreen extends StatefulWidget {

  List<SubData>? eventSubCategory;

   SeeScreen({super.key,this.eventSubCategory});

  @override
  State<SeeScreen> createState() => _SeeScreenState();
}

class _SeeScreenState extends State<SeeScreen> {


  List<Item> items = [
    Item(
      imageUri: "https://famouspeople.wiki/wp-content/uploads/2023/01/dhirendra-krishna-shastri-696x790.jpg",
      date: 'Sun, 18 Aug',
      text: 'Dhirendra Shastri....\nlive in Pune',
    ),
    Item(
      imageUri: "https://www.ibc24.in/wp-content/uploads/2023/07/Pradeep-Mishra-Shiv-Puran-Katha-Live.jpg",
      date: 'Mon, 19 Aug',
      text: 'Pradeep Mishra....\nLive in Indore',
    ),
    Item(
      imageUri:"https://www.teahub.io/photos/full/277-2779202_jaya-kishori-hd-wallpaper-of-jaya-kishori-ji.jpg",
      date: 'Tue, 20 Aug',
      text: 'Jaya Kishori....\nlive in London',
    ),
    Item(
      imageUri: "https://vtt.edu.vn/wp-content/uploads/2023/08/Aniruddhacharya-Ji-Maharaj-Biography-Age-Wife-Net-worth-Family.jpg",
      date: 'Wed, 21 Aug',
      text: 'Anirudh Acharya....\nlive in Paris',
    ),
    Item(
      imageUri: "https://bhagwatkathavachak.com/assets/img/ram-bhadracharya-ji.webp",
      date: 'Thu, 22 Aug',
      text: 'Govind Guru....\nlive in Berlin',
    ),
    Item(
      imageUri: "https://mybestbio.in/wp-content/uploads/2023/01/Dhirendra-shastri-mahraja-images-HD.jpg",
      date: 'Fri, 23 Aug',
      text: 'Dhirendra Shastri....\nlive in Rome',
    ),
  ];

  String startDate = "";
  String endDate = "";

  int _selectedFilterIndex = 0; // Track selected filter

  List<Item> getFilteredItems() {
    // Apply filtering logic based on _selectedFilterIndex
    List<Item> filteredItems = List.from(items); // Copy of items

    // Example filtering logic (replace with actual logic as needed):
    switch (_selectedFilterIndex) {
      case 0:
      // Relevance
        break;
      case 1:
      // Trending
        break;
      case 2:
      // Price low to high
      // Example sorting by date as a placeholder
        filteredItems.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 3:
      // Price high to low
      // Example sorting by date in reverse as a placeholder
        filteredItems.sort((a, b) => b.date.compareTo(a.date));
        break;
      case 4:
      // Sort by time
      // Placeholder sorting logic
        break;
      case 5:
      // Newest added
      // Placeholder sorting logic
        break;
      default:
        break;
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black87, size: 25),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Events Near by You',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
              ),
            ),
            Text(
              'Mumbai | 55 Events',
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ],
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       showModalBottomSheet(
        //         context: context,
        //         builder: (context) => ClipRRect(
        //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        //           child: FilterBottomSheet(
        //             onFilterSelected: (int filterIndex) {
        //               setState(() {
        //                 _selectedFilterIndex = filterIndex;
        //               });
        //             },
        //           ),
        //         ),
        //       );
        //     },
        //     child: Icon(
        //       Icons.filter_list,
        //       color: Colors.black,
        //       size: screenWidth * 0.07,
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child:
            widget.eventSubCategory == null || widget.eventSubCategory!.isEmpty ? Center(child: Text("No Data")) :
        GridView.builder(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.59,
          ),
          itemCount: widget.eventSubCategory!.length,
          itemBuilder: (context, index) {

            DateTime startToEndDate = widget.eventSubCategory![index].allVenueData[0].date;

            // Define the input and output date formats
            final inputFormat = DateFormat('yyyy-MM-dd');
            final outputFormat = DateFormat('d MMM yyyy');

            // Parse and format start date
            startDate = outputFormat.format(inputFormat.parse(startToEndDate.toString()));

            return GestureDetector(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => EventDeatils(eventId: widget.eventSubCategory![index].id,eventSubCategory: widget.eventSubCategory,)),);
              },
              child: Consumer<LanguageProvider>(
                builder: (BuildContext context, languageProvider, Widget? child) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container (
                          width: double.infinity,
                          height: screenHeight * 0.26,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12),topRight: Radius.circular (12),topLeft: Radius.circular (12)),
                            child: Image.network(widget.eventSubCategory![index].eventImage, fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                          child: Container(
                            width: double.infinity,
                            height: screenHeight * 0.03,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange.shade100,
                            ),
                            child: Center(
                              child: Text(startDate,
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),

                        SizedBox(height:  screenHeight * 0.001,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            child: Text(
                              languageProvider.language == "english" ? widget.eventSubCategory![index].enEventName : widget.eventSubCategory![index].hiEventName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,maxLines: 1,
                              style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.001,),

                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.02), child: Text('Concerts',style: TextStyle(color: Colors.grey,fontSize: screenWidth * 0.04),),)
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Item {
  final String imageUri;
  final String date;
  final String text;

  Item({
    required this.imageUri,
    required this.date,
    required this.text,
  });
}
