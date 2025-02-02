import 'package:flutter/material.dart';
import 'package:groceries/models/grocery.dart';

class NewGrocery extends StatefulWidget {
  const NewGrocery({
    super.key,
    required this.onAddGrocery,
  });

  final void Function(Grocery grocery) onAddGrocery;

  @override
  State<StatefulWidget> createState() {
    return _NewGroceryState();
  }
}

class _NewGroceryState extends State<NewGrocery> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selectedCategory;

  // Helper method to check form validity
  bool _isValidInput() {
    final enteredAmount = _amountController.text.trim();
    return _titleController.text.trim().isNotEmpty &&
        enteredAmount.isNotEmpty &&
        _selectedCategory != null &&
        _isValidAmount(enteredAmount);
  }

  // Helper method to validate amount (ensure it's numeric)
  bool _isValidAmount(String amount) {
    final parsedAmount = double.tryParse(amount);
    return parsedAmount != null && parsedAmount > 0;
  }

  // Category Dropdown Widget with Icons
  Widget _categoryDropdown() {
    return DropdownButton<Category?>(
      value: _selectedCategory,
      hint: Text(
        'Select Category',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      items: [
        DropdownMenuItem<Category?>(
            value: null,
            child: Text('Select Category',
                style: Theme.of(context).textTheme.bodyLarge)),
        ...Category.values.map(
          (category) => DropdownMenuItem<Category>(
            value: category,
            child: Row(
              children: [
                Icon(_getCategoryIcon(category),
                    color: Colors.blue), // Icon for category
                const SizedBox(width: 8),
                Text(category.name.toUpperCase())
              ],
            ),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  // Function to get icons for categories
  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.fruitsAndVegetables:
        return Icons.local_florist;
      case Category.dairyAndEggs:
        return Icons.egg;
      case Category.meatAndSeafood:
        return Icons.restaurant;
      case Category.bakery:
        return Icons.cake;
      case Category.frozenFoods:
        return Icons.ac_unit;
      case Category.pantryStaples:
        return Icons.local_grocery_store;
      case Category.snacks:
        return Icons.fastfood;
      case Category.beverages:
        return Icons.local_cafe;
      case Category.household:
        return Icons.home;
      case Category.miscellaneous:
        return Icons.more_horiz;
      default:
        return Icons.help;
    }
  }

  void _submitGroceryData() {
    if (!_isValidInput()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, and category were entered, and the amount is a valid number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddGrocery(
      Grocery(
        title: _titleController.text,
        amount: _amountController.text.trim(),
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  // Responsive layout for large screens
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(label: Text('Amount')),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text('Title')),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(label: Text('Amount')),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Shift the category dropdown to the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _categoryDropdown(),
                  ),
                  const SizedBox(height: 16),

                  // Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitGroceryData,
                        child: const Text('Save Grocery'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
