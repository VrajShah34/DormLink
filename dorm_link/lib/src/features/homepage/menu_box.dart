import 'package:flutter/material.dart';

class MenuBox extends StatelessWidget {
  const MenuBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.food_bank,
              size: 40,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    "Dinner",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    'Chhola, Aloooo, Roti, Rasgulla',
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
