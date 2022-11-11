import 'dart:async';
import 'dart:developer';

import 'package:f_shopping_app/ui/Widgets/datetime.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/controller/providerController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../domain/user.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);

  @override
  State<NewReport> createState() => NReport_Form();
}

class NReport_Form extends State<NewReport> with SingleTickerProviderStateMixin{
  final Color iconColor = Colors.black;

  final ProviderController providers = Get.find<ProviderController>();
  ReportController con = Get.find<ReportController>();
  UserController user = Get.find<UserController>();

  //REQUISITOS PARA EL AUTOCOMPLETADO DE LA LOCACIÓN
  late GooglePlace _googlePlace;
  List<AutocompletePrediction> _places = [];
  final searchTextController = TextEditingController();
  Timer? _debounce;
  DetailsResult? _placeDetails;
  late FocusNode _searchFocusNode;

  //DATOS DEL REPORTE
  String _locationSelected = "actual";
  LatLng desireLocation = const LatLng(0, 0);
  String _empresaSelected = '0';
  String? title;
  TextEditingController desc = TextEditingController();

  DateTime date = DateTime.now();
  bool _isEnterprise = false;

  void updateDate(DateTime fecha) {
    log(fecha.toString());
    date = fecha;
  }

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyB9NLDNfBdWb-PPUa9e-q6FzTP8xrranAI';
    _googlePlace = GooglePlace(apiKey);

    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _isEnterprise = user.rol == 0;
    if(_isEnterprise) _empresaSelected = user.id;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo reporte"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportPage()),
                );
              }),
          backgroundColor: const Color.fromARGB(255, 47, 91, 223),
        ),
        body: ListView(
          children: [
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.document_scanner_rounded,
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
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: TextFormField(
                onChanged: (value) => title = value,
                initialValue: '',
                maxLength: 100,
                decoration: InputDecoration(
                  icon: Icon(Icons.title_rounded, color: iconColor),
                  labelText: 'Titulo del Reporte',
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
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: TextField(
                controller: desc,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.description_rounded,
                    color: iconColor,
                  ),
                  labelText: 'Descripción',
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
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              //Debería ser un selector de la empresa
              child: Visibility(
                visible: _isEnterprise == false,
                child: Obx(() {
                  return Row(
                      children: [
                        Icon(
                          Icons.business_rounded,
                          color: iconColor,
                        ),
                        SizedBox(width: 20,),
                        DropdownButton(
                          hint: const Text('Seleccione una empresa'),
                          items: providers.providersList
                              .map((e) => DropdownMenuItem(
                                  child: Text(e.label), value: e.value))
                              .toList(),
                          value: providers
                              .providersList[int.parse(_empresaSelected)].value,
                          onChanged: (value) {
                            setState(() {
                              _empresaSelected = value.toString();
                            });
                          },
                        ),
                      ],
                    );
                }),
              ),
            ),
            const Divider(
              height: 24.0,
            ),
            Visibility(
              visible: _isEnterprise,
              child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: BasicDateTimeField("Fecha de reporte", this),
            )
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: Column(children: [
                Row(children: [
                  Icon(
                    Icons.my_location_rounded,
                    color: iconColor,
                  ),
                  const Text("Ubicación")
                ]),
                RadioListTile(
                    value: "actual",
                    groupValue: _locationSelected,
                    onChanged: (value) {
                      setState(() {
                        _locationSelected = "actual";
                      });
                    },
                    title: const Text("Ubicación actual")),
                RadioListTile(
                    value: "direccion",
                    groupValue: _locationSelected,
                    onChanged: (value) {
                      setState(() {
                        _locationSelected = "direccion";
                      });
                    },
                    title: const Text("Especificar dirección")),
              ]),
            ),
            Visibility(
              visible: _locationSelected == "direccion",
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  focusNode: _searchFocusNode,
                  controller: searchTextController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese su ubicación',
                    hintStyle: TextStyle(color: Color.fromARGB(255, 14, 11, 11)),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                  onChanged: (value) {
                    log("cambie");
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      if (value.isNotEmpty) {
                        autocompleteSearch(value);
                      } else {
                        setState(() {
                          _places = [];
                        });
                      }
                    });
                  },
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(_places[index].description!.toString()),
                      onTap: () async {
                        final placeId = _places[index].placeId;
                        final details =
                            await _googlePlace.details.get(placeId!);
                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (_searchFocusNode.hasFocus) {
                            setState(() {
                              _placeDetails = details.result;
                              searchTextController.text = _placeDetails!.name!;
                              //usar placeDetails para obtener la ubicación
                              desireLocation = LatLng(
                                  _placeDetails!.geometry!.location!.lat!,
                                  _placeDetails!.geometry!.location!.lng!);
                              _places = [];
                              _searchFocusNode.unfocus();
                            });
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const Divider(
              height: 24.0,
            ),
            Container(
              padding: const EdgeInsets.only(right: 10.0),
              margin: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 50),
              child: ElevatedButton(
                child: const Text("Save",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  if (title != null &&
                      title!.isNotEmpty &&
                      desc.text.isNotEmpty) {
                    if (_locationSelected == "actual") {
                      desireLocation = con.currentLocation;
                    }

                    String provider =
                        providers.providers[int.parse(_empresaSelected)].id;
                    con.addReport(
                        provider, title!, desireLocation, desc.text, date);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Complete todos los campos'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }

  autocompleteSearch(String value) async {
    var result = await _googlePlace.autocomplete.get(value);
    //imprimir en el debug el primer elemento de result
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        _places = result.predictions!;
      });
    }
  }
}
