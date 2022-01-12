import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: double.infinity,
      color: Colors.blue,
      child: MaterialButton(
        onPressed:  function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    border: OutlineInputBorder(),
  ),


);

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),

              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                    color: Colors.grey
                ),

              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        // IconButton(
        //   onPressed: (){
        //     NewsCubit.get(context).updateData(
        //         status: 'done',
        //         id: model['id']);
        //   },
        //   icon: Icon(
        //     Icons.check_box,
        //     color: Colors.green,
        //   ),
        // ),
        // IconButton(
        //   onPressed: (){
        //     NewsCubit.get(context).updateData(
        //         status: 'archive',
        //         id: model['id']);
        //   },
        //   icon: Icon(
        //     Icons.archive,
        //     color: Colors.black45,
        //   ),
        // ),
      ],
    ),
  ),
  onDismissed: (direction){
    //NewsCubit.get(context).deleteData(id: model['id'] );
  },
);

Widget tasksBuilder({ @required List<Map> tasks}) =>

    ConditionalBuilder(
      condition: tasks.length>0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index ) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text('no tasks yet, add sum',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
              ),)

          ],
        ),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover
            ),
          ),
  
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder (list, context, {isSearch = false}) =>
  ConditionalBuilder(
    condition:  list.length>0,
    builder: (context)=>
        ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10,
        ),
    fallback: (context)=> isSearch? Container() :Center(
        child: CircularProgressIndicator()),
  );

void navigateTo(context,  widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget
),
);

