import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:flutter/material.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);
  
  @override
  State<NewReport> createState() => NReport_Form();
  
}

class NReport_Form extends State<NewReport> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Report()),
           );
        }),
        title: const Text('Nuevo Reporte'),
        
        backgroundColor: Color.fromARGB(255, 48, 105, 219),
      ),

     body: Column(children: [
      Image.network("https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Freport-vector-icon_3756940.html&psig=AOvVaw2tsfRsgpIb0CNXvOqf_t9m&ust=1666208691737000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCODz-6LF6voCFQAAAAAdAAAAABAD", height: 300,width: 300,),
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

       child: TextFormField(
        initialValue: 'nombre de la empresa, ej: aires',
        decoration: const InputDecoration(
          labelText: 'Empresa',
          
          border: OutlineInputBorder(),
          suffixIcon: Icon(
            Icons.business,
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

            child: TextFormField(
              initialValue: '00/00/00',
              decoration: const InputDecoration(
                labelText: 'Fecha actual',
              
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.date_range,
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
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 107, 238)),
          ),
        ),
      ),
    ),

     ],)
      

    );
  }

}