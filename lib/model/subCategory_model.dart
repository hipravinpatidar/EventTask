
import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  int status;
  String message;
  int recode;
  List<SubData> data;

  SubCategoryModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<SubData>.from(json["data"].map((x) => SubData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubData {
  String enEventName;
  String enEventAbout;
  String enEventSchedule;
  String enEventAttend;
  String enEventTeamCondition;
  String hiEventName;
  String hiEventAbout;
  String hiEventSchedule;
  String hiEventAttend;
  String hiEventTeamCondition;
  int id;
  String organizerBy;
  String ageGroup;
  String language;
  int days;
  String startToEndDate;
  String youtubeVideo;
  List<AllVenueSubData> allVenueData;
  String eventImage;
  List<String> images;

  SubData({
    required this.enEventName,
    required this.enEventAbout,
    required this.enEventSchedule,
    required this.enEventAttend,
    required this.enEventTeamCondition,
    required this.hiEventName,
    required this.hiEventAbout,
    required this.hiEventSchedule,
    required this.hiEventAttend,
    required this.hiEventTeamCondition,
    required this.id,
    required this.organizerBy,
    required this.ageGroup,
    required this.language,
    required this.days,
    required this.startToEndDate,
    required this.youtubeVideo,
    required this.allVenueData,
    required this.eventImage,
    required this.images,
  });

  factory SubData.fromJson(Map<String, dynamic> json) => SubData(
    enEventName: json["en_event_name"] ?? 'No Name',
    enEventAbout: json["en_event_about"] ?? 'No Description',
    enEventSchedule: json["en_event_schedule"] ?? 'No Schedule',
    enEventAttend: json["en_event_attend"] ?? 'No Attendance Info',
    enEventTeamCondition: json["en_event_team_condition"] ?? 'No Condition Info',
    hiEventName: json["hi_event_name"] ?? 'No Name',
    hiEventAbout: json["hi_event_about"] ?? 'No Description',
    hiEventSchedule: json["hi_event_schedule"] ?? 'No Schedule',
    hiEventAttend: json["hi_event_attend"] ?? 'No Attendance Info',
    hiEventTeamCondition: json["hi_event_team_condition"] ?? 'No Condition Info',
    id: json["id"] ?? 0,
    organizerBy: json["organizer_by"] ?? 'Unknown',
    ageGroup: json["age_group"] ?? 'All Ages',
    language: json["language"] ?? 'Unknown',
    days: json["days"] ?? 0,
    startToEndDate: json["start_to_end_date"] ?? 'Unknown',
    youtubeVideo: json["youtube_video"] ?? 'No Video',
    allVenueData: json["all_venue_data"] != null
        ? List<AllVenueSubData>.from(json["all_venue_data"].map((x) => AllVenueSubData.fromJson(x)))
        : [],
    eventImage: json["event_image"] ?? 'No Image',
    images: json["images"] != null
        ? List<String>.from(json["images"].map((x) => x.toString()))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "en_event_name": enEventName,
    "en_event_about": enEventAbout,
    "en_event_schedule": enEventSchedule,
    "en_event_attend": enEventAttend,
    "en_event_team_condition": enEventTeamCondition,
    "hi_event_name": hiEventName,
    "hi_event_about": hiEventAbout,
    "hi_event_schedule": hiEventSchedule ,"hi_event_attend": hiEventAttend,
    "hi_event_team_condition": hiEventTeamCondition,
    "id": id,
    "organizer_by": organizerBy,
    "age_group": ageGroup,
    "language": language,
    "days": days,
    "start_to_end_date": startToEndDate,
    "youtube_video": youtubeVideo,
    "all_venue_data": List<dynamic>.from(allVenueData.map((x) => x.toJson())),
    "event_image": eventImage,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class AllVenueSubData {
  String enEventVenue;
  EnEventCountry? enEventCountry;
  String? enEventState;
  String? enEventCities;
  String? enEventLat;
  String? enEventLong;
  DateTime date;
  String startTime;
  String endTime;
  String eventDuration;
  List<PackageData> packageData;
  String hiEventVenue;
  HiEventCountry hiEventCountry;
  String hiEventState;
  String? hiEventCities;
  String? hiEventLat;
  String? hiEventLong;
  int id;

  AllVenueSubData({
    required this.enEventVenue,
    required this.enEventCountry,
    this.enEventState,
    this.enEventCities,
    this.enEventLat,
    this.enEventLong,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventDuration,
    required this.packageData,
    required this.hiEventVenue,
    required this.hiEventCountry,
    required this.hiEventState,
    this.hiEventCities,
    this.hiEventLat,
    this.hiEventLong,
    required this.id,
  });

  factory AllVenueSubData.fromJson(Map<String, dynamic> json) => AllVenueSubData(
    enEventVenue: json["en_event_venue"] ?? 'No Venue',
    enEventCountry: enEventCountryValues.map[json["en_event_country"]] ?? EnEventCountry.INDIA,
    enEventState: json["en_event_state"],
    enEventCities: json["en_event_cities"],
    enEventLat: json["en_event_lat"],
    enEventLong: json["en_event_long"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"] ?? 'No Start Time',
    endTime: json["end_time"] ?? 'No End Time',
    eventDuration: json["event_duration"] ?? 'No Duration',
    packageData: List<PackageData>.from(json["package_list"].map((x) => PackageData.fromJson(x))),
    hiEventVenue: json["hi_event_venue"] ?? 'No Venue',
    hiEventCountry: hiEventCountryValues.map[json["hi_event_country"]] ?? HiEventCountry.EMPTY,
    hiEventState: json["hi_event_state"] ?? 'No State',
    hiEventCities: json["hi_event_cities"],
    hiEventLat: json["hi_event_lat"],
    hiEventLong: json["hi_event_long"],
    id: json["id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "en_event_venue": enEventVenue,
    "en_event_country": enEventCountryValues.reverse[enEventCountry],
    "en_event_state": enEventState,
    "en_event_cities": enEventCities,
    "en_event_lat": enEventLat,
    "en_event_long": enEventLong,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "event_duration": eventDuration,
    "package_list": List<dynamic>.from(packageData.map((x) => x.toJson())),
    "hi_event_venue": hiEventVenue,
    "hi_event_country": hiEventCountryValues.reverse[hiEventCountry],
    "hi_event_state": hiEventState,
    "hi_event_cities": hiEventCities,
    "hi_event_lat": hiEventLat,
    "hi_event_long": hiEventLong,
    "id": id,
  };
}

enum EnEventCountry {
  INDIA
}

final enEventCountryValues = EnumValues({
  "India": EnEventCountry.INDIA
});

enum HiEventCountry {
  EMPTY
}

final hiEventCountryValues = EnumValues({
  "भारत": HiEventCountry.EMPTY
});

class PackageData {
  String packageName;
  String seatsNo;
  String priceNo;
  dynamic available;
  int sold;
  String packageId;
  String enPackageName;
  String hiPackageName;

  PackageData({
    required this.packageName,
    required this.seatsNo,
    required this.priceNo,
    required this.available,
    required this.sold,
    required this.packageId,
    required this.enPackageName,
    required this.hiPackageName,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) => PackageData(
    packageName: json["package_name"] ?? 'No Package Name',
    seatsNo: json["seats_no"] ?? '0',
    priceNo: json["price_no"] ?? '0',
    available: json["available"] ?? 0,
    sold: json["sold"] ?? 0,
    packageId: json["package_id"] ?? 'No Package ID',
    enPackageName: json["en_package_name"] ?? 'No English Package Name',
    hiPackageName: json["hi_package_name"] ?? 'No Hindi Package Name',
  );

  Map<String, dynamic> toJson() => {
    "package_name": packageName,
    "seats_no": seatsNo,
    "price_no": priceNo,
    "available": available,
    "sold": sold,
    "package_id": packageId,
    "en_package_name": enPackageName,
    "hi_package_name": hiPackageName,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
