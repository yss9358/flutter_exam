import 'package:flutter/material.dart';
import 'personVo.dart';
import 'package:dio/dio.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('유승수'),),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffd6d6d6),
        ),
        child: _ReadPage(),
      ),
    );
  }
}

class _ReadPage extends StatefulWidget {
  const _ReadPage({super.key});

  @override
  State<_ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<_ReadPage> {

  late Future<PersonVo> personVo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    personVo = getVo();
    return FutureBuilder(
      future: personVo,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else if(snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는데 실패했습니다.'),);
        } else if(!snapshot.hasData){
          return Center(child: Text('데이터가 없습니다.'),);
        } else {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 40,
                    child: Text('${snapshot.data!.name}(${snapshot.data!.gender})',style: TextStyle(fontSize: 20),)),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 60,
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text('핸드폰',style: TextStyle(fontSize: 20),)),
                      Container(
                          width: 150,
                          child: Text('${snapshot.data!.hp}',style: TextStyle(fontSize: 20),))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 60,
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text('회사',style: TextStyle(fontSize: 20),)),
                      Container(
                        width: 150,
                        child: Text('${snapshot.data!.company}',style: TextStyle(fontSize: 20),))
                    ],
                  ),
                )
              ],
            ),
          );
        }
      }
    );
  }

  Future<PersonVo> getVo() async{
    try{
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://15.164.245.216:9000/api/myclass'
      );
      if(response.statusCode == 200){
        return PersonVo.fromJson(response.data);
      } else{
        throw Exception('api 서버 문제');
      }
    } catch(e){
      throw Exception('Failed to load person: $e');
    }
  }

}

