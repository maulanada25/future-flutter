import 'package:flutter/material.dart';
import 'package:meet7/api_data_source.dart';
import 'api_data_source.dart';
import 'listuser_model.dart';
import 'user_detail.dart';

class PageListUsers extends StatefulWidget {
  const PageListUsers({ Key? key }) : super(key: key);

  @override
  State<PageListUsers> createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("List Users"),
      ),
      body: _buildListUsersBody(),
    ));
  }
}

Widget _buildListUsersBody(){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadUsers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          ListUserModel listUserModel = ListUserModel.fromJson(snapshot.data);
          return _buildSuccessSection(listUserModel);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error"),
  );
}

Widget _buildSuccessSection(ListUserModel data){
  return ListView.builder(
    itemCount: data.data!.length,
    itemBuilder: (BuildContext context, int index){
      return _buildItemUser(context, data.data![index]);
    }
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}

Widget _buildItemUser(BuildContext context, Data userData){
  return InkWell(
    onTap: () {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => UserDetail(idUser: userData.id)
        ),
      );
    },
    child: Card(
      child: Row(
        children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userData.firstName!+" "+userData.lastName!),
              Text(userData.email!)
            ],
          )
        ],
      )
    ),
  );
}