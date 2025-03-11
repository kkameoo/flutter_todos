import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("할 일 수정"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _EditForm(),
    );
  }
}

class _EditForm extends StatefulWidget {
  const _EditForm({super.key});

  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  // 상태 (TodoItem의 필드)
  late int _todoId;
  bool _completed = false;

  // 상수
  static const String apiEndpoint = "http://13.125.197.209:18088/api/todos";

  final TextEditingController _titleController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 전 페이지로부터 전달해 준 id 매개변수 받아오기
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('id')) {
      _todoId = args['id'];
      getTodoItem(_todoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "할 일",
                  hintText: "할 일을 입력하세요",
                ),
              ),
            ),
            Checkbox(
              value: _completed,
              onChanged: (value) {
                setState(() {
                  _completed = value ?? false;
                });
              },
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  updateTodo();
                },
                child: Text("수정"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 서버로부터 TodoItem을 가져오는 통신 함수 (GET)
  getTodoItem(int todoId) async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      //  TodoItem 받아오기
      final response = await dio.get("$apiEndpoint/$todoId");
      if (response.statusCode == 200) {
        // 수정 폼에 출력할 정보 설정
        _titleController.text = response.data["title"];
        setState(() {
          _completed = response.data["completed"];
        });
      }
    } catch (e) {
      throw Exception("데이터를 불러오지 못했습니다: $e");
    }
  }

  // 변경된 TodoItem을 서버로 반영하는 통신 함수
  updateTodo() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      // 서버로 변경됨 할 일을 전송 (PUT)
      final response = await dio.put(
        "$apiEndpoint/$_todoId",
        data: {"title": _titleController.text, "completed": _completed},
      );

      if (response.statusCode == 200) {
        // Navigator.pop(context);
        Navigator.pushNamed(context, "/");
      } else {
        throw Exception("API 서버 오류입니다.");
      }
    } catch (e) {
      throw Exception("할 일을 수정하지 못했습니다.:$e");
    }
  }
}
