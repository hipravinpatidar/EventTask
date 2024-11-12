import 'package:eventdesign/api_service.dart';
import 'package:eventdesign/controller/language_provider.dart';
import 'package:eventdesign/view/SearchScreen.dart';
import 'package:flutter/material.dart';
import '../../model/category_model.dart';
import '../static_tab/AllScreen.dart';
import 'event_main.dart';
import 'package:provider/provider.dart';

class EventHome extends StatefulWidget {
  const EventHome({super.key});

  @override
  State<EventHome> createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {

  bool isLoading = false;
  int tabIndex = 0;

  @override
  void initState() {
    getEventCategory();
    super.initState();
  }

  List<Category> categoryList = [];
  
Future<void> getEventCategory() async{

  setState(() {
    isLoading = true;
  });
  try{

    final res = await ApiService().getData("https://mahakal.rizrv.in/api/v1/event/getcategory");

    print(" My Response Is ${res}");

    if(res!= null){

      final getCategory = CategoryModel.fromJson(res);

      setState(() {
        categoryList = getCategory.data;
        print(categoryList.length);
      });
    }

  } catch(e){
    print(e);

    setState(() {
      isLoading = false;
    });
  }

  setState(() {
    isLoading = false;
  });
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> tabs = [

      Tab(
        height: screenWidth * 0.17,
        child: Column(
          children: [

            Container(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                // image: DecorationImage(
                //   image: NetworkImage("https://d296xu67oj0g2g.cloudfront.net/lm_cms/image…/HOTEL%20PARTNERS%20LOGO%20SVG/Le%20Club_logo.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Icon(Icons.favorite_border),
            ),

            SizedBox(height: screenWidth * 0.005,),
            SizedBox(
              width: screenHeight * 0.04,
              child:  Center(
                  child: Consumer<LanguageProvider>(
                    builder: (BuildContext context, languageProvider, Widget? child) {
                      return Text(
                        languageProvider.language == "english" ?  "All" : "सभी",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color:Colors.black,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      );
                    },
                  )
              ),
            ),
          ],
        ),
      ),

      ...categoryList.map((cat)=>
      Tab(
        height: screenWidth * 0.17,
        child: Column(
          children: [

            Container(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(cat.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: screenWidth * 0.005,),
            SizedBox(
              width: screenHeight * 0.11,
              child:  Center(
                child: Consumer<LanguageProvider>(
                  builder: (BuildContext context, languageProvider, Widget? child) {
                    return  Text(
                    languageProvider.language == "english" ? cat.enCategoryName : cat.hiCategoryName,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color:Colors.black,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    );
                  },
                )
              ),
            ),
          ],
        ),
      ),)


    ];

    final List<Widget> tabView = [

      AllScreen(),

      ...categoryList.map((cat)=> EventMain(categoryId: cat.id,))

    ];

    return SafeArea(
      child: isLoading ? Scaffold(backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,))) :
      DefaultTabController(
        length: categoryList.length + 1,
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            leading: Icon(Icons.arrow_back,color: Colors.black,),
            centerTitle: true,
            toolbarHeight: 65,
            backgroundColor: Colors.white,
            title: Text("Events",style: TextStyle(color: Colors.orange,fontSize: screenWidth * 0.06,fontWeight: FontWeight.bold),),
            actions: [

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                  child: Icon(Icons.search)),
              SizedBox(width: screenWidth * 0.03,),
              
              Icon(Icons.location_on_outlined),
              SizedBox(width: screenWidth * 0.03,),
              
              Consumer<LanguageProvider>(
                builder: (BuildContext context, languageProvider, Widget? child) {
                  return GestureDetector(
                      onTap: () {
                        languageProvider.toggleLanguage();
                      },child: Icon(Icons.translate));
                },
              ),
              SizedBox(width: screenWidth * 0.04,),

            ],

            bottom:
            TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.orangeAccent,
              splashFactory: NoSplash.splashFactory,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              labelColor: Colors.black,
              tabs: tabs
            ),
          ),

          body: TabBarView(children: tabView),

        ),
      ),
    );
  }
}
