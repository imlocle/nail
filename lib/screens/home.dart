// import 'package:flutter/material.dart';
// import 'package:n_r_d/models/nailArt.dart';
// import 'package:n_r_d/sqlite/dbHelper.dart';

// class Home extends StatefulWidget {
// @override
//   MyFormState createState(){
//     return MyFormState();
//   }
// }

// class MyFormState extends State<Home> {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController brandNameTextController = TextEditingController();
//   TextEditingController colorNameTextController = TextEditingController();
//   TextEditingController dateNameTextController = TextEditingController();
//   TextEditingController nailTypeTextController = TextEditingController();
  
//   String brandName;
//   String colorName;
//   String nailType;
//   List<String> _nailTypes = <String>["","Base Coat", "Lacquer", "Ridge Filler", "Quick Top Dry", "Top Coat"];
//   String _nailType = '';

//   @override
//   Widget build(BuildContext context) {

//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: <Widget>[
//           Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 new TextFormField(
//                   controller: brandNameTextController,
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.business),
//                     labelText: "Brand Name"
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty){
//                       return 'Please enter the brand name';
//                     }
//                     else{
//                       brandName = value;
//                     }
//                     return null;
//                   },
//                 ),
//                 new TextFormField(
//                   controller: colorNameTextController,
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.color_lens),
//                     labelText: "Color Name"
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty){
//                       return 'Please enter the color name';
//                     }
//                     else {
//                       colorName = value;
//                     }
//                     return null;
//                   },
//                 ),
//                 new FormField(
//                   builder: (FormFieldState state) {
//                     return InputDecorator(
//                       decoration: const InputDecoration(
//                         icon: const Icon(Icons.create),
//                         labelText: "Nail Type",
//                       ),
//                       isEmpty: _nailType == '',                   
//                       child: new DropdownButtonHideUnderline(                   
//                         child: new DropdownButton(
//                           value: _nailType,
//                           isDense: true,
//                           onChanged: (String newValue){
//                             setState(() {
//                               _nailType = newValue;
//                               nailType = newValue;
//                              state.didChange(newValue);
//                             });
//                           },                       
//                           items: _nailTypes.map((String value){
//                             return new DropdownMenuItem(
//                               value: value,
//                               child: new Text(value)
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 new Container(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: RaisedButton(
//                     child: Text("Save"),
//                     onPressed: (){
//                       if (_formKey.currentState.validate()){
//                         _formKey.currentState.save();
//                         Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saving...'),));
//                         savingToSqlite(brandName, colorName, nailType);
//                         clearTextFields();
//                       }
//                     },
//                   ),
//                 )
//               ],
//             )
//           )
//         ]
//       )
//     );
//   }

//   clearTextFields(){
//     colorNameTextController.text = '';
//     brandNameTextController.text = '';
//   }

//   savingToSqlite(String brandName, String colorName, String nailType){
//     DBHelper helper = DBHelper();
//     NailArt nailArt = NailArt(null, brandName, colorName, nailType);
//     helper.insert(nailArt);
//   } 
// }
