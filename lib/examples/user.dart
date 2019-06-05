class User {
  String firstName;
  String lastName;
  String location;
  
  User({this.firstName, this.lastName , this.location});
 
  static List<User> getUsers() {
    return <User>[
      User(firstName: "Aaryan", lastName: "Shah",location: "bhopal"),
      User(firstName: "Ben", lastName: "John",location: "bhopal"),
      User(firstName: "Carrie", lastName: "Brown",location: "bhopal"),
      User(firstName: "Deep", lastName: "Sen",location: "bhopal"),
      User(firstName: "Emily", lastName: "Jane",location: "bhopal"),
    ];
  }
}
