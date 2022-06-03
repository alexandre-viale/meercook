import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/model/recipe_step.dart';

class StepsEditor extends StatefulWidget {
  const StepsEditor({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  State<StepsEditor> createState() => _StepsEditorState();
}

class _StepsEditorState extends State<StepsEditor> {
  List<RecipeStep> steps = [];
  List<RecipeStep> savedSteps = [];
  final Map<String, TextEditingController> _stepControllers = {};

  @override
  void initState() {
    super.initState();
    steps = savedSteps = widget.recipe.steps;
    for (final step in steps) {
      _stepControllers[step.id.toString()] =
          TextEditingController(text: step.text);
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
                suffix: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(CupertinoIcons.clear_thick_circled),
                  onPressed: () {
                    setState(() {
                      steps.removeAt(index);
                    });
                  },
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${index + 1}.',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
                controller: _stepControllers[steps[index].id.toString()],
                placeholder: 'Étape',
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
          onPressed: () => setState(
            () => steps.add(
              RecipeStep(
                sortId: steps.length + 1,
                recipeId: widget.recipe.id!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
