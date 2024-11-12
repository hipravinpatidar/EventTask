// import 'package:flutter/material.dart';
//
// class TermsAndConditionsPage extends StatefulWidget {
//   const TermsAndConditionsPage({super.key});
//
//   @override
//   State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
// }
//
// class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Terms & Conditions',style: TextStyle(fontWeight: FontWeight.w500),),
//       ),
//
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.04),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text('1. A non-refundable deposit of 50% is required to secure the booking.'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('2. The remaining balance is due 14 days prior to the event date.'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('3. Payment methods accepted: [list payment methods, e.g. bank transfer, credit card, etc.]'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('4. If the client cancels the booking within 30 days of the event date, 50% of the total fee will be refunded.]'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('5. If the client cancels the booking within 14 days of the event date, no refund will be given.'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('6. The client is responsible for providing a suitable performance area, including a microphone, sound system, and stage.'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('7. The comedian retains all intellectual property rights to their performance, including but not limited to jokes, scripts, and characters.'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('8. These terms and conditions shall be governed by and construed in accordance with the laws of [Your Country/State].'),
//
//               SizedBox(height: screenheight * 0.01,),
//
//               Text('9. These terms and conditions constitute the entire agreement between the client and the comedian and supersede all prior or contemporaneous agreements or understandings. '),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
