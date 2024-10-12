import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';

class EditUserProfileImageWidget extends StatefulWidget {
  const EditUserProfileImageWidget({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  State<EditUserProfileImageWidget> createState() =>
      __EditUserProfileImageWidgetStateState();
}

class __EditUserProfileImageWidgetStateState
    extends State<EditUserProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
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
