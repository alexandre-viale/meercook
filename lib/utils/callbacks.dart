import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe_step.dart';
import 'package:image_picker/image_picker.dart';

typedef StringCallback = void Function(String val);
typedef IngredientListCallBack = void Function(List<Ingredient> val);
typedef StepListCallBack = void Function(List<RecipeStep> val);
typedef XFileCallback = void Function(XFile val);
