import 'package:flutter/material.dart';
import 'package:meet7/detail_model.dart';
import 'api_data_source.dart';

class UserDetail extends StatefulWidget {
  final idUser;
  const UserDetail({ Key? key, required this.idUser}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
      ),body: _buildDetailedUsersBody(widget.idUser),
    ));
  }
}

Widget _buildDetailedUsersBody(int idUser){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadDetailUser(idUser),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          DetailModel detailModel = DetailModel.fromJson(snapshot.data);
          return _buildSuccessSection(detailModel);
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

Widget _buildSuccessSection(DetailModel data){
  return Column(
    children: [
      Container(
        width: 100,
        child: Image.network(data.data!.avatar!),
      ),
      Text(data.data!.firstName!+ " " + data.data!.lastName!),
      Text(data.data!.email!)
    ],
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}