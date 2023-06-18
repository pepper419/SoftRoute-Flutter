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
          Align(
            alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              value: selectedItem,
              items:items
                  .map((item)=>DropdownMenuItem<String>(
                value: item,
                child: Text(item,style:TextStyle(fontSize: 20)),
              ))
                .toList(),
              onChanged: (item)=>setState(()=> selectedItem = item!),
            )
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffC8A1FF),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none
              ),
              hintText: "Enter comment",
              hintStyle: const TextStyle(
                  color:Colors.white
              ),
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){},
            child: const Text("Add comment"),
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
