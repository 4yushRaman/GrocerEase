import 'package:flutter/material.dart';
import 'package:groceries/models/grocery.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem(this.grocery, {super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    // Mapping Category to Icon
    IconData getCategoryIcon(Category category) {
      switch (category) {
        case Category.fruitsAndVegetables:
          return Icons.local_florist; // Represent fruits and vegetables
        case Category.dairyAndEggs:
          return Icons.local_drink; // Use this for Dairy and Eggs
        case Category.meatAndSeafood:
          return Icons.restaurant; // For meat and seafood
        case Category.bakery:
          return Icons.cake; // For bakery items
        case Category.frozenFoods:
          return Icons.ac_unit; // For frozen foods
        case Category.pantryStaples:
          return Icons.local_grocery_store; // Pantry staples
        case Category.snacks:
          return Icons.fastfood; // Snacks
        case Category.beverages:
          return Icons
              .local_drink; // Beverages (same icon as Dairy, can be customized)
        case Category.household:
          return Icons.home; // Household items
        case Category.miscellaneous:
          return Icons.more_horiz; // Miscellaneous
        default:
          return Icons.help; // Default icon in case something goes wrong
      }
    }

    return Card(
      elevation: 4, // Slight elevation for a more distinct look
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            // Icon for category
            Icon(getCategoryIcon(grocery.category),
                size: 40, color: Colors.blue),
            const SizedBox(width: 12), // Spacing between icon and text
            // Grocery details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grocery.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(grocery.amount),
                ],
              ),
            ),
            // Delete button icon
            IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              onPressed: () {
                // Trigger delete action here (you can define this elsewhere)
              },
            ),
          ],
        ),
      ),
    );
  }
}
