import 'package:custom_side_menu/src/provider.dart';
import 'package:custom_side_menu/src/side_menu_display_mode.dart';
import 'package:custom_side_menu/src/side_menu_item.dart';
import 'package:custom_side_menu/src/side_menu_style.dart';
import 'package:flutter/material.dart';





class SideMenu extends StatelessWidget {
  
   SideMenu({Key? key, required this.controller ,this.style, this.header, this.footer, required this.items }) : super(key: key);
  
 // PageController pController;
  final SideMenuStyle? style;

  final Widget ? header;
  final Widget ? footer;
  final List<SideMenuItem> items;


  final ValueNotifier<bool> _toggle = ValueNotifier<bool>(true);
    
  double _widthSize(SideMenuDisplayMode mode, BuildContext context) {
  if (mode == SideMenuDisplayMode.auto) {
      if (MediaQuery.of(context).size.width > 600) {
        GProvider.displayModeState.change(SideMenuDisplayMode.open);
        return GProvider.style.openSideMenuWidth ?? 300;
      } else {
        GProvider.displayModeState.change(SideMenuDisplayMode.compact);
        return GProvider.style.compactSideMenuWidth ?? 50;
      }
    }     
    else if (GProvider.style.toggleMode== false && mode == SideMenuDisplayMode.open || GProvider.style.toggleMode== true && _toggle.value ==true) {
      GProvider.displayModeState.change(SideMenuDisplayMode.open);
      return GProvider.style.openSideMenuWidth ?? 300;
    } 
    else{
      
      GProvider.displayModeState.change(SideMenuDisplayMode.compact);
      return GProvider.style.compactSideMenuWidth ?? 50;}
    

  }


 final PageController controller;
  @override
  Widget build(BuildContext context) {
  
   GProvider.controller = controller;
   items.sort((a, b) => a.priority.compareTo(b.priority));
   GProvider.style = style ?? SideMenuStyle();

   return  
ValueListenableBuilder(
    valueListenable: _toggle,
    builder: (context, value, child) {
       return AnimatedContainer(
        width: _widthSize(GProvider.style.displayMode ?? SideMenuDisplayMode.auto, context),
        height: MediaQuery.of(context).size.height,
       
        color: GProvider.style.backgroundColor ?? Theme.of(context).cardColor,
        duration:  Duration(milliseconds: GProvider.style.animationDuration ?? 350),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

         if (header != null)
            header!,


          Flexible(child: 
           
            ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
              return SideMenuItem(
                
                title: items[index].title, 
                icon: items[index].icon,
                onTap: items[index].onTap, 
                priority: items[index].priority,
                badgeContent: items[index].badgeContent,
                badgeColor: items[index].badgeColor,
              );
            }
            ),
          ),


         if (footer != null)
            footer!,


            Visibility(
           
              visible:GProvider.style.displayMode != SideMenuDisplayMode.auto && GProvider.style.toggleMode,   
              child: IconButton(
                     onPressed: (){ _toggle.value = !_toggle.value; }, 
                     icon: _toggle.value ? const Icon(Icons.arrow_left_outlined, color:Colors.blue): const Icon(Icons.arrow_right_outlined, color:Colors.blue)
                    ), 
            ),

            


          ],
    ),
    );
    },
);


  }
}