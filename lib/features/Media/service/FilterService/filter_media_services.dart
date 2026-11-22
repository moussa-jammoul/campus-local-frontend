// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/favorite_filter.dart';


enum FilterTypes{
  favorites,
}

///filter services is used when we want to do similar work to all filters
///e.g reset all filters , ...
class FilterMediaServices extends Notifier<void> {
  @override
  void build() {
    
  }

  void resetFilters(){
    ref.read(currentFavStateProvider.notifier).resetToFalse();
  }

  void resetGroupeOfFilters(Set<FilterTypes> types){
    if(types.contains(FilterTypes.favorites)){
       ref.read(currentFavStateProvider.notifier).resetToFalse();
    }

  }


}

final filterServicesProvider = NotifierProvider<FilterMediaServices , void>((){
  return FilterMediaServices();
});