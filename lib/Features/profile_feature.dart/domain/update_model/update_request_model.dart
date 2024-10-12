
import 'package:shorts/core/utils/constants/request_data_names.dart';

class UpdateUserRequestModel {
  final String name;
  final String email;
  final String phone;
  final String imageUrl; 

  UpdateUserRequestModel({
    required this.name,
    required this.email,
    required this.phone,
   required this.imageUrl, 
  });

  Map<String, dynamic> toMap() {
    return {
      RequestDataNames.name: name,
      RequestDataNames.email: email,
      RequestDataNames.phone: phone,
      RequestDataNames.profilePic: imageUrl,
    };
  }
}
