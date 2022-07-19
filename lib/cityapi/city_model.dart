import 'dart:core';

class CityApiModel {
  late String id;
  late String cityname;
  late String rank;
  late String population;
  late String province;
  late String description;
  late String image;

  //constructor
  CityApiModel(
      {required this.id,
      required this.cityname,
      required this.rank,
      required this.population,
      required this.province,
      required this.description,
      required this.image});

  //fun Map to Obj
  CityApiModel.fromMapToObjectFun(Map<String, dynamic> mymap) {
    id = mymap["id"];
    cityname = mymap["cityname"];
    rank = mymap["rank"];
    population = mymap["population"];
    province = mymap["province"];
    description = mymap["description"];
    image = mymap["image"];
  }

  //fun Json to Map
  Map<String, dynamic> pojoToMap() {
    return {
      "id": id,
      "cityname": cityname,
      "rank": rank,
      "population": population,
      "province": province,
      "description": description,
      "image": image,
    };
  }
}
