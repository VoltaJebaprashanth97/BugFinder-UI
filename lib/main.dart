import 'package:flutter/material.dart';
import 'table/table.dart';
import 'package:dio/dio.dart';
import 'work_items/workItems.dart';
import 'filters/filters.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Finder AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => FilterProvider(),
        child: const MyHomePage(title: 'Bug Finder AI'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchKeyword = "";
  List<WorkItems> issues = [];
  bool _hasLoadedData = false;

  Future<void> getCannotDoDataEntry() async {
    final dio = Dio();

    try {
      if (searchKeyword.isNotEmpty) {
        final filterProvider =
            Provider.of<FilterProvider>(context, listen: false);

        final Map<String, dynamic> requestBody = {
          "mode": "All",
          "numberOfResults": 100,
          "givenText": searchKeyword,
          "searchFilters": {
            "workItemTypeFilter": filterProvider.workItemFilters,
            "statusFilter": filterProvider.statusFilters,
            "projectCodeFilter": filterProvider.projectFilters,
            "testByFilter": filterProvider.testByFilters,
            "assignedToFilter": filterProvider.assignedToFilters,
            "sourceCategoryFilter": filterProvider.sourceCategoryFilters,
            "createdDateGreaterThanFilter":
                filterProvider.createdDateGreater.toString(),
            "createdDateLesserThanFilter":
                filterProvider.createdDateLesser.toString()
          }
        };

        final response = await dio.post(
          "http://localhost:8000/process_data",
          data: requestBody,
        );

        if (response.statusCode == 200) {
          // Parse the JSON response into a list of Issue objects
          final jsonList = response.data as List<dynamic>;
          issues = jsonList.map((json) => WorkItems.fromJson(json)).toList();
          print("Data retrieved successfully.");
          _hasLoadedData = true;
        } else {
          print("Error getting data: ${response.statusCode}");
        }
      }
    } on DioException catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // height: 400,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                // if (!_hasLoadedData) AnimatedTitle(),
                Container(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 150.0,
                    right: 150.0,
                    bottom: 15.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          expands: false,
                          onEditingComplete: () async {
                            // This function will be called when the "Enter" key is pressed
                            await getCannotDoDataEntry();

                            // for (var issue in issues) {
                            //   print(issue.title);
                            //   print(" ");
                            // }
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.all(12.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          controller:
                              TextEditingController(text: searchKeyword),
                          onChanged: (text) {
                            searchKeyword = text;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await getCannotDoDataEntry();
                          // for (var issue in issues) {
                          //   print(issue.title);
                          //   print(" ");
                          // }
                          setState(() {});
                        },
                        icon: const Icon(Icons.search),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Filters(),
                if (_hasLoadedData)
                  MyDataTable(
                    key:
                        UniqueKey(), // You can use other types of keys if needed
                    issues: issues,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
