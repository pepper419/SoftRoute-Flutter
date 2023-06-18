import 'package:flutter/material.dart';

class AddCommentView extends StatefulWidget {
  const AddCommentView({super.key});

  @override
  State<AddCommentView> createState() => _AddCommentViewState();
}

class _AddCommentViewState extends State<AddCommentView> {
  //DATOS QUE IRAN EN EL DROPDOWN
  List<String> items= [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
  ];
  String selectedItem = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text("Add Comment",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                  child:Text(
                    "Select the type of complaint",style: TextStyle(fontSize: 15),),
              ),
              SizedBox(
                width: 100,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width:3,color:Color(0xffC8A1FF))
                    ),
                  ),
                  value: selectedItem,
                  items:items
                      .map((item)=>DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,style:TextStyle(fontSize: 15)),
                  ))
                    .toList(),
                  onChanged: (item)=>setState(()=> selectedItem = item!),
                )
              ),
            ],
          ),
          const SizedBox(height: 20,),

          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffC8A1FF),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 30),
              hintText: " Add feedback",
              hintStyle: const TextStyle(
                  color:Colors.white
              ),
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              //agregar accion al boton
            },
            child: const Text("Send"),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffC8A1FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
            ),
          )
        ],
      ),
    ),
    );
  }
}
