// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';


class CurrentFavState extends Notifier<bool>{
  @override
  bool build() {
    return false;
  }

  void changestate(){
    final current = state;
    
    state = !current;
    
  }
  

  //when adding a media , or exit the page , we should reset it
  void resetToFalse(){
    state = false;
  }

}
final currentFavStateProvider = NotifierProvider<CurrentFavState,bool>((){
  return CurrentFavState();
});


class FavoritesButton extends ConsumerStatefulWidget {
  FavoritesButton({super.key , this.courseUuid , this.types});
  String? courseUuid;
  List<String>? types;
  
  @override
  ConsumerState<FavoritesButton> createState() => _FavoritesButtonState();
}

class _FavoritesButtonState extends ConsumerState<FavoritesButton> {
 

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(currentFavStateProvider);
    return GestureDetector(
      onTap: () async {
        ref.read(currentFavStateProvider.notifier).changestate();
        final isFav = ref.read(currentFavStateProvider);
        await ref.read(mediaServiceProvider.notifier).refreshDataLocally(widget.courseUuid, widget.types, isFav);
        
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite,
              size: 18,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            const SizedBox(width: 4),
            const Text(
              'Favorites',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}