import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';


class DetailScreen extends StatefulWidget {

  final Post posts;
  final List listId;

  const DetailScreen(this.posts,  this.listId,{Key? key}) : super(key: key);


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late int id =0;
  List isFavorite = [2, 5, 3];

  toggleIcons(){
    int id= int.parse(widget.posts.id);
    if(isFavorite.contains(id)){
      // isFavorite.remove(id);
      // test(isFavorite);
       return const Icon(Icons.delete, color: Colors.red, size: 50,);
    }else {
      // isFavorite.add(id);
      // test(isFavorite);
        return const Icon(Icons.check, color: Colors.blue, size: 50);
    }

  }

  toggleFavorite(){
    int id= int.parse(widget.posts.id);
    if(isFavorite.contains(id)){
       isFavorite.remove(id);
    }else{
      isFavorite.add(id);
    }
  }

  @override
  void initState() {
    super.initState();
    isFavorite;
    toggleIcons;
    isFavorite = widget.listId;
  }


  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20 ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(widget.posts.sortie.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Text(
                    DateFormat('dd/MM/y').format(widget.posts.date),
                    // correctlyFormattedDateTime(posts.date.toString()),
                    style: TextStyle(color: Colors.blue[500], fontSize: 20)
                ),

              ],
            ),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                isFavorite;
                toggleFavorite();
                toggleIcons();
              });
            },
            icon: toggleIcons(),
          )
        ]
      ),
    );

    Widget effectifSection =
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Icon(Icons.supervisor_account, color: Colors.blue,),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          child:
          Text(
            widget.posts.id, style: const TextStyle(
            color: Colors.blue,
          ),
          ),
        ),
        ],
    );

    Widget descriptionSection = Container(
      // margin: const EdgeInsets.only(top: 30, bottom: 30),
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Description de la sortie', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue,
                decoration: TextDecoration.underline
            ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                widget.posts.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.blue,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.amber[500],
      appBar: AppBar(
        title: Text(widget.posts.sortie),
        leading: IconButton( // Icon arrow back AppBar
          onPressed: ()=> {
            setState(() {
              isFavorite;
            }),
          Navigator.pop(context, isFavorite),
        },
          icon: Icon(Icons.arrow_back),
        ),

      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.all(10),
            child: CachedNetworkImage(
              imageUrl: 'https://bugalez.com/site/api/bagad/img/skolsonnerien128x128-trans.png',
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          titleSection,
          effectifSection,
          descriptionSection,
        ],
      ),
    );
  }

  void test(data) {print(data);}

} //class End

// String correctlyFormattedDateTime(String date){
//   var ParsedDate = DateTime.parse(date);
//   return DateFormat('EEEE dd MMMM yyyy', 'fr').format(ParsedDate); //=> 02/07/2020
// }