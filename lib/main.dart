import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'examples/index.dart';

/// main is entry point of Flutter application
void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(accentColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double horizontal =
            MediaQuery.of(context).size.width<720? 
            MediaQuery.of(context).size.width*0.15 :
            MediaQuery.of(context).size.width<1440?
            MediaQuery.of(context).size.width*0.34:
            MediaQuery.of(context).size.width*0.38;
  
    return Scaffold(
      appBar: null ,
      body:Container(
         padding: new EdgeInsets.all(25.0),
        child: Center(
          child: Padding(
            padding:EdgeInsets.fromLTRB(horizontal, 10.0, horizontal, 10.0)
             ,
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              Image.asset('collision.png'),
               Padding(padding: EdgeInsets.only(bottom: 40.0)),
              TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
         ),
          
      ),
      validator: (val) {
                        if(val.length==0) {
                          return "Email cannot be empty";
                        }else{
                          return null;
                        }
                      },

                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
      ),
       Padding(padding: EdgeInsets.only(bottom: 40.0)),
      TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(16),),
      ),
    ),Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _goToScreen(context, LayoutExample());
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    ), FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    ),
            ],
          ),
          ),
        ),
      )
    );
  }

  void _goToScreen(BuildContext context, Widget child) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => child, fullscreenDialog: true),
      );
}
