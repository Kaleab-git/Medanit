import 'package:flutter/material.dart';


class addCommentPage extends StatefulWidget {
  const addCommentPage({ Key? key }) : super(key: key);

  @override
  _addCommentPageState createState() => _addCommentPageState();
}

class _addCommentPageState extends State<addCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        
        actions: [
          IconButton(
            icon: Icon(Icons.local_pharmacy_sharp),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
      ),



      body:Container(
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


                  Row(
                    children: [
                      Padding(
                              padding: const EdgeInsets.only(left: 15 ,top: 8, bottom: 10),
                              child: Text('Add your comment', style: TextStyle(fontSize: 15),textAlign: (TextAlign.start)),
                            ),
                    ],
                  ),
                  Row(
                          children: <Widget>[
                            
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 15,bottom: 10 ,right: 25),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    
                                    
                                  ),
                                  
                                ),
                                maxLines: 5,

                              ),
                            ))
                          ],
                        ),

                      Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(bottom: 8.0, top: 10 ,right: 30),
                                 child: ElevatedButton(
   
                                  onPressed: () {}, 
                                  child: 
                                  Text('Post')),
                               ),
                             ],
                           )
      
          ],
      
      ), ),
       
      
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