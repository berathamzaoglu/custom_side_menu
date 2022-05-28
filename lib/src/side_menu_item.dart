import 'package:custom_side_menu/src/provider.dart';
import 'package:custom_side_menu/src/side_menu_display_mode.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class SideMenuItem extends StatefulWidget {
  /// #### Side Menu Item
  ///
  /// This is a widget as [SideMenu] items with text and icon
  const SideMenuItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.priority,
    this.badgeContent,
    this.badgeColor,
  }) : super(key: key);


  final Function onTap;

  final String title;

  final IconData icon;

  final int priority;

  final Widget? badgeContent;

  final Color? badgeColor;

  @override
  _SideMenuItemState createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  
  
  double currentPage = 0;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // set initialPage
      setState(() {
       // currentPage = GProvider.controller.initialPage.toDouble();
      });
      if (this.mounted) {
        // set controller SideMenuItem page controller callback
        GProvider.controller.addListener(() {
          setState(() {
            currentPage = GProvider.controller.page!;
          });
        });
      }
    });
  }


  Color _setColor() {
    if (widget.priority == currentPage) {
      return GProvider.style.selectedColor ?? Theme.of(context).primaryColor;
    } else if (isHovered) {
      return GProvider.style.hoverColor ?? Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }


  @override
  Widget build(BuildContext context) {
    
    
    
    return  ValueListenableBuilder(
            valueListenable: GProvider.displayModeState,
            builder: (context, value, child) {
    
    return InkWell(
      
      child:Container(
       
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: _setColor(),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child:
               Padding(
                padding: EdgeInsets.symmetric(
                    vertical: value == SideMenuDisplayMode.compact ? 10 : 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                  
                     widget.badgeContent == null ?  
                     Icon(widget.icon,  
                        size: GProvider.style.iconSize, 
                        color: GProvider.style.selectedIconColor,)
                     :                
                     Badge(
                      badgeContent: widget.badgeContent!,
                      badgeColor: widget.badgeColor ?? Colors.red,
                      alignment: Alignment.bottomRight,
                      position: const BadgePosition(top: -13, end: -7),
                      child: Icon(
                        widget.icon, 
                        size: GProvider.style.iconSize, 
                        color: GProvider.style.selectedIconColor, 
                        
                        )),
                  
                  
                    const SizedBox(
                      width: 8.0,
                    ),
                    if (value == SideMenuDisplayMode.open)
                      Expanded(
                        child: Text(
                          widget.title,
                          style: widget.priority == currentPage.ceil()
                              ? const TextStyle(fontSize: 17, color: Colors.black)
                                  .merge(GProvider.style.selectedTitleTextStyle)
                              : const TextStyle(fontSize: 17, color: Colors.black54)
                                  .merge(GProvider.style.unselectedTitleTextStyle),
                        ),
                      ),
                  ],
                ),
              )
            
          ),
        
      
      onTap: () => widget.onTap(),
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
    }
    );
  }
}