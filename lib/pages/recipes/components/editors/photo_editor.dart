import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meercook/utils/callbacks.dart';

class PhotoEditor extends StatefulWidget {
  const PhotoEditor({Key? key, required this.onImageSelected})
      : super(key: key);
  final XFileCallback onImageSelected;
  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            CupertinoIcons.photo_camera,
          ),
          SizedBox(width: 10),
          Text(
            'Modifier la photo',
            textAlign: TextAlign.left,
          ),
        ],
      ),
      onPressed: () async {
        final ImagePicker picker = ImagePicker();
        // Pick an image
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          widget.onImageSelected(image);
        }
      },
    );
  }
}
