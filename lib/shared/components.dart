import 'package:flutter/material.dart';
import 'package:news_app_api/modules/web_view_screen.dart';

Widget builtItem(Map artical , context) {
  return InkWell(
    onTap: (){
      navigateTo(context, webViewScreen(artical['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          artical['urlToImage'] != null
           ? Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${artical['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          )
          : Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage('assets/news.png'),
                  fit: BoxFit.cover),
            ),
          ) ,
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${artical['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow:
                        TextOverflow.ellipsis, // تظهر نقاط انه ما زال يوجد نص
                  ),
                  Text(
                    '${artical['publishedAt']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
  );
}

Widget articalBuilder (list , context , { isSearch = false}){
  return (list.length > 0)
      ?  ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index) => builtItem(list[index] , context),
      separatorBuilder: (context , index) => myDivider() ,
      itemCount: list.length
  )
      : isSearch ? Container() :Center(child :CircularProgressIndicator())  ;
}

void navigateTo(context ,  widget) {
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => widget
      )
  );
}