import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  final int? selectedIndex;
  final Function(int) onSelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final categoryName = widget.categories[index];
          final isSelected = index == widget.selectedIndex;

          return GestureDetector(
            onTapDown: (_) {
              setState(() {
                _pressedIndex = index;
              });
            },
            onTapUp: (_) {
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  _pressedIndex = null;
                });
              });
            },
            onTapCancel: () {
              setState(() {
                _pressedIndex = null;
              });
            },
            onTap: () {
              print(CategoryIconMapper.getCategories()[index]);
              widget.onSelected(index);
            },
            child: AnimatedScale(
              scale: _pressedIndex == index ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: 110,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Colors.orange.shade400,
                            Colors.orange.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [Colors.white, Colors.grey.shade100],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.orange.shade800
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? Colors.orange.withOpacity(0.5)
                          : Colors.black12,
                      blurRadius: isSelected ? 12 : 6,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CategoryIconMapper.getIcon(categoryName),
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categoryName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
