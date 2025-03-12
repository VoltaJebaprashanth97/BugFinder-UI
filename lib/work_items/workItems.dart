class WorkItems {
  int id;
  String workItemType = "";
  String projectCode = "";
  String title = "";
  String reproSteps = "";
  String symptom = "";
  String issueRootCause = "";
  String proposedFix = "";
  String qaRemark = "";
  String unitTestSteps = "";
  String systemInfo = "";
  String responsibleTeam = "";
  String issueClassification = "";
  String state = "";
  String testBy = "";
  String tags = "";
  String releaseNo = "";
  String createdBy = "";
  String assignedTo = "";
  DateTime? acTestedDate;
  DateTime? createdDate;
  String sourceCategory = "";
  double cosineSimilarity = 0.0;

  // Constructor to map JSON data to object
  WorkItems.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as int,
        workItemType = json['Work Item Type'] ?? "",
        projectCode = json['Project Code'] ?? "",
        title = json['Title'] ?? "",
        reproSteps = json['Repro Steps'] ?? "",
        symptom = json['Symptom'] ?? "",
        issueRootCause = json['Issue Root Cause'] ?? "",
        proposedFix = json['Proposed Fix'] ?? "",
        qaRemark = json['QA Remark'] ?? "",
        unitTestSteps = json['Unit Test Steps'] ?? "",
        systemInfo = json['System Info'] ?? "",
        responsibleTeam = json['Responsible Team'] ?? "",
        issueClassification = json['Issue Classification'] ?? "",
        state = json['State'] ?? "",
        testBy = json['Test By'] ?? "",
        tags = json['Tags'] ?? "",
        releaseNo = json['Release No'] ?? "",
        createdBy = json['Created By'] ?? "",
        assignedTo = json['Assigned To'] ?? "",
        acTestedDate = json['AC Tested Date'] != null
            ? DateTime.tryParse(json['AC Tested Date'])
            : null,
        createdDate = json['Created Date'] != null
            ? DateTime.tryParse(json['Created Date'])
            : null,
        sourceCategory = json['Source Category'] ?? "",
        cosineSimilarity = json['Cosine_Similarity'] ?? 0.0;
}
