

import 'dart:convert';

SingleDetailsModel singleDetailsModelFromJson(String str) => SingleDetailsModel.fromJson(json.decode(str));

String singleDetailsModelToJson(SingleDetailsModel data) => json.encode(data.toJson());

class SingleDetailsModel {
  int status;
  String message;
  String recode;
  Data data;

  SingleDetailsModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory SingleDetailsModel.fromJson(Map<String, dynamic> json) => SingleDetailsModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": data.toJson(),
  };
}

class Data {
  String enEventName;
  String hiEventName;
  String enEventAbout;
  String hiEventAbout;
  String enEventSchedule;
  String hiEventSchedule;
  String enEventAttend;
  String hiEventAttend;
  String enEventTeamCondition;
  String hiEventTeamCondition;
  String enLanguage;
  String hiLanguage;
  int id;
  String organizerBy;
  String ageGroup;
  int days;
  String startToEndDate;
  String youtubeVideo;
  int eventInterested;
  Categorys categorys;
  Organizers organizers;
  String eventImage;
  Artist artist;
  List<AllVenueDatum> allVenueData;
  List<String> images;

  Data({
    required this.enEventName,
    required this.hiEventName,
    required this.enEventAbout,
    required this.hiEventAbout,
    required this.enEventSchedule,
    required this.hiEventSchedule,
    required this.enEventAttend,
    required this.hiEventAttend,
    required this.enEventTeamCondition,
    required this.hiEventTeamCondition,
    required this.enLanguage,
    required this.hiLanguage,
    required this.id,
    required this.organizerBy,
    required this.ageGroup,
    required this.days,
    required this.startToEndDate,
    required this.youtubeVideo,
    required this.eventInterested,
    required this.categorys,
    required this.organizers,
    required this.eventImage,
    required this.artist,
    required this.allVenueData,
    required this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    enEventName: json["en_event_name"],
    hiEventName: json["hi_event_name"],
    enEventAbout: json["en_event_about"],
    hiEventAbout: json["hi_event_about"],
    enEventSchedule: json["en_event_schedule"],
    hiEventSchedule: json["hi_event_schedule"],
    enEventAttend: json["en_event_attend"],
    hiEventAttend: json["hi_event_attend"],
    enEventTeamCondition: json["en_event_team_condition"],
    hiEventTeamCondition: json["hi_event_team_condition"],
    enLanguage: json["en_language"],
    hiLanguage: json["hi_language"],
    id: json["id"],
    organizerBy: json["organizer_by"],
    ageGroup: json["age_group"],
    days: json["days"],
    startToEndDate: json["start_to_end_date"],
    youtubeVideo: json["youtube_video"],
    eventInterested: json["event_interested"],
    categorys: Categorys.fromJson(json["categorys"]),
    organizers: Organizers.fromJson(json["organizers"]),
    eventImage: json["event_image"],
    artist: Artist.fromJson(json["artist"]),
    allVenueData: List<AllVenueDatum>.from(json["all_venue_data"].map((x) => AllVenueDatum.fromJson(x))),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "en_event_name": enEventName,
    "hi_event_name": hiEventName,
    "en_event_about": enEventAbout,
    "hi_event_about": hiEventAbout,
    "en_event_schedule": enEventSchedule,
    "hi_event_schedule": hiEventSchedule,
    "en_event_attend": enEventAttend,
    "hi_event_attend": hiEventAttend,
    "en_event_team_condition": enEventTeamCondition,
    "hi_event_team_condition": hiEventTeamCondition,
    "en_language": enLanguage,
    "hi_language": hiLanguage,
    "id": id,
    "organizer_by": organizerBy,
    "age_group": ageGroup,
    "days": days,
    "start_to_end_date": startToEndDate,
    "youtube_video": youtubeVideo,
    "event_interested": eventInterested,
    "categorys": categorys.toJson(),
    "organizers": organizers.toJson(),
    "event_image": eventImage,
    "artist": artist.toJson(),
    "all_venue_data": List<dynamic>.from(allVenueData.map((x) => x.toJson())),
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class AllVenueDatum {
  String enEventVenue;
  dynamic enEventCountry;
  dynamic enEventState;
  dynamic enEventCities;
  dynamic enEventLat;
  dynamic enEventLong;
  DateTime date;
  String startTime;
  String endTime;
  String eventDuration;
  List<PackageList> packageList;
  String hiEventVenue;
  dynamic hiEventCountry;
  dynamic hiEventState;
  dynamic hiEventCities;
  dynamic hiEventLat;
  dynamic hiEventLong;
  int id;

  AllVenueDatum({
    required this.enEventVenue,
    required this.enEventCountry,
    required this.enEventState,
    required this.enEventCities,
    required this.enEventLat,
    required this.enEventLong,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventDuration,
    required this.packageList,
    required this.hiEventVenue,
    required this.hiEventCountry,
    required this.hiEventState,
    required this.hiEventCities,
    required this.hiEventLat,
    required this.hiEventLong,
    required this.id,
  });

  factory AllVenueDatum.fromJson(Map<String, dynamic> json) => AllVenueDatum(
    enEventVenue: json["en_event_venue"],
    enEventCountry: json["en_event_country"],
    enEventState: json["en_event_state"],
    enEventCities: json["en_event_cities"],
    enEventLat: json["en_event_lat"],
    enEventLong: json["en_event_long"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    eventDuration: json["event_duration"],
    packageList: List<PackageList>.from(json["package_list"].map((x) => PackageList.fromJson(x))),
    hiEventVenue: json["hi_event_venue"],
    hiEventCountry: json["hi_event_country"],
    hiEventState: json["hi_event_state"],
    hiEventCities: json["hi_event_cities"],
    hiEventLat: json["hi_event_lat"],
    hiEventLong: json["hi_event_long"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "en_event_venue": enEventVenue,
    "en_event_country": enEventCountry,
    "en_event_state": enEventState,
    "en_event_cities": enEventCities,
    "en_event_lat": enEventLat,
    "en_event_long": enEventLong,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "event_duration": eventDuration,
    "package_list": List<dynamic>.from(packageList.map((x) => x.toJson())),
    "hi_event_venue": hiEventVenue,
    "hi_event_country": hiEventCountry,
    "hi_event_state": hiEventState,
    "hi_event_cities": hiEventCities,
    "hi_event_lat": hiEventLat,
    "hi_event_long": hiEventLong,
    "id": id,
  };
}

class PackageList {
  String packageName;
  String seatsNo;
  String priceNo;
  dynamic available;
  int sold;
  String packageId;
  String enPackageName;
  String hiPackageName;

  PackageList({
    required this.packageName,
    required this.seatsNo,
    required this.priceNo,
    required this.available,
    required this.sold,
    required this.packageId,
    required this.enPackageName,
    required this.hiPackageName,
  });

  factory PackageList.fromJson(Map<String, dynamic> json) => PackageList(
    packageName: json["package_name"],
    seatsNo: json["seats_no"],
    priceNo: json["price_no"],
    available: json["available"],
    sold: json["sold"],
    packageId: json["package_id"],
    enPackageName: json["en_package_name"],
    hiPackageName: json["hi_package_name"],
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

class Artist {
  int id;
  String enArtistName;
  String hiArtistName;
  String enDescription;
  String hiDescription;
  String enProfession;
  String hiProfession;

  Artist({
    required this.id,
    required this.enArtistName,
    required this.hiArtistName,
    required this.enDescription,
    required this.hiDescription,
    required this.enProfession,
    required this.hiProfession,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"],
    enArtistName: json["en_artist_name"],
    hiArtistName: json["hi_artist_name"],
    enDescription: json["en_description"],
    hiDescription: json["hi_description"],
    enProfession: json["en_profession"],
    hiProfession: json["hi_profession"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "en_artist_name": enArtistName,
    "hi_artist_name": hiArtistName,
    "en_description": enDescription,
    "hi_description": hiDescription,
    "en_profession": enProfession,
    "hi_profession": hiProfession,
  };
}

class Categorys {
  int id;
  String enCategoryName;
  String hiCategoryName;
  String image;

  Categorys({
    required this.id,
    required this.enCategoryName,
    required this.hiCategoryName,
    required this.image,
  });

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
    id: json["id"],
    enCategoryName: json["en_category_name"],
    hiCategoryName: json["hi_category_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "en_category_name": enCategoryName,
    "hi_category_name": hiCategoryName,
    "image": image,
  };
}

class Organizers {
  String enOrganizerName;
  String hiOrganizerName;
  int id;
  String fullName;
  String emailAddress;
  String contactNumber;
  String image;

  Organizers({
    required this.enOrganizerName,
    required this.hiOrganizerName,
    required this.id,
    required this.fullName,
    required this.emailAddress,
    required this.contactNumber,
    required this.image,
  });

  factory Organizers.fromJson(Map<String, dynamic> json) => Organizers(
    enOrganizerName: json["en_organizer_name"],
    hiOrganizerName: json["hi_organizer_name"],
    id: json["id"],
    fullName: json["full_name"],
    emailAddress: json["email_address"],
    contactNumber: json["contact_number"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "en_organizer_name": enOrganizerName,
    "hi_organizer_name": hiOrganizerName,
    "id": id,
    "full_name": fullName,
    "email_address": emailAddress,
    "contact_number": contactNumber,
    "image": image,
  };
}



