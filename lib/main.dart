import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{

  List<Step> _steps;
  int _current;
  TextEditingController _name;
  TextEditingController _email;
  String _nameDisplay;
  String _emailDisplay;


  @override
  void initState() {
    super.initState();
    _current = 0;
    _name = new TextEditingController();
    _email = new TextEditingController();

  }

  void _stepContinue(){
    setState(() {
      _current++;
      if(_current >= _steps.length) _current = _steps.length - 1;
      if(_current == 2) {
        _nameDisplay = _name.text;
        _emailDisplay = _email.text;
      }
    });
  }

  void _stepCancel(){
    setState(() {
      _current--;
      if(_current < 0) _current = 0;
    });
  }

  void _stepTab(int index){
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Asistente de configuración"),
        backgroundColor: Colors.green,

      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: Center(
            child: new Stepper(
              steps: _steps = <Step>[
                new Step(
                    title: new Text('Paso 01: Datos personales'),
                    content: new Column(
                      children: <Widget>[
                        new TextField(
                          controller: _name,
                          decoration: new InputDecoration(
                              labelText: 'Ingresa tu Nombre',
                              hintText: "Nombre",
                              icon: new Icon(Icons.account_circle)
                          ),
                        )
                      ],
                    ),

                    isActive: true,
                ),
                new Step(
                    title: new Text('Paso 02: Datos empresariales'),
                    content: new Column(
                        children:<Widget>[
                          new TextField(
                            controller: _email,
                            decoration: new InputDecoration(
                                labelText: "Ingresa tu correo",
                                hintText: "Correo",
                                icon: new Icon(Icons.email)
                            ),
                          )
                        ]
                    ),
                    isActive: true
                ),
                new Step(
                    title: new Text('Paso final: Resultados'),
                    content: new Column(
                      children: <Widget>[

                        new Text('${_nameDisplay}'),

                        new Text('${_emailDisplay}')
                      ],
                    ),
                    isActive: true
                ),
              ],
              type: StepperType.vertical,
              currentStep: _current,
              onStepCancel: _stepCancel,
              onStepContinue: _stepContinue,
              onStepTapped: _stepTab,
            )
        ),
      ),
    );
  }
}