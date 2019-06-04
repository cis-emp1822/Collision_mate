import 'package:flutter_web/material.dart';
import '../plugin/responsive_scaffold.dart';

class LayoutExample extends StatefulWidget {
@override
LayoutExampleState createState() => new LayoutExampleState();
}


class LayoutExampleState extends State<LayoutExample>{
   final List<String > listName = ["Traction Control","Invite","App Rating","Subscription","Profile","SubVendor","Terms and Condition","Logout"] ;
 final List<IconData > listIcon =[ Icons.apps,Icons.verified_user, Icons.comment ,Icons.notifications, Icons.people,Icons.apps , Icons.apps, Icons.all_out ];
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      
      title: Text('Subscriptions', style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold)),
     
      drawer: Container(
        color:Colors.black,
         child: new ListView(
          children: <Widget>[
           new Column( 
             children: <Widget>[ 
              Container(
              child:Image.asset('collision.png'), 
              padding: const EdgeInsets.all(6.0),
  decoration: new BoxDecoration( 
                    border: new Border.all(color: Colors.blueAccent) ,
                    color: Colors.white ),
           ),
           ],
                    ),
            new Container (
            
              child:  ListView.builder(
                shrinkWrap: true,
                  itemCount: 8 ,
                  itemBuilder: (context, index) => Container(
              color: _selectedIndex != null && _selectedIndex == index
                  ? Colors.red
                  : Colors.black87,
              child: ListTile(
                    leading:  Icon(listIcon[index] , color: Colors.white,),
                    title: Text(listName[index] , 
                    style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => _onSelected(index),
              )
              ,
                  ),
                ),
              
            ),
          ],
        ) ,
      ),
      endIcon: Icons.filter_list,
      endDrawer: Container(
        color: Colors.white54 ,
         child:ListView(
    
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Filter List'),
            subtitle: Text('Hide and show items'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.image_aspect_ratio),
            title: Text('Size Settings'
            ),
            subtitle: Text('Change size of images'),
          ),
          ListTile(
            title: Slider(
              value: 0.5,
              onChanged: (val) { },
            ),
          ),
          ListTile(
            leading: Icon(Icons.sort_by_alpha),
            title: Text('Sort List'),
            subtitle: Text('Change layout behavior'),
            trailing: Switch(
              value: false,
              onChanged: (val) {},
            ),
          ),
        ],
      ),) ,
      trailing: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      body: Center(
        child:_selectedIndex==3? ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(

            title: Text('row $index'),
          );
        },
      ):null,
      ),
      floatingActionButton: MediaQuery.of(context).size.width < 720?FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      
      ):null,
    );
  }
}
