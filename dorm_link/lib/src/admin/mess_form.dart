import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dorm_link/src/Common_widgets/customtextfield.dart';
import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';

class MessForm extends StatelessWidget {
  const MessForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    var selectedValue = "Breakfast";
    var selectedHostel = "BH1/BH4";
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          height: constraints.maxHeight * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context)
                  .colorScheme
                  .background),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Add Menu",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: controller,
                    hintText: "Menu Item"),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    hint: Text(
                      "Meal type",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground),
                    ),
                    items: [
                      DropdownMenuItem(
                          child: Text(
                            'Breakfast',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground),
                          ),
                          value: 'Breakfast'),
                      DropdownMenuItem(
                        child: Text(
                          'Lunch',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground),
                        ),
                        value: 'Lunch',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Dinner',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground),
                        ),
                        value: 'Dinner',
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      selectedValue = value;
                    }),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    hint: Text(
                      "Hostel",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground),
                    ),
                    items: [
                      DropdownMenuItem(
                          child: Text(
                            'BH1/BH4',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground),
                          ),
                          value: 'BH1/BH4'),
                      DropdownMenuItem(
                        child: Text(
                          'BH2/BH3',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground),
                        ),
                        value: 'BH2/BH3',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'BH5',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground),
                        ),
                        value: 'BH5',
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      selectedHostel = value;
                    }),
                const SizedBox(height: 20,),
                CustomBigButton(
                    onTap: () {
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                          content: Text(
                            "Menu added",
                            style: TextStyle(
                                color: Colors.white),
                          )));
                    },
                    title: "Add")
              ],
            ),
          ),
        );
      },
    );
  }
}
