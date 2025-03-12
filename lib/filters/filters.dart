import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<String> workItemFilter = [];
  List<String> stateFilter = [];
  List<String> assignedToFilter = [];
  List<String> testByFilter = [];
  List<String> projectCodeFilter = [];
  List<String> sourceCategoryFilter = [];
  List<String> aiModeFilter = [];

  @override
  Widget build(BuildContext context) {
    FilterProvider filterProvider = context.watch<FilterProvider>();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MultiSelectDropdown(
            filterName: "AI Mode",
            items: [
              'Title',
              'Repro Steps',
              'Comments',
              'QA Analysis',
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.aiModeFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "Work Items",
            items: [
              "Bug",
              "Report Bug",
              "Data Correction",
              "Task",
              "Issue",
              "Implementation Issue",
              "Implementation Report Bug",
              "Review",
              "Test Case",
              "User Story",
              "Requirement"
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.workItemFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "State",
            items: [
              "Closed",
              "Resolved",
              "Invalid-Closed",
              "Proposed",
              "Approved",
              "Invalid",
              "Hold",
              "Irreproducible",
              "Pending Development",
              "Deployed",
              "Incomplete",
              "Active",
              "Irreproducible-Closed",
              "Re-Open",
              "Reviewing",
              "New",
              "Invalid Re-open",
              "Requested"
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.statusFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "Project Code",
            items: [
              "NPL",
              "PHL",
              "ZIM",
              "SL",
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.projectFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "Test By",
            items: [
              "Lihini Lakthilini",
              "Volta Jebaprashanth",
              "Nethmi Senarathne",
              "Vithuran Shanmugarajah",
              "Emily Dawson",
              "Sewwandi Jayawickrama",
              "Gowshikan Ravikumar",
              "Daniel Kensington",
              "Kavishka Hettiarachchi",
              "Thushanthini Yogeswaran",
              "Jonathan Blake",
              "Sajani Ekanayake",
              "Thivaharan Thayakaran",
              "Olivia Simmons",
              "Dinesh Bandara",
              "Rajkumar Vasanthakumar",
              "Jessica Holloway",
              "Harshani Wanniarachchi",
              "Nirushan Parameswaran",
              "Sophia Whitmore",
              "Janindu Rathnayake",
              "Malini Nadarajah",
              "Lucas Bennett",
              "Dulanjali Wijesekara",
              "Nayagi Sivarajah",
              "Nathaniel Crawford",
              "Isurika Rathnayake",
              "Kevin Hartford",
              "Sasindu Tharaka",
              "Vimukthi Madushan",
              "Benjamin Hayes",
              "Nirasha Maldeniya",
              "Samantha Pearson",
              "Nicholas Belmont",
              "Eleanor Fitzgerald"
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.testByFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "Assigned To",
            items: [
              "Naveen Ahangama",
              "Shashini Poorvisha",
              "Tharushi Perera",
              "Kavindya Madanayake",
              "Arunesh Thangarajah",
              "Michael Harrington",
              "Praveen De Silva",
              "Jeyanthini Rajendran",
              "Melissa Carter",
              "Sachith Alwis",
              "Vasanth Shivaraman",
              "Ethan Caldwell",
              "Shenali Wickramasinghe",
              "Thirukumar Anandarajah",
              "Isabelle Thornton",
              "Nuwan Pathirana",
              "Kishanth Somasundaram",
              "Emily Richardson",
              "Charuka Rathnayake",
              "Vaitheeswaran Ganesan",
              "Christopher Reynolds",
              "Rashmika Jayawardena",
              "Sathurshan Parthiban",
              "Rebecca Holloway",
              "Naduni Gunasekara",
              "Thayananthan Yogarajah",
              "Liam Patterson",
              "Dilini Rathnayaka",
              "Gajanan Yogeswaran",
              "Victoria Langley",
              "Supun Weerasinghe",
              "Ahilan Rajkumar",
              "Nathaniel Brooks",
              "Shanuki Fernando",
              "Aadhavan Sritharan",
              "Charlotte Mitchell"
            ],
            onSelectionChanged: (selectedItems) {
              filterProvider.assignedToFilters = selectedItems;
            },
          ),
          MultiSelectDropdown(
            filterName: "Source Category",
            items: ["Online", "Mobile", "Offline"],
            onSelectionChanged: (selectedItems) {
              filterProvider.sourceCategoryFilters = selectedItems;
            },
          ),
          DatePickerWidget(
            buttonText: 'created Date⬆️',
            onChanged: (selectedDate) {
              filterProvider.createdDateGreater = selectedDate;
            },
          ),
          DatePickerWidget(
            buttonText: 'created Date ⬇️',
            onChanged: (selectedDate) {
              filterProvider.createdDateLesser = selectedDate;
            },
          ),
        ],
      ),
    );
  }
}

class MultiSelectDropdown extends StatefulWidget {
  final String filterName;
  final List<String> items;
  final Function(List<String> selectedItems) onSelectionChanged;

  MultiSelectDropdown(
      {required this.items,
      required this.onSelectionChanged,
      required this.filterName});

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    // FilterProvider filterProvider = context.watch<FilterProvider>();
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showMultiSelectDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.filter_alt,
                    color: Colors.blue,
                  ),
                  Text(widget.filterName),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ${widget.filterName}'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: widget.items.map((item) {
                    bool isChecked = selectedItems.contains(item);
                    return CheckboxListTile(
                      title: Text(item),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                            // Call the callback function to notify the parent
                            widget.onSelectionChanged(selectedItems);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  final String buttonText;
  final Function(DateTime selectedDate) onChanged;

  DatePickerWidget({required this.buttonText, required this.onChanged});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      // Call the onChanged callback with the selected date
      widget.onChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // FilterProvider filterProvider = context.watch<FilterProvider>();
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.filter_alt,
                    color: Colors.blue,
                  ),
                  Text(widget.buttonText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterProvider extends ChangeNotifier {
//Filters ---------->
  List<String> aiModeFilters = [];
  List<String> workItemFilters = [];
  List<String> statusFilters = [];
  List<String> projectFilters = [];
  List<String> testByFilters = [];
  List<String> assignedToFilters = [];
  List<String> sourceCategoryFilters = [];

  DateTime createdDateGreater = DateTime(2015, 01, 01);
  DateTime createdDateLesser = DateTime.now();
}
