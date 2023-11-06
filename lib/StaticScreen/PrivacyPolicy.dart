import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Api.path.dart';
import '../color.dart';
import '../widgets/Appbar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getPrivacyPolicyApi();
  }
  void initState() {
    super.initState();
    getPrivacyPolicyApi();
  }
  var privacyPolicy;
  var privacyPolicyTitle;
  getPrivacyPolicyApi() async {
    var headers = {
      'Cookie': 'ci_session=0972dd56b7dcbe1d24736525bf2ee593c03d46de'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getSettings}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      setState(() {
        privacyPolicy = jsonResponse['data']['privacy_policy'];
        // privacyPolicyTitle = jsonResponse['data']['title'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: customAppBar(text: "Privacy Policy",isTrue: false, context: context),
          body: ListView(
            children: [
              privacyPolicy == null || privacyPolicy == "" ? Center(child: CircularProgressIndicator(color: colors.black,)) :
              Html(
                  data:"${privacyPolicy}"
              ),
            ],
          ),
      ),
    );
  }
}
