// levels.dart
// Screen that displays level selection buttons (0 to 10).
// Layout is fully responsive: it calculates button sizes based on
// available screen width/height, so it adapts to any device.

import 'package:flutter/material.dart';

import 'button_0.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen width, used for scaling text in the AppBar title.
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF3F5F1,
      ), // Light background color. Change here to alter overall theme.
      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF2E7D32,
        ), // AppBar color. Change to re-theme.
        elevation: 0,
        centerTitle: true,
        title: Text(
          "SELECT LEVEL",
          style: TextStyle(
            fontSize: screenWidth * 0.055, // Scales with screen width.
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(0),
          // LayoutBuilder gives us the exact available width/height
          // for the body area (excluding AppBar and status bar).
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;

              // ---- CONFIGURABLE LAYOUT VALUES ----
              const int crossAxisCount =
                  2; // Number of columns in the grid (levels 0-9).
              const int gridRowCount =
                  5; // Number of rows in the grid (10 items / 2 columns).
              const double outerPaddingRatio =
                  0.05; // Padding around entire body, relative to width.
              const double spacingRatio =
                  0.02; // Spacing between buttons, relative to height.

              // Outer padding (scales with screen size).
              final outerPaddingH = maxWidth * outerPaddingRatio;
              final outerPaddingV = maxHeight * outerPaddingRatio;

              // Usable area after removing outer padding.
              final usableWidth = maxWidth - (outerPaddingH * 2);
              final usableHeight = maxHeight - (outerPaddingV * 2);

              // Spacing values between buttons.
              final crossSpacing =
                  usableWidth * 0.04; // Horizontal gap between grid buttons.
              final mainSpacing =
                  usableHeight *
                  spacingRatio; // Vertical gap between grid rows.
              final gridToButton10Spacing =
                  usableHeight * spacingRatio; // Gap before button 10.

              // ---- CALCULATE UNIFORM BUTTON HEIGHT ----
              // Total vertical space is divided into:
              // - gridRowCount rows for buttons 0-9
              // - 1 row for button 10
              // - spacing gaps between all rows (gridRowCount - 1) + 1 gap before button 10
              final totalRows = gridRowCount + 1; // +1 for button 10's row
              final totalSpacing =
                  (mainSpacing * (gridRowCount - 1)) + gridToButton10Spacing;
              final cellHeight = (usableHeight - totalSpacing) / totalRows;

              // ---- CALCULATE GRID BUTTON WIDTH ----
              final gridButtonWidth =
                  (usableWidth - (crossSpacing * (crossAxisCount - 1))) /
                  crossAxisCount;

              // Aspect ratio required by GridView (width / height) so that
              // each grid button matches the calculated cellHeight exactly.
              final childAspectRatio = gridButtonWidth / cellHeight;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: outerPaddingH,
                  vertical: outerPaddingV,
                ),
                child: Column(
                  children: [
                    // ---------------- GRID: LEVELS 0-9 ----------------
                    GridView.builder(
                      shrinkWrap: true, // Grid takes only the height it needs.
                      physics:
                          const NeverScrollableScrollPhysics(), // No scrolling.
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: mainSpacing,
                        crossAxisSpacing: crossSpacing,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: 10, // Levels 0 to 9.
                      itemBuilder: (context, index) {
                        return _LevelButton(
                          label: "$index",
                          onPressed: () {
                            print(index);
                            if (index == 0) {
                              print(index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Button0(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    // Spacing before button 10.
                    SizedBox(height: gridToButton10Spacing),

                    // ---------------- BUTTON: LEVEL 10 ----------------
                    SizedBox(
                      width: double.infinity,
                      height: cellHeight, // Same height as grid buttons for consistency.
                      child: _LevelButton(
                        label: "10",
                        onPressed: () {
                          // TODO: Add navigation or level-selection logic here.
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---------------- REUSABLE LEVEL BUTTON ----------------
// A single button used for both the grid (0-9) and button 10.
// Uses FittedBox so the text automatically scales to fit the button's
// actual rendered size — this is what keeps text proportional on
// every screen size instead of relying on guessed font sizes.
class _LevelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _LevelButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(
          0xFF2E7D32,
        ), // Button color. Change to re-theme.
        elevation: 3,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Corner roundness.
        ),
        padding:
            EdgeInsets.zero, // Padding removed so FittedBox controls sizing.
      ),
      child: FittedBox(
        fit: BoxFit
            .scaleDown, // Shrinks text if button is small, never overflows.
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Inner text padding.
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 40, // Base size; FittedBox scales it down as needed.
            ),
          ),
        ),
      ),
    );
  }
}
