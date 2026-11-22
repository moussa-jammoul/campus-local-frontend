// ignore_for_file: file_names
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter/material.dart';

class Logintext extends StatelessWidget {
  const Logintext({super.key});


  @override
  Widget build(BuildContext context) {
   
    return
    Column( 
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
      SizedBox(
       width: 250,  
       
       child:
       Center( 
        child:Text(
        'Log In to Continue ',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight(600),
          overflow: TextOverflow.ellipsis
        ),
       ), 
       )
    ),
     SizedBox(
       width: 150,  
      
       child:
       Center( 
        child:Text(
        'With Campus Local',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight(400),
          overflow: TextOverflow.ellipsis
        ),
       ), 
       )
    )
    ]);

  }

}

