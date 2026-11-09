import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';

class CurrentAccountLinkedTile extends StatelessWidget{
  const CurrentAccountLinkedTile({super.key});


  @override
  Widget build(BuildContext context) {
    return CardStyleWidget(
      constraints: const BoxConstraints(  
        minWidth: 450,
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Account",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            FirebaseAuth.instance.currentUser?.email ?? 'Unkown',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
          )
        ],

      )
      );

    
  }

}