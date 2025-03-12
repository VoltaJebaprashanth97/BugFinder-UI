import 'package:flutter/material.dart';
import 'package:bugfnder/work_items/workItems.dart';
import 'dart:html' as html;

class WorkItem {
  final String similarity;
  final String id;
  final String type;
  final String project;
  final String title;
  final String state;
  final String mode;
  final String more;

  const WorkItem(
      {required this.similarity,
      required this.id,
      required this.type,
      required this.project,
      required this.title,
      required this.state,
      required this.mode,
      required this.more});

  @override
  String toString() =>
      'WorkItem(similarity: $similarity, id: $id, type: $type, project: $project, title: $title, state: $state, mode: $mode, more: $more, )';
}

class MyDataTable extends StatefulWidget {
  final List<WorkItems> issues;

  const MyDataTable({required this.issues, Key? key}) : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<WorkItem> _workitem = [];

  final typeMap = {
    "Data Correction": "D.C",
    "Report Bug": "Report B",
    "Implementation Issue": "I.Issue",
    "DATA CORRECTION": "D.C",
    "Implementation Report Bug": "I. Report.B"
  };

  @override
  void initState() {
    super.initState();
    // Loop through issues and create WorkItem objects
    for (final issue in widget.issues) {
      _workitem.add(WorkItem(
        similarity: (issue.cosineSimilarity * 100).toStringAsFixed(2) +
            "%", // Replace with logic
        id: issue.id.toString(),
        type: typeMap[issue.workItemType] ?? issue.workItemType,
        project: issue.projectCode,
        title: issue.title,
        state: issue.state,
        mode: issue.sourceCategory,
        more: issue.id.toString(),
      ));
    }
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      switch (columnIndex) {
        case 0:
          _sortWorkitemBySimilarity(ascending);
          break;
        case 1:
          _sortWorkitemById(ascending);
          break;
        case 2:
          _sortWorkitemByType(ascending);
          break;
        case 3:
          _sortWorkitemByProject(ascending);
          break;
        case 4:
          _sortWorkitemByTitle(ascending);
          break;
        case 5:
          _sortWorkitemByState(ascending);
          break;
        case 6:
          _sortWorkitemByMode(ascending);
          break;
        case 7:
          _sortWorkitemByMore(ascending);
          break;
      }
    });
  }

  void _sortWorkitemBySimilarity(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.similarity.compareTo(b.similarity);
      } else {
        return b.similarity.compareTo(a.similarity);
      }
    });
  }

  void _sortWorkitemById(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.id.compareTo(b.id);
      } else {
        return b.id.compareTo(a.id);
      }
    });
  }

  void _sortWorkitemByType(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.type.compareTo(b.type);
      } else {
        return b.type.compareTo(a.type);
      }
    });
  }

  void _sortWorkitemByProject(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.project.compareTo(b.project);
      } else {
        return b.project.compareTo(a.project);
      }
    });
  }

  void _sortWorkitemByTitle(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.title.compareTo(b.title);
      } else {
        return b.title.compareTo(a.title);
      }
    });
  }

  void _sortWorkitemByState(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.state.compareTo(b.state);
      } else {
        return b.state.compareTo(a.state);
      }
    });
  }

  void _sortWorkitemByMode(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.mode.compareTo(b.mode);
      } else {
        return b.mode.compareTo(a.mode);
      }
    });
  }

  void _sortWorkitemByMore(bool ascending) {
    _workitem.sort((a, b) {
      if (ascending) {
        return a.more.compareTo(b.more);
      } else {
        return b.more.compareTo(a.more);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: DataTable(
            sortAscending: _sortAscending,
            sortColumnIndex: _sortColumnIndex,
            columns: [
              DataColumn(
                label: const SizedBox(
                  width: 20,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.blueAccent,
                  ),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  width: 25,
                  child: Text('ID'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  child: Text('TYPE'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  child: Text('PR'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  width: 600,
                  child: Text('TITLE'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  // width: 25,
                  child: Text('STATE'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: const SizedBox(
                  // width: 30,
                  child: Text('MODE'),
                ),
                onSort: (columnIndex, ascending) =>
                    _onSort(columnIndex, ascending),
              ),
            ],
            rows: _workitem
                .map((item) => DataRow(
                      cells: [
                        DataCell(Text(item.similarity)),
                        DataCell(Text(item.id)),
                        DataCell(Text(item.type)),
                        DataCell(Text(item.project)),
                        DataCell(
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            child: MouseRegion(
                              cursor: MaterialStateMouseCursor.clickable,
                              child: GestureDetector(
                                onTap: () {
                                  // Replace "https://example.com" with the actual URL you want to navigate to
                                  html.window.open(
                                      "http://124.43.19.5:8080/tfs/Vesta/Vesta%202.0/_workitems/edit/${item.id}",
                                      "New Tab");
                                },
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15, // Adjust font size as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(item.state)),
                        DataCell(Text(item.mode)),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
