//유저데이터
class UserData {
  final String studentKey;
  final String name;
  final String id;
  final String birth;
  final String sex;
  final String phone;
  final String emergency;
  final String school;
  final String grade;
  final String address;
  final String profileImg;
  final String parentKey;
  final String remark;
  final String delState;
  final String createData;
  final String editData;

  UserData({
    required this.studentKey,
    required this.name,
    required this.id,
    required this.birth,
    required this.sex,
    required this.phone,
    required this.emergency,
    required this.school,
    required this.grade,
    required this.address,
    required this.profileImg,
    required this.parentKey,
    required this.remark,
    required this.delState,
    required this.createData,
    required this.editData,
  });
  //Map타입의 객체를 받아서 userdata 객체로 변환함
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      studentKey: json['studentKey'],
      name: json['name'] ?? '',
      id: json['id'] as String,
      birth: json['birth'],
      sex: json['sex'],
      phone: json['phone'],
      emergency: json['emergency'],
      school: json['school'],
      grade: json['grade'],
      address: json['address'],
      profileImg: json['profileImg'],
      parentKey: json['parentKey'],
      remark: json['remark'],
      delState: json['delState'],
      createData: json['createData'],
      editData: json['editData'],
    );
  }
  //toJson 으로 map으로 변환
  Map<String, dynamic> toJson() {
    return {
      'studentKey': studentKey,
      'name': name,
      'id': id,
      'birth': birth,
      'sex': sex,
      'phone': phone,
      'emergency': emergency,
      'school': school,
      'grade': grade,
      'address': address,
      'remark': remark,
      'delState': delState,
      'profileImg': profileImg,
      'createData': createData,
      'editData': editData,
      'parentKey': parentKey,
    };
  }
}

class LectureInterface {
  final String lectureKey;
  final String roomKey_id;
  final String teacherKey_id;
  final String? adminKey_id;
  final String lectureName;
  final String teacherName;
  final String roomName;
  final String type;
  final String subject;
  final String? color;
  final String book;
  final String target;
  final int day;
  final String startTime;
  final int duration;
  final String? startDate;
  final String? endDate;
  final String progress;
  final String? reason;
  final String createDate;
  final String? editDate;
  final int? start;
  final int? minute;

  // LectureList(
  //   this.lectureKey,
  //   this.roomKey_id,
  //   this.teacherKey_id,
  //   this.adminKey_id,
  //   this.lectureName,
  //   this.teacherName,
  //   this.roomName,
  //   this.type,
  //   this.subject,
  //   this.color,
  //   this.book,
  //   this.target,
  //   this.day,
  //   this.startTime,
  //   this.duration,
  //   this.suggestDate,
  //   this.progress,
  //   this.reason,
  //   this.createDate,
  //   this.editDate,
  //   this.start,
  //   this.minute,
  // );

  LectureInterface({
    required this.lectureKey,
    required this.roomKey_id,
    required this.teacherKey_id,
    this.adminKey_id = "",
    required this.lectureName,
    required this.teacherName,
    required this.roomName,
    required this.type,
    required this.subject,
    this.color = "",
    required this.book,
    required this.target,
    required this.day,
    required this.startTime,
    required this.duration,
    this.startDate = "",
    this.endDate = "",
    required this.progress,
    this.reason = "",
    required this.createDate,
    this.editDate = "",
    this.start = 0,
    this.minute = 0,
  });

  factory LectureInterface.fromJson(Map<String, dynamic> json) {
    return LectureInterface(
      lectureKey: json['lectureKey'] as String,
      roomKey_id: json['roomKey_id'] as String,
      teacherKey_id: json['lectureKey'] as String,
      adminKey_id: json['adminKey_id'],
      lectureName: json['lectureName'] as String,
      teacherName: json['teacherName'] as String,
      roomName: json['roomName'] as String,
      type: json['type'] as String,
      subject: json['subject'] as String,
      color: json['color'],
      book: json['book'] as String,
      target: json['target'] as String,
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      duration: json['duration'] as int,
      startDate: json['startDate'],
      endDate: json['endDate'],
      progress: json['progress'] as String,
      reason: json['reason'],
      createDate: json['createDate'] as String,
      editDate: json['editDate'],
      start: json['start'],
      minute: json['minute'],
    );
  }
}
