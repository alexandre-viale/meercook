import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/model/recipe_step.dart';
import 'package:meercook/utils/callbacks.dart';

class StepsEditor extends StatefulWidget {
  const StepsEditor({
    Key? key,
    required this.recipe,
    required this.onModified,
  }) : super(key: key);
  final Recipe recipe;
  final StepListCallBack onModified;
  @override
  State<StepsEditor> createState() => _StepsEditorState();
}

class _StepsEditorState extends State<StepsEditor> {
  List<RecipeStep> steps = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    steps = widget.recipe.steps;
    for (var i = 0; i < steps.length; i++) {
      focusNodes.add(FocusNode());
    }
    super.initState();
  }

  void resetSortId() {
    for (var i = 0; i < steps.length; i++) {
      steps[i].sortId = i + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          cacheExtent: 0,
          padding: const EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          itemCount: steps.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CupertinoTextField(
                focusNode: focusNodes[index],
                textCapitalization: TextCapitalization.sentences,
                suffix: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(CupertinoIcons.clear_thick_circled),
                  onPressed: () {
                    setState(() {
                      steps.removeAt(index);
                      focusNodes.removeAt(index);
                    });
                    resetSortId();
                    widget.onModified(steps);
                  },
                ),
                expands: false,
                minLines: 1,
                maxLines: 1,
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${index + 1}.',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
                controller: TextEditingController(text: steps[index].text),
                placeholder: 'Étape',
                onChanged: (value) {
                  steps[index].text = value;
                  widget.onModified(steps);
                },
                onSubmitted: (value) {
                  if (!steps.asMap().containsKey(index + 1) &&
                      value.isNotEmpty) {
                    setState(
                      () {
                        steps.add(
                          RecipeStep(
                            text: '',
                            sortId: index + 2,
                          ),
                        );
                        focusNodes.add(FocusNode());
                      },
                    );
                    focusNodes[index + 1].requestFocus();
                  }
                  if (value.isEmpty) {
                    setState(() {
                      steps.removeAt(index);
                      focusNodes.removeAt(index);
                    });
                  }
                },
                textInputAction: TextInputAction.done,
              ),
            );
          },
        ),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: const [
              Icon(CupertinoIcons.add_circled),
              SizedBox(width: 5),
              Text(
                'Ajouter une étape',
              ),
            ],
          ),
          onPressed: () {
            setState(
              () {
                steps.add(
                  RecipeStep(
                    sortId: steps.length + 1,
                    text: '',
                  ),
                );
                focusNodes.add(FocusNode());
              },
            );
            focusNodes[steps.length - 1].requestFocus();
          },
        ),
      ],
    );
  }
}
