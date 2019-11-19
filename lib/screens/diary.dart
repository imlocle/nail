import 'package:flutter/material.dart';
import 'package:n_r_d/models/nailArt.dart';
import 'package:n_r_d/sqlite/dbHelper.dart';
import 'package:n_r_d/services/service.dart';

class MyAppState extends StatefulWidget {
  @override
  Diary createState() => new Diary();
}

class Diary extends State<MyAppState> {
  final _formKey = GlobalKey<FormState>();

  DBHelper helper = DBHelper();
  List<NailArt> nailArts;
  int count = 0;

  TextEditingController brandNameTextController = TextEditingController();
  TextEditingController colorNameTextController = TextEditingController();
  TextEditingController dateNameTextController = TextEditingController();
  
  String brandName;
  String colorName;
  String nailType;
  List<String> _nailTypes = <String>["","Base Coat", "Lacquer", "Ridge Filler", "Quick Top Dry", "Top Coat"];
  String _nailType = '';

  @override
  Widget build(BuildContext context) {
    if (nailArts == null){
      nailArts = List<NailArt>();
      getData();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Nail Art Diary"),),
      body: nailArtListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           showDialog(
              context: context,
              builder: (ctxt) => new AlertDialog(
                content: Form(
                  key: _formKey,
                  // childs are the form popup for adding nail art
                  child: Column(children: <Widget>[
                    new TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: brandNameTextController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.business),
                        labelText: "Brand Name"
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the brand name';
                        }
                        else {
                          brandName = value;
                        }
                        return null;
                      },
                    ),
                    new TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: colorNameTextController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.color_lens),
                        labelText: "Color Name"
                      ),
                      validator: (value) {
                        if (value.isEmpty){
                          return 'Please enter the color name';
                        }
                        else {
                          colorName = value;
                        }
                        return null;
                      },
                    ),
                    new FormField(                     
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.create),
                            labelText: "Nail Type"
                          ),
                          isEmpty: _nailType == '',                         
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              value: _nailType,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState((){
                                  _nailType = newValue;
                                  nailType = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _nailTypes.map((String value) {
                                return new DropdownMenuItem(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    new Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: (){
                          if (_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            savingToSqlite(brandName, colorName, nailType);
                            clearTextFields();                           
                            Navigator.pop(context);
                          }
                          setState(() {
                           getData(); 
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  clearTextFields(){
    colorNameTextController.text = '';
    brandNameTextController.text = '';
  }

  ListView nailArtListItems() {
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.brush),
              title: Text(this.nailArts[position].brandName),
              subtitle: Text("Color: "+this.nailArts[position].colorName
                          +"\nNail Type: "+this.nailArts[position].nailType.toString()),
              onTap: (){
                debugPrint("Tapped on "+ this.nailArts[position].id.toString());
              },
              onLongPress: (){
                showDialog(
                  context: context,
                  builder: (ctxt) => new AlertDialog(
                    title: new Text('Remove?'),
                    content: new Text('This will permanently remove this nail art from your diary'),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('No'),
                        onPressed: () {
                          Navigator.pop(ctxt);
                        },
                      ),
                      new FlatButton(
                        child: new Text('Yes'),
                        onPressed: () {
                          removeNailArt(this.nailArts[position].id);
                          Navigator.pop(ctxt);
                          setState(() {
                           getData(); 
                          });
                        },
                      )
                    ],
                  )
                );
              },
            ),
          );
        },
    );
  }

  void getData() {
    final dbFuture = helper.initDb();
    dbFuture.then((result){
      final nailArtFuture = helper.getNailArts();
      nailArtFuture.then((result){
        List<NailArt> nailArtList = List<NailArt>();
        count = result.length;
        for (int i=0; i<count; i++) {
          nailArtList.add(NailArt.fromObject(result[i]));
          nailArtList.sort((a,b) => a.brandName.toLowerCase().compareTo(b.brandName.toLowerCase()));
        }
        setState(() {
          nailArts = nailArtList;
          count = count;
        });
      });
    });
  }
}