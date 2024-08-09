import 'package:flutter/material.dart';

class SearchBars extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanges;
  final TextEditingController controller;
  final EdgeInsetsGeometry? marginSize;

  const SearchBars({
    super.key,
    this.hintText,
    this.iconData,
    this.onSearch,
    this.onChanges,
    required this.controller,
    this.marginSize,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginSize ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.purple,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search_rounded, color: Colors.white),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanges,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) => onSearch!(),
              decoration: const InputDecoration(
                hintText: "Search Movies...",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBarButton extends StatelessWidget {
  final VoidCallback? onClicked;
  
  const SearchBarButton({
    super.key,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        side: const BorderSide(color: Colors.purple),
      ),
      onPressed: onClicked,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, color: Colors.white),
          ),
          const Expanded(
            child: Text(
              "Search Movies",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}