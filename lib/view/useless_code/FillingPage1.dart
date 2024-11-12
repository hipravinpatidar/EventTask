// import 'package:flutter/material.dart';
// // import 'package:pvrdesign/BookNow.dart';
// import 'package:flutter/services.dart';
// // import 'package:pvrdesign/ProceedPage.dart';
//
// import 'ProceedPage.dart';
//
// class FillingPage1 extends StatefulWidget {
//   const FillingPage1({super.key, required this.image, required this.name});
//
//   final String image;
//   final String name;
//
//   @override
//   State<FillingPage1> createState() => _FillingPage1State();
// }
//
// class _FillingPage1State extends State<FillingPage1> {
//   int _currentIndex = 0; // Index of currently selected ticket
//   bool _showFloatingActionButton = false;
//
//   // Track quantities of tickets
//   List<int> counters = List.generate(4, (index) => 0);
//
//   // Base prices for each ticket type
//   final List<int> _basePrices = [500, 600, 700, 800]; // Adjust as needed
//
//   // Calculate the total price and count for all ticket types
//   int _totalPrice = 0;
//   int _totalCount = 0;
//
//   // Update the total price and count based on all ticket counts
//   void _updateTotalPrice() {
//     setState(() {
//       _totalCount = counters.reduce((sum, item) => sum + item);
//       _totalPrice = counters.asMap().entries.map((entry) {
//         int index = entry.key;
//         int count = entry.value;
//         return count * _basePrices[index];
//       }).reduce((sum, item) => sum + item);
//       _showFloatingActionButton = _totalCount > 0;
//     });
//   }
//
//   void _increment(int index) {
//     setState(() {
//       counters[index]++;
//       _currentIndex = index; // Ensure _currentIndex is set to the current ticket
//       _updateTotalPrice();
//     });
//   }
//
//   void _decrement(int index) {
//     setState(() {
//       if (counters[index] > 0) {
//         counters[index]--;
//         _currentIndex = index; // Ensure _currentIndex is set to the current ticket
//         _updateTotalPrice();
//       }
//     });
//   }
//
//   List<Map<String, String>> items = [
//     {
//       "image":
//       "https://e7.pngegg.com/pngimages/702/931/png-clipart-puja-kalasha-hanuman-hindu-temple-rangoli-hanuman-diwali-gold.png",
//       "title": "BALCONY TICKETS",
//       "description": "Fast Filling"
//     },
//     {
//       "image":
//       "https://www.dharmsaar.com/shop/wp-content/uploads/2022/03/Sindoor.webp",
//       "title": "SILVER",
//       "description": "Fast Filling"
//     },
//     {
//       "image":
//       "https://w7.pngwing.com/pngs/637/886/png-transparent-pooja-thali.png",
//       "title": "GOLD",
//       "description": "Fast Filling"
//     },
//     {
//       "image":
//       "https://w7.pngwing.com/pngs/31/117/png-transparent-rose-laddu.png",
//       "title": "PLATINUM",
//       "description": "Fast Filling"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         backgroundColor: Colors.purple.shade50,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back_ios, size: screenwidth * 0.04),
//         ),
//         title: Text(
//           'Kisi Ko Batana Mat Ft. Gourav...',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: screenheight * 0.04,
//               width: double.infinity,
//               color: Colors.orange.shade300,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
//                 child: Row(
//                   children: [
//                     Icon(Icons.offline_pin_outlined),
//                     SizedBox(width: screenwidth * 0.04),
//                     Text('10% off Coupon code | BMS10',
//                         style: TextStyle(fontWeight: FontWeight.w500)),
//                     Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: 'BMS10'));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Voucher code copied!'),
//                             duration: Duration(milliseconds: 1500),
//                           ),
//                         );
//                       },
//                       child: Text('Copy code',
//                           style: TextStyle(color: Colors.red)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: screenwidth * 0.03, top: screenheight * 0.01),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: screenwidth * 0.04,
//                       height: screenheight * 0.04,
//                       decoration: BoxDecoration(
//                           color: Colors.black, shape: BoxShape.circle),
//                       child: Center(
//                           child:
//                           Text('1', style: TextStyle(color: Colors.white))),
//                     ),
//                     SizedBox(width: screenwidth * 0.01),
//                     Text('Venue', style: TextStyle(color: Colors.black)),
//                     SizedBox(width: screenwidth * 0.02),
//                     Icon(Icons.arrow_forward_ios_rounded,
//                         size: screenwidth * 0.03, color: Colors.grey),
//                     SizedBox(width: screenwidth * 0.02),
//                     Row(
//                       children: [
//                         Container(
//                           width: screenwidth * 0.04,
//                           height: screenheight * 0.04,
//                           decoration: BoxDecoration(
//                               color: Colors.grey, shape: BoxShape.circle),
//                           child: Center(
//                               child: Text('2',
//                                   style: TextStyle(color: Colors.white))),
//                         ),
//                         SizedBox(width: screenwidth * 0.01),
//                         Text('Venue', style: TextStyle(color: Colors.grey)),
//                         SizedBox(width: screenwidth * 0.02),
//                         Icon(Icons.arrow_forward_ios_rounded,
//                             size: screenwidth * 0.03, color: Colors.grey),
//                         SizedBox(width: screenwidth * 0.02),
//                         Row(
//                           children: [
//                             Container(
//                               width: screenwidth * 0.04,
//                               height: screenheight * 0.04,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey, shape: BoxShape.circle),
//                               child: Center(
//                                   child: Text('3',
//                                       style: TextStyle(color: Colors.white))),
//                             ),
//                             SizedBox(width: screenwidth * 0.01),
//                             Text('Venue', style: TextStyle(color: Colors.grey)),
//                             SizedBox(width: screenwidth * 0.02),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: screenheight * 0.01),
//               Container(
//                 height: screenheight * 0.06,
//                 width: double.infinity,
//                 color: Colors.grey.shade300,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Deep Smriri Audition: Jaipur',
//                           style: TextStyle(fontWeight: FontWeight.w500)),
//                       Text('Sun 18 Aug | 07:00 PM',
//                           style: TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: screenheight * 0.02, left: screenwidth * 0.03),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Select Tickets',
//                           style: TextStyle(
//                               fontSize: screenwidth * 0.03,
//                               fontWeight: FontWeight.w700)),
//                       Text('You can add up to 10 tickets only',
//                           style: TextStyle(fontSize: screenwidth * 0.03)),
//                       SizedBox(height: screenheight * 0.01),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: items.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(right: screenwidth * 0.04),
//                             child: Container(
//                               width: screenwidth * 0.93,
//                               margin:
//                               EdgeInsets.only(bottom: screenheight * 0.02),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: screenheight * 0.01),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: screenwidth * 0.02),
//                                       child: Row(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 items[index]["title"]!,
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight:
//                                                     FontWeight.w500),
//                                               ),
//                                               SizedBox(
//                                                   height: screenheight * 0.01),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     '₹${_basePrices[index]}', // Display static base price
//                                                     style: TextStyle(
//                                                         fontSize:
//                                                         screenwidth * 0.03,
//                                                         color: Colors.black87,
//                                                         fontWeight:
//                                                         FontWeight.w500),
//                                                   ),
//                                                   SizedBox(
//                                                       width:
//                                                       screenwidth * 0.01),
//                                                   Text(
//                                                     items[index]
//                                                     ["description"]!,
//                                                     style: TextStyle(
//                                                         color: Colors.red),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     _currentIndex =
//                                                         index; // Set the current index
//                                                     if (counters[index] == 0) {
//                                                       _increment(index);
//                                                     } else {
//                                                       _decrement(index);
//                                                     }
//                                                   });
//                                                 },
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       right:
//                                                       screenwidth * 0.05),
//                                                   child: Container(
//                                                     width: screenwidth * 0.3,
//                                                     height: 40,
//                                                     decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors.red),
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           5),
//                                                     ),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .center,
//                                                       children: [
//                                                         counters[index] == 0
//                                                             ? Text(
//                                                           '+Add',
//                                                           style: TextStyle(
//                                                               color: Colors
//                                                                   .red,
//                                                               fontSize:
//                                                               12),
//                                                         )
//                                                             : Row(
//                                                           children: [
//                                                             ElevatedButton(
//                                                               style: ElevatedButton.styleFrom(
//                                                                   elevation:
//                                                                   0,
//                                                                   backgroundColor:
//                                                                   Colors
//                                                                       .white,
//                                                                   minimumSize: Size(
//                                                                       20,
//                                                                       20),
//                                                                   padding:
//                                                                   EdgeInsets
//                                                                       .zero,
//                                                                   side: BorderSide(
//                                                                       color:
//                                                                       Colors.red)),
//                                                               onPressed: () =>
//                                                                   _decrement(
//                                                                       index),
//                                                               child: Text(
//                                                                 '-',
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black87,
//                                                                     fontSize:
//                                                                     12),
//                                                               ),
//                                                             ),
//                                                             Padding(
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                   5),
//                                                               child: Text(
//                                                                 '${counters[index]}',
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                     12,
//                                                                     color:
//                                                                     Colors.red),
//                                                               ),
//                                                             ),
//                                                             ElevatedButton(
//                                                               style: ElevatedButton.styleFrom(
//                                                                   elevation:
//                                                                   0,
//                                                                   backgroundColor:
//                                                                   Colors
//                                                                       .white,
//                                                                   minimumSize: Size(
//                                                                       20,
//                                                                       20),
//                                                                   padding:
//                                                                   EdgeInsets
//                                                                       .zero,
//                                                                   side: BorderSide(
//                                                                       color:
//                                                                       Colors.red)),
//                                                               onPressed: () =>
//                                                                   _increment(
//                                                                       index),
//                                                               child: Text(
//                                                                 '+',
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black87,
//                                                                     fontSize:
//                                                                     12),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: screenheight * 0.01),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ]),
//               ),
//             ]),
//           ],
//         ),
//       ),
//       floatingActionButton: _showFloatingActionButton
//           ? Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: screenwidth * 0.02,
//             vertical: screenheight * 0.01),
//         child: Container(
//           width: double.infinity,
//           height: screenheight * 0.07,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 4,
//                   offset: Offset(0, 2))
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: screenwidth * 0.04),
//                     child: Text(
//                       '${_totalCount} Ticket(s) | ₹ $_totalPrice', // Display count and total price
//                       style: TextStyle(
//                         fontSize: screenwidth * 0.04,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProceedPage(totalAmount: "",)),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Proceed',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
