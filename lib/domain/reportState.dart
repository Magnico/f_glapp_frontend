import 'package:f_shopping_app/domain/states.dart';

class ReportState {
  String id;
  String report;
  String comment;
  DateTime createdAt;
  ReportStates state;

  ReportState(this.id, this.report, this.comment, this.createdAt, this.state);

  factory ReportState.fromJson(Map<String, dynamic> json) {
    return ReportState(
      json['_id'],
      json['report'],
      json['comment'],
      DateTime.parse(json['createdAt']),
      ReportStates.values[json['state']],
    );
  }

  Map<String, dynamic> toJson() => {
        'report': report,
        'comment': comment,
        'state': state.index,
      };
}
