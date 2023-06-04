import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingStartComponent extends StatefulWidget {
  int rating = 0;
  bool isEditable = false;

  RatingStartComponent({required this.rating, required this.isEditable});
  @override
  State<RatingStartComponent> createState() => _RatingStarComponent();
}

class _RatingStarComponent extends State<RatingStartComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.isEditable) {
              setState(() {
                widget.rating = 1;
              });
            }
          },
          child: Icon(
            Icons.star,
            color: widget.rating > 0 ? Colors.yellow : Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.isEditable) {
              setState(() {
                widget.rating = 2;
              });
            }
          },
          child: Icon(
            Icons.star,
            color: widget.rating > 1 ? Colors.yellow : Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.isEditable) {
              setState(() {
                widget.rating = 3;
              });
            }
          },
          child: Icon(
            Icons.star,
            color: widget.rating > 2 ? Colors.yellow : Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.isEditable) {
              setState(() {
                widget.rating = 4;
              });
            }
          },
          child: Icon(
            Icons.star,
            color: widget.rating > 3 ? Colors.yellow : Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.isEditable) {
              setState(() {
                widget.rating = 5;
              });
            }
          },
          child: Icon(
            Icons.star,
            color: widget.rating > 4 ? Colors.yellow : Colors.grey,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(widget.rating.toString())
      ],
    );
  }
}