import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _controllerDate = TextEditingController();
  var estadoTextField = '';

  static List<String> linguagens = [
    'Dart',
    'Kotlin',
    'Java',
    'PHP',
    'Java Script',
    'Python'
  ];

  String? _linguagemSelecionada = linguagens.first;
  List<String> _linguagensSelecionadas = [];
  bool _estadoSwitch = false;
  double _valorSlider = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Playground'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TODO: Coletando Texto
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'E-mail',
                  helperText: 'E-mail pessoal para contato',
                  hintText: 'Não esqueça do seu email, aqui!'),
            ),
            SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  estadoTextField = _controller.text;
                });
                print(estadoTextField);
              },
              child: Text('SALVAR'),
            ),
            SizedBox(height: 32),
            Text(estadoTextField),

            //TODO: Coletando valor unico
            DropdownButton(
                value: _linguagemSelecionada,
                isExpanded: true,
                items: linguagens
                    .map((l) => DropdownMenuItem(
                          value: l,
                          child: Text(l),
                        ))
                    .toList(),
                onChanged: ((value) {
                  setState(() {
                    _linguagemSelecionada = value;
                  });
                })),

            Column(
              children: linguagens
                  .map((l) => ListTile(
                        leading: Radio<String>(
                          value: l,
                          groupValue: _linguagemSelecionada,
                          onChanged: (value) {
                            setState(() {
                              _linguagemSelecionada = value;
                            });
                          },
                        ),
                        title: Text(l),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Linguagem seleciona: $_linguagemSelecionada'),
            ),
            //TODO: Coletando multiplos valores
            Column(
              children: linguagens
                  .map((l) => Row(
                        children: [
                          Checkbox(
                            value: _linguagensSelecionadas.contains(l),
                            onChanged: ((selected) {
                              setState(() {
                                if (selected!) {
                                  _linguagensSelecionadas.add(l);
                                } else {
                                  _linguagensSelecionadas.remove(l);
                                }
                              });
                            }),
                          ),
                          Expanded(child: Text(l)),
                        ],
                      ))
                  .toList(),
            ),
            Text(_linguagensSelecionadas.join(', ')),

            //TODO: Habilitando valor [On/Off]
            Row(
              children: [
                Switch(
                    value: _estadoSwitch,
                    onChanged: ((value) {
                      print('Switch: $_estadoSwitch');
                      setState(() {
                        _estadoSwitch = value;
                      });
                    })),
                Text('Modo Developer'),
              ],
            ),

            //TODO: Coletanto um range de valores
            Row(
              children: [
                Slider(
                  divisions: 10,
                  min: 0,
                  max: 100,
                  value: _valorSlider,
                  onChanged: ((value) {
                    setState(() {
                      _valorSlider = value;
                    });
                  }),
                ),
                Expanded(child: Text('${_valorSlider.toStringAsFixed(2)}')),
              ],
            ),

            //TODO: Utilizando ChoiceChips e FilterChips
            Wrap(
              spacing: 5,
              children: linguagens
                  .map((l) => ChoiceChip(
                        selectedColor: Colors.green.shade300,
                        label: Text(l),
                        selected: _linguagemSelecionada == l,
                        onSelected: ((value) {
                          setState(() {
                            _linguagemSelecionada = value ? l : null;
                          });
                        }),
                      ))
                  .toList(),
            ),

            Wrap(
              runSpacing: 5,
              spacing: 5,
              children: linguagens
                  .map((l) => FilterChip(
                      selectedColor: Colors.green.shade500,
                      label: Text(l),
                      selected: _linguagensSelecionadas.contains(l),
                      onSelected: ((inSelected) {
                        setState(() {
                          if (inSelected) {
                            _linguagensSelecionadas.add(l);
                          } else {
                            _linguagensSelecionadas.remove(l);
                          }
                        });
                      })))
                  .toList(),
            ),

            // Selecionado Data e Hora
            TextField(
              controller: _controllerDate,
              decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: 'Data conclusão de curso',
                  suffix: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 60)),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          _selectedDate = selectedDate;
                          _controllerDate.text = selectedDate.toIso8601String();
                        }
                      });
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
