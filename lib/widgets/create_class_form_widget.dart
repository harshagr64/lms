import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class CreateClassFormWidget extends StatefulWidget {
  @override
  _CreateClassFormWidgetState createState() => _CreateClassFormWidgetState();
}

class _CreateClassFormWidgetState extends State<CreateClassFormWidget> {
  String _value;
  final _formKey = GlobalKey<FormState>();
  final _titleNode = FocusNode();
  final _secNode = FocusNode();
  final _subNode = FocusNode();
  final _semNode = FocusNode();

  Map<String, Object> _classData = {
    'title': null,
    'sem': null,
    'section': null,
    'subCode': null,
  };

  void _saveForm() async{
    final _isValid = _formKey.currentState.validate();

    if (!_isValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    _formKey.currentState.save();

    FirebaseFirestore _cloudInstance = FirebaseFirestore.instance;
    User user = FirebaseAuth.instance.currentUser;

    final time = DateTime.now();
    // print(user.uid.substring(0,6));
    await _cloudInstance
        .collection('newclasses')
        .doc(user.uid)
        .collection('totalclasses')
        .doc('${user.uid.substring(0,6)}$time')
        .set(_classData);

    print(_classData['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Create Class",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            focusNode: _titleNode,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_semNode),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Class Title';
              }

              return null;
            },
            onSaved: (value) {
              _classData['title'] = value;
            },
            decoration: InputDecoration(
              hintText: 'Class Title*',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            focusNode: _semNode,
            value: _value,
            onSaved: (value) {
              _classData['sem'] = value;
            },
            validator: (value) {
              if (value == null) {
                return "Please Select SEM";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            ),
            hint: Text('SEM*'),
            items: [
              DropdownMenuItem(
                child: Text('1'),
                value: 1.toString(),
              ),
              DropdownMenuItem(
                child: Text('2'),
                value: 2.toString(),
              ),
              DropdownMenuItem(
                child: Text('3'),
                value: 3.toString(),
              ),
              DropdownMenuItem(
                child: Text('4'),
                value: 4.toString(),
              ),
              DropdownMenuItem(
                child: Text('5'),
                value: 5.toString(),
              ),
              DropdownMenuItem(
                child: Text('6'),
                value: 6.toString(),
              ),
              DropdownMenuItem(
                child: Text('7'),
                value: 7.toString(),
              ),
              DropdownMenuItem(
                child: Text('8'),
                value: 8.toString(),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            focusNode: _secNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_subNode),
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            onSaved: (value) {
              _classData['section'] = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Section';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Section*',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            focusNode: _subNode,
            cursorColor: Colors.black,
            onSaved: (value) {
              _classData['subCode'] = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Subject Code';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Subject Code*',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            onPressed: _saveForm,
            padding: EdgeInsets.all(15),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: Text("Create",
                style: TextStyle(
                    fontSize: 18, color: Colors.white, letterSpacing: 1)),
          )
        ],
      ),
    );
  }
}
