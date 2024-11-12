import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(int) onFilterSelected; // Callback function

  const FilterBottomSheet({super.key, required this.onFilterSelected});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> mainItems = [
    'Relevance',
    'Trending',
    'Price low to high',
    'Price high to low',
    'Sort by time',
    'Newest added',
  ];

  final List<String> secondaryItems = [
    'Best options for you first',
    'Show bestselling first',
    'Show lowest price first',
    'Show highest price first',
    'Show earliest event first',
    'Show recently added first',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Sort By',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: mainItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Text(
                                mainItems[index],
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w400,
                                  color: selectedIndex == index ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Radio<int>(
                            value: index,
                            groupValue: selectedIndex,
                            onChanged: (int? value) {
                              setState(() {
                                selectedIndex = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        secondaryItems[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey,
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.onFilterSelected(selectedIndex);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text('Apply Filter',style: TextStyle(fontSize: screenWidth * 0.04),),
                  Spacer(),
                  Text('Cancel',style: TextStyle(color: Colors.red,fontSize: screenWidth * 0.04),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
