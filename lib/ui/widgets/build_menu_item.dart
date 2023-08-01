import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/images.dart' as AppImg;

class BuildMenuItem {
  const BuildMenuItem();

  Material menuItem(BuildContext context,
      {bool elevation, String icon, String label, VoidCallback onTap}) {
    return Material(
      type: MaterialType.canvas,
      elevation: elevation == true ? 0.3 : 0,
      shadowColor: elevation == true ? Colors.grey[200] : Colors.transparent,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.8),
          child: Column(
            children: [
              Image.asset(
                icon,
                height: 38,
              ),
              SizedBox(
                height: 6.5,
              ),
              FittedBox(
                child: Container(
                  width: 65,
                  child: RichText(
                    maxLines: kIsWeb ? null : 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: label,
                      style: AppTypo.overline.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material menuItemTelkom(BuildContext context,
      {bool elevation, String icon, String label, VoidCallback onTap}) {
    return Material(
      type: MaterialType.canvas,
      elevation: elevation == true ? 0.3 : 0,
      shadowColor: elevation == true ? Colors.grey[200] : Colors.transparent,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.8),
          child: Column(
            children: [
              Image.network(
                icon,
                height: 38,
              ),
              SizedBox(
                height: 6.5,
              ),
              FittedBox(
                child: Container(
                  width: 65,
                  child: RichText(
                    maxLines: kIsWeb ? null : 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: label,
                      style: AppTypo.overline.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
