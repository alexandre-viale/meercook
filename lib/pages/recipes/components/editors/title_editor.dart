import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class TitleEditor extends StatefulWidget {
  const TitleEditor({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  State<TitleEditor> createState() => _TitleEditorState();
}

class _TitleEditorState extends State<TitleEditor> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.recipe.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titre',
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
        const SizedBox(height: 5),
        CupertinoTextField(
          controller: _controller,
          placeholder: 'Titre',
        )
      ],
    );
  }
}
