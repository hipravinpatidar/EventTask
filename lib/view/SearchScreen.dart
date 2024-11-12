import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  int _selectedIndex = -1;


  List<String> allDates = [
    'Katha - Bageshwar Dham',
    'Pradeep Mishra',
    'Pravachan',
    'Comedy',
    'Movies',
  ];

  List<String> recentSearches = [];
  List<String> mostSearched = [];
  List<String> filteredDates = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDates = allDates; // Initialize with all dates
  }

  void _filterDates(String query) {
    final filtered = allDates
        .where((date) => date.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredDates = filtered;
    });
  }

  void _addRecentSearch(String search) {
    setState(() {
      recentSearches.add(search);
    });
  }

  void _clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  void _clearMostSearched() {
    setState(() {
      mostSearched.clear();
    });
  }

  void _addToMostSearched(String search) {
    setState(() {
      mostSearched.add(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black87, size: 25),
        ),
        title: Container(
          child: TextField(
            controller: _searchController,
            onChanged: (query) {
              _filterDates(query);
              if (query.isNotEmpty) {
                _addRecentSearch(query);
                _addToMostSearched(query);
              }
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search by Templets/Search by city',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.only(left: 16),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: screenWidth * 0.8,
        ),
        actions: [Icon(Icons.spatial_audio_off)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: screenWidth * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _selectedIndex == index ? Colors.red : Colors.grey,
                          ),
                          color: _selectedIndex == index ? Colors.red.withOpacity(0.9) : Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Katha',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01,),
                              _selectedIndex == index
                                  ? Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: [
                  Container(
                    color: Colors.deepOrange,
                    height: screenHeight * 0.03,
                    width: screenWidth * 0.01,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Recent Search',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _clearRecentSearches,
                    child: Text(
                      'Clear all',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.history_outlined),
                    title: Text(
                      recentSearches[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: [
                  Container(
                    color: Colors.deepOrange,
                    height: screenHeight * 0.03,
                    width: screenWidth * 0.01,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Most Search',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _clearMostSearched,
                    child: Text(
                      'Clear all',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: mostSearched.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.history_outlined),
                    title: Text(
                      mostSearched[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

