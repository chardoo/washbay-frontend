import 'package:flutter/material.dart';
import 'package:bayfrontend/components/custom/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:bayfrontend/model/ServiceType.dart';
import 'package:bayfrontend/components/serviceType/EditServiceType.dart';

// ignore: must_be_immutable
class DetailsServiceType extends StatelessWidget {
  ServiceTypeModel serviceTypeModel = ServiceTypeModel("", "", 0);

  DetailsServiceType({Key? key, required this.serviceTypeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: serviceTypeModel.name);
    TextEditingController priceController =
        TextEditingController(text: serviceTypeModel.price.toString());

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 10, 10, 7),
            elevation: 0.0,
            title: const Text('Edit Service Type')),
         body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 18,vertical:32),
          child: Column(
            children: [
              Container(
                height:50,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 219, 217, 216),
                child: Center(child: Text('Details',style: TextStyle(color: Color(0xffFFFFFF)),)),
              ),
              Container(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 18,vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Row(children: [Text("Name :"), Text(serviceTypeModel.name) ],),
                      
                      const SizedBox(height: 10,),
                      Row(children: [Text("Price :"),  Text('${serviceTypeModel.price}'), ],)
                     
                      
                      
                    ],
                  ),
                ),
                // height: 455 ,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                   color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0,1),

                    ),
                  ]
                ),
                
              ),
              Row(
                children:[
                  TextButton(
                    onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>EditServiceType(serviceTypeModel: serviceTypeModel,)));
                     
                    }, child:Text('Edit'),
                  ),
                  TextButton( 
                    style: ButtonStyle(),
                    onPressed:(){
                   

                    }, child:Text('Delete'),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
        );  
        
        }
}
