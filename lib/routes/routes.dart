import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:send_location_after_10/views/Home/HomeScreen.dart';
import 'package:send_location_after_10/views/SeeLocations/seeLocations.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(name: "/home", page: () => Homescreen()),
    GetPage(name: "/seelocations", page: () => Seelocations()),
  ];
}
