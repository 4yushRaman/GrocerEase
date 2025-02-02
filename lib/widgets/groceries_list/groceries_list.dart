import 'package:flutter/material.dart';
import 'package:groceries/models/grocery.dart';
import 'package:groceries/widgets/groceries_list/grocery_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({
    super.key,
    required this.groceries,
    required this.onRemoveGrocery,
  });

  final List<Grocery> groceries;
  final void Function(Grocery) onRemoveGrocery;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceries.length,
      itemBuilder: (ctx, index) {
        final grocery = groceries[index];

        return Dismissible(
          key: ValueKey(grocery.id), // Use grocery ID for uniqueness
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.79),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onDismissed: (direction) {
            // Remove grocery and show undo SnackBar
            onRemoveGrocery(grocery);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${grocery.title} removed!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    // Add grocery back if the user presses undo
                    // (If you want to restore, you need to track the removed item)
                  },
                ),
              ),
            );
          },
          child: GroceryItem(grocery),
        );
      },
    );
  }
}
