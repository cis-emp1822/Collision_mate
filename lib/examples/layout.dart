import 'dart:html' as html ;
import 'package:flutter_web/material.dart';
//import 'package:flutter_web_ui/ui.dart' as prefix ;
import '../plugin/responsive_scaffold.dart';
import 'package:key_value_store_web/key_value_store_web.dart';
import 'user.dart';
class LayoutExample extends StatefulWidget {
@override
LayoutExampleState createState() => new LayoutExampleState();
}


class LayoutExampleState extends State<LayoutExample>{
  final kvs = WebKeyValueStore(html.window.localStorage);
   final List<String > listName = ["Traction Control","Invite","App Rating","Subscription","Profile","SubVendor","Terms and Condition","Logout"] ;
 final List<IconData > listIcon =[ Icons.apps,Icons.verified_user, Icons.comment ,Icons.notifications, Icons.people,Icons.apps , Icons.apps, Icons.all_out ];
 final _saved = new Set<int>();
  int _selectedIndex = 0;
  int count = -1 ;
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
      body: _selectedIndex==5?newColumn():
      Center(
        child:_selectedIndex==3?ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int index) {
              final alreadySaved = _saved.contains(index);
            return ListTile(
              leading: Icon( Icons.cloud_circle ),
               title: Text( index.toString()),
               subtitle: Text(kvs.getStringList(index.toString()).toString()),
               trailing: RaisedButton( 
               onPressed:() => {
                 setState(() {
          if (alreadySaved) {
            _saved.remove(index );
          } else {
            _saved.add(index);
          }}) },
          color: alreadySaved?Colors.red:Colors.white,
          textColor: Colors.black,
          child: alreadySaved?Text("Subscribed"):Text("Subscribe"),
            ),);
           }
          ) :null,
      ),
      floatingActionButton:// MediaQuery.of(context).size.width < 720?
      FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () { print("${++count} ");
        List<String> details = ["Half Yearly1",	"6 month plans",	"180",	"399",	"2018-11-27", "16:16:22"];
        kvs.setStringList(count.toString(),details );
        setState(() {
          
        });
        },
      
      ),//:null,
    );
  }
  List<User> users;
  List<User> selectedUsers;
  bool sort;
 
  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = User.getUsers();
    super.initState();
  }
 
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
  }
 
  onSelectedRow(bool selected, User user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }
 
  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<User> temp = [];
        temp.addAll(selectedUsers);
        for (User user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }
 
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("FIRST NAME"),
              numeric: false,
              tooltip: "This is First Name",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("LAST NAME"),
            numeric: false,
            tooltip: "This is Last Name",
          ),
           DataColumn(
            label: Text("Location"),
            numeric: false,
            tooltip: "This is Location",
          ),
           
        ],
        rows: users
            .map(
              (user) => DataRow(
                      selected: selectedUsers.contains(user),
                      onSelectChanged: (b) {
                        print("Onselect");
                        onSelectedRow(b, user);
                      },
                      cells: [
                        DataCell(
                          Text(user.firstName),
                          onTap: () {
                            print('Selected ${user.firstName}');
                          },
                        ),
                        DataCell(
                          Text(user.lastName),
                        ),
                         DataCell(
                          Text(user.location),
                        )
                      ]),
            )
            .toList(),
      ),
    );
  }
  Column newColumn(){
    return 
    Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('SELECTED ${selectedUsers.length}'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),
        ],
      );
  }
}
