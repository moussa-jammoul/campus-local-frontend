// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class LastSyncedForm {
  DateTime lastUpdateSynced;
  String lastUuidSynced;
  LastSyncedForm({
    required this.lastUpdateSynced,
    required this.lastUuidSynced
  });

  Map<String,dynamic> toJson(){
    return {
      'last_update_synced' : lastUpdateSynced.toIso8601String(),
      'last_uuid_synced' : lastUuidSynced,
    };
  }

  factory LastSyncedForm.fromJson(Map<String, dynamic> json){
    return LastSyncedForm(
      lastUpdateSynced: DateTime.parse( json['last_update_synced']),
       lastUuidSynced: json['last_uuid_synced']
       );
  }

  

}