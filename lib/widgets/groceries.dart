import 'package:flutter/material.dart';
import 'package:groceries/models/grocery.dart';
import 'package:groceries/widgets/new_grocery.dart';

class Groceries extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const Groceries({super.key, required this.onToggleTheme});

  @override
  State<StatefulWidget> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  final List<Grocery> _registeredGroceries = [
    Grocery(
      title: 'Apples',
      amount: '5',
      category: Category.fruitsAndVegetables,
    ),
    Grocery(
      title: 'Milk',
      amount: '2 liters',
      category: Category.dairyAndEggs,
    ),
    Grocery(
      title: 'Chicken Breast',
      amount: '1 kg',
      category: Category.meatAndSeafood,
    ),
    Grocery(
      title: 'Bread',
      amount: '1 loaf',
      category: Category.bakery,
    ),
    Grocery(
      title: 'Frozen Pizza',
      amount: '1',
      category: Category.frozenFoods,
    ),
  ];

  void _openAddGroceryOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewGrocery(
        onAddGrocery: _addGrocery,
      ),
    );
  }

  void _addGrocery(Grocery grocery) {
    setState(() {
      _registeredGroceries.add(grocery);
    });
  }

  void _removeGrocery(Grocery grocery) {
    final groceryIndex = _registeredGroceries.indexOf(grocery);
    setState(() {
      _registeredGroceries.remove(grocery);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Grocery Deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredGroceries.insert(groceryIndex, grocery);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Group groceries by category
    Map<Category, List<Grocery>> groupedGroceries = {};
    for (var grocery in _registeredGroceries) {
      if (groupedGroceries[grocery.category] == null) {
        groupedGroceries[grocery.category] = [];
      }
      groupedGroceries[grocery.category]!.add(grocery);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('GrocerEase'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            onPressed: _openAddGroceryOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Expanded(
                  child: ListView(
                    children: groupedGroceries.entries.map((entry) {
                      final category = entry.key;
                      final groceries = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 4,
                        child: ExpansionTile(
                          title: Text(category.name),
                          children: groceries.map((grocery) {
                            return ListTile(
                              title: Text(grocery.title),
                              subtitle: Text(grocery.amount),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeGrocery(grocery),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: ListView(
                    children: groupedGroceries.entries.map((entry) {
                      final category = entry.key;
                      final groceries = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 4,
                        child: ExpansionTile(
                          title: Text(category.name),
                          children: groceries.map((grocery) {
                            return ListTile(
                              title: Text(grocery.title),
                              subtitle: Text(grocery.amount),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeGrocery(grocery),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
