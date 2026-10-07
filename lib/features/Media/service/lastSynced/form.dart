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