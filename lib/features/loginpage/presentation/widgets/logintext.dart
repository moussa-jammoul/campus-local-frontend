// ignore_for_file: file_names

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

