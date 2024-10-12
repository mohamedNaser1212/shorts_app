import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';

// Other related classes remain unchanged...

class EditUserProfileImageWidget extends StatefulWidget {
  const EditUserProfileImageWidget({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  State<EditUserProfileImageWidget> createState() =>
      _EditUserProfileImageWidgetState();
}

class _EditUserProfileImageWidgetState
    extends State<EditUserProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    print('image file: ${widget.editState.imageFile}');
    print('profile pic: ${widget.editState.profilePic}');
    return GestureDetector(
      onTap: widget.editState.pickImage,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 120,
        backgroundImage: widget.editState.imageFile != null
            ? FileImage(widget.editState.imageFile!)
            : widget.editState.profilePic != null
                ? NetworkImage(widget.editState.profilePic!)
                : null,
        child: widget.editState.imageFile == null &&
                widget.editState.profilePic == null
            ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
            : null,
      ),
    );
  }
}
