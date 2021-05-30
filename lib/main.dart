
import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

void main() => runApp(new RestaurantApp());

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion Restaurante',//promedio de notas de 4 numeros
      home: Restaurant(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Restaurant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuOffice();
}

class MenuOffice extends State<Restaurant> {  
  // ignore: non_constant_identifier_names
  //final controller_nombres=TextEditingController();
  //final controller_pedido=TextEditingController();
  final controller_precio=TextEditingController();
  
  final controller_cantidad=TextEditingController();
  final my_form_key=GlobalKey<FormState>();
  final d=Decimal;
 
  bool isSwitched=false;
  bool delivery= false;

  String muestreTotalPrecio="";
  String muestreDescuento="";
  String muestreTotalPago="";

  //Sacar el promedio
  void CalculoTotalPrecio(){
    
    int decimals = 2; // solo muestra 2 numeros decimales

    double format = pow(10, decimals); //formula mayor a 10 decimales
    
    //usamos la validacion  de my_form_key si es que el campo esta vacio
    if(my_form_key.currentState.validate()){
      // ignore: unused_local_variable
    //  String nombres=controller_nombres.text;
      // ignore: unused_local_variable
      //String pedido=controller_pedido.text;
      var precio=double.parse(controller_precio.text);
      var cantidad=int.parse(controller_cantidad.text);
      

      double totalPrecio=(precio*cantidad);
      
      double totalPago=0;
       double descuento= 0;

      if(totalPrecio>500){
        descuento=totalPrecio*(5/100);
        if(delivery==false){
          totalPago=totalPrecio-descuento;
        }
        else{
          totalPago=(totalPrecio+20)-descuento;
        }
      }else{
        descuento=0;
        if(delivery==false){
          totalPago=totalPrecio;
        }
        else{
          totalPago=totalPrecio+20;
        }
      }

     
    

      setState(() {
        muestreTotalPrecio="Total: $totalPrecio";
        muestreDescuento="Descuento: $descuento ";
        muestreTotalPago="Total a Pagar: $totalPago";
      });
    }

  }


  //en esta parte se realiza el diseño de la app o el layaout
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      //child,child
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:Text('Office Food') ,
        backgroundColor:Colors.orange.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
      ),
      //body
      body: Form(
        key: my_form_key,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:<Widget>[
              
              //se pueden colocar tantos container como deseemos
              //agregamos los textfield para el input de los datos
              Container(
                padding: EdgeInsets.only(top:40),
                child: Column(
                  children:<Widget> [
                    Container(
                      width:400,
                      height:50,
                      padding:EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black,blurRadius: 5)
                        ]),
                        child: TextFormField(
                           validator: (value){
                            if(value.isEmpty) return "Nombre es necesario";
                          },
                         // controller: controller_nombres,
                          decoration: InputDecoration(
                            hintText: "Nombre",
                            icon: Icon(Icons.account_circle_outlined,
                            color: Colors.black)
                          ),
                          //invoca teclado alfanumerico al darle click a la caja
                        ),
                    ),
                    Divider(height: 30),

                     Container(
                      width:400,
                      height:50,
                      padding:EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black,blurRadius: 5)
                        ]),
                        child: TextFormField(
                           validator: (value){
                            if(value.isEmpty) return "Pedido es necesario";
                          },
                          //controller: controller_pedido,
                          decoration: InputDecoration(
                            hintText: "Pedido",
                            icon: Icon(Icons.account_circle_outlined,
                            color: Colors.black)
                          ),
                          //invoca teclado alfanumerico al darle click a la caja
                        ),
                    ),
                    Divider(height: 30,),
                    
                     Container(
                      width:400,
                      height:50,
                      padding:EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black,blurRadius: 5)
                        ]),
                        child: TextFormField(
                          controller: controller_precio,
                          validator: (value){
                            if(value.isEmpty) return "Precio es necesario";
                          },
                          decoration: InputDecoration(
                            hintText: "Precio",
                            icon: Icon(Icons.account_circle_outlined,
                            color: Colors.black)
                          ),
                          //invoca teclado alfanumerico al darle click a la caja
                          keyboardType: TextInputType.number,
                        ),
                    ),
                    Divider(height: 30,),

                     Container(
                      width:400,
                      height:50,
                      padding:EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black,blurRadius: 5)
                        ]),
                        child: TextFormField(
                          controller: controller_cantidad,
                          // ignore: missing_return
                          validator: (value){
                            if(value.isEmpty) return "Cantidad es necesaria";
                          },
                          decoration: InputDecoration(
                            hintText: "Cantidad",
                            icon: Icon(Icons.account_circle_outlined,
                            color: Colors.black)
                          ),
                          //invoca teclado alfanumerico al darle click a la caja
                         
                        ),
                    ),

                  Divider(height: 35,), 
                  Center(
                    child: Switch(
                  value: delivery,
                  onChanged: (value) {
                  setState(() {
                  delivery = value;
                
                  print(delivery);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          )
                  ),
                  


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                      FlatButton(
                        onPressed: CalculoTotalPrecio,
                        shape: new RoundedRectangleBorder(
                          borderRadius:new BorderRadius.circular(30.0)),
                          color: Colors.orange,
                          padding: EdgeInsets.only(bottom: 20,left: 60,right: 60,top: 20),
                          height: 50,
                          child: Column(
                            children: <Widget>[Icon(Icons.calculate),Text('Operaciones')],
                          ),
                      )
                    ],
                  ),
                  Divider(height: 5),
                  //la caja donde se imprimira el resultado
                  Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade500,Colors.lightGreenAccent]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  //creamos el llamado al resultado para el textformfield
                    child: Center(
                      child: Text(
                        muestreTotalPrecio +"\n "+muestreDescuento +"\n"+muestreTotalPago,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 15.0)
                  
                  ],
                ),
              )
            ],
          ),
        )
      ),


      );
  }
}