import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class DescriptionEditor extends StatefulWidget {
  const DescriptionEditor({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  State<DescriptionEditor> createState() => _DescriptionEditorState();
}

class _DescriptionEditorState extends State<DescriptionEditor> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.recipe.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
        const SizedBox(height: 5),
        CupertinoTextField(
          minLines: null,
          maxLines: null,
          expands: true,
          controller: _controller,
          placeholder: 'Description',
        )
      ],
    );
  }
}
