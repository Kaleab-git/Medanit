import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class addPostPage extends StatefulWidget {
  const addPostPage({ Key? key }) : super(key: key);

  @override
  _addPostPageState createState() => _addPostPageState();
}

class _addPostPageState extends State<addPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        leading:
        TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child:Icon(    Icons.person  ),
          ),
        
        
        actions: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                  Icons.more_vert
              ),
            ),
            
        ],
      ),



      body:SingleChildScrollView(
        child: Container(
        child: Column(
          children: [
              
              Row(                                
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.person,size: 50),
                            Padding(
                              padding:EdgeInsets.only(left: 10),
                              child:(
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Text(
                                      'Segni A',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text("@segnigodson")
                                 ],
                                )
                              )
                            ),  
                          ],
                        ),
                      ), 
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only( left: 40, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20 , bottom: 10, ),
                          child: Text('Title', style: TextStyle(fontSize: 22),),
                        ),
                        Row(
                          children: <Widget>[
                            
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),

                              ),
                            ))
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 10),
                          child: Text('Description', style: TextStyle(fontSize: 22),),
                        ),
                        Row(
                          children: <Widget>[
                            
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 15,bottom: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    
                                    
                                  ),
                                  
                                ),
                                maxLines: 4,

                              ),
                            ))
                          ],
                        ),
                        Text('Side Effects' , style: TextStyle(fontSize: 22),),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('constipation.',style:TextStyle(fontSize: 20))
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Skin rash or dermatitis',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Diarrhea',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Dizziness',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Drowsiness',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Dry mouth',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Headache',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),
                               Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 8),
                                    child: RoundCheckBox(
                                      onTap: (selected) {},
                                    ),
                                  ),
                                  Text('Insomnia',style:TextStyle(fontSize: 20),)
                                  
                                ],
                              ),

                            ],
                          ),
                        ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(bottom: 8.0, top: 10 ,right: 20),
                                 child: ElevatedButton(
   
                                  onPressed: () {}, 
                                  child: 
                                  Text('Post')),
                               ),
                             ],
                           )
                      ],
                    ),
                  )    
          ],
        ),
      ),
      ),  
       
      
      bottomNavigationBar:BottomNavigationBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'add'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications'
          ),
    ],
  ),
        
      
     
    );
  }
}