import 'package:geolocator/geolocator.dart';

class GetLocation{
  double latitude;
  double longitude;
  String city;
  Future<void>getCurrentLocation() async{
    try{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     latitude=position.latitude;
     longitude=position.longitude;

    city=await getCityName(position.latitude, position.longitude);
    }catch(e){
      print(e);
    }
  }
  Future<String> getCityName(double lat,double lon) async{
    List<Placemark> placeMark=await Geolocator().placemarkFromCoordinates(lat, lon);
    print("city name is: ${placeMark[0].locality}");
    return placeMark[0].locality;
  }
}