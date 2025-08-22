import 'package:flutter/material.dart';

class FancySearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const FancySearchBar({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _FancySearchBarState createState() => _FancySearchBarState();
}

class _FancySearchBarState extends State<FancySearchBar>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  bool _isFocused = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientBorder = LinearGradient(
      colors: [Colors.deepOrange, Colors.yellowAccent],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient:
                  _isFocused
                      ? gradientBorder
                      : LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade300],
                      ),
              borderRadius: BorderRadius.circular(30),
              boxShadow:
                  _isFocused
                      ? [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.3),
                          blurRadius: 16,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ]
                      : [],
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/images/search.png",
                      width: 22,
                      height: 22,
                    ),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
