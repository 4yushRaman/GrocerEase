import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  fruitsAndVegetables,
  dairyAndEggs,
  meatAndSeafood,
  bakery,
  frozenFoods,
  pantryStaples,
  snacks,
  beverages,
  household,
  miscellaneous,
}

class Grocery {
  Grocery({
    required this.title,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String amount;
  final Category category;
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.fruitsAndVegetables:
        return 'Fruits and Vegetables';
      case Category.dairyAndEggs:
        return 'Dairy and Eggs';
      case Category.meatAndSeafood:
        return 'Meat and Seafood';
      case Category.bakery:
        return 'Bakery';
      case Category.frozenFoods:
        return 'Frozen Foods';
      case Category.pantryStaples:
        return 'Pantry Staples';
      case Category.snacks:
        return 'Snacks';
      case Category.beverages:
        return 'Beverages';
      case Category.household:
        return 'Household';
      case Category.miscellaneous:
        return 'Miscellaneous';
      default:
        return 'Unknown';
    }
  }
}

class GroceryBucket {
  const GroceryBucket({
    required this.category,
    required this.groceries,
  });

  GroceryBucket.forCategory(List<Grocery> allGroceries, this.category)
      : groceries = allGroceries
            .where((grocery) => grocery.category == category)
            .toList();

  final Category category;
  final List<Grocery> groceries;
}
