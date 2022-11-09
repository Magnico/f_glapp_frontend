import 'package:f_shopping_app/ui/Widgets/datetime.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_form_field/select_form_field.dart';

class NewReport extends StatefulWidget {
  NewReport({Key? key}) : super(key: key);

  @override
  State<NewReport> createState() => NReport_Form();
}

class NReport_Form extends State<NewReport> {
  final List<Map<String, dynamic>> _empresas = [
    {
      'value': 'gas',
      'label': 'Gases del Caribe',
      'icon': const Icon(Icons.gas_meter)
    },
    {'value': 'luz', 'label': 'Air-E', 'icon': const Icon(Icons.lightbulb)},
    {'value': 'agua', 'label': 'Triple A', 'icon': const Icon(Icons.water_drop)}
  ];
  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo reporte"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Report()),
                );
              }),
          backgroundColor: const Color.fromARGB(255, 47, 91, 223),
        ),
        body: ListView(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.description,
                size: 150,
                color: Colors.white,
              ),
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 82, 122, 255),
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              //Debería ser un selector de la empresa
              child: SelectFormField(
                type: SelectFormFieldType.dropdown,
                initialValue: 'gas',
                icon: const Icon(Icons.question_mark),
                labelText: 'Empresa',
                items: _empresas,
                onChanged: (value) => print(value),
                onSaved: (value) => print(value),
              ),
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 82, 122, 255),
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: BasicDateTimeField("Fecha de reporte"),
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 82, 122, 255),
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              // Esto lo hago yo (Enrique)
              //Aqui se debe cambiar por la opcion de elegir la ubicación
              //Entre la ubicaion actual dada por las coordenadas
              //o indicar la ubicación a travez de la direccion como en la pagina principal
              //tipo de daño
              child: TextFormField(
                initialValue: 'Ej: Cra 51b calle 96',
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.edit_location_rounded,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 82, 122, 255),
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              //Se deben ampliar las opciones para describir el reporte
              //Por un lado se debe poder escoger el tipo de problema de una lista
              //Se debe de poder dar una descripción por parte del usuario
              //Se debe de poder adjuntar imagenes de estos problemas como prueba
              //titulo
              //descripción
              //imagen
              child: TextFormField(
                initialValue: 'escribir',
                maxLength: 100,
                decoration: const InputDecoration(
                  icon: Icon(Icons.note_add),
                  labelText: 'REPORTE',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  helperText: 'Escribe tu reporte',
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 107, 238)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
