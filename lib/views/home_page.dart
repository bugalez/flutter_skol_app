import 'package:cached_network_image/cached_network_image.dart';
import'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/post.dart';
import '../services/remote_service.dart';
import 'detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // bool isCheked = false;
  var isLoaded = false;
  late int id;
  List listId = [];

  List<Post>? posts;

  @override
  void initState() {
    super.initState();

    //fetch data from Api
    getData();
    listId;
    // print("homePage${listId}");


  }

  // Récupère les datas de l'api
  getData() async{
    posts = await RemoteService().getPosts();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  var blue = Colors.blue;


  final Widget networkImage =
  SizedBox(
    height: 50,
    width: 50,
    child: CachedNetworkImage(
      imageUrl: "https://bugalez.com/site/api/bagad/img/skolsonnerien128x128-trans.png",
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );

  /* ----------------------------Scaffold -------------------*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[500],
      appBar: AppBar(
        title: const Text('Prestation 2022'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            int indexAdd = index +1 ;
            return Card(
              color: blue,
              child: ListTile(
                leading: networkImage,
                title: Text(posts![index].sortie),
                subtitle: Text(
                    DateFormat('dd/MM/y').format(posts![index].date)
                ),
                trailing: listId.contains(indexAdd) ? const Icon(Icons.star, size: 30, color: Colors.amberAccent,) : null,
                onTap: () async {
                  listId = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(posts![index], listId),
                    )
                  );

                  setState(() {
                  });
                },
              ),
            );
          },
        ),
      ),
    );

  }

  int indexAdd(int data) {
    late int intAdd = data -1;
    return intAdd;
  }

}

// String correctlyFormattedDateTime(String fr, String date){
//   initializeDateFormatting(fr);
//
//
//   var ParsedDate = DateTime.parse(date);
//   return DateFormat('EEEE dd MMMM yyyy', fr).format(ParsedDate); //=> 02/07/2020
// }
