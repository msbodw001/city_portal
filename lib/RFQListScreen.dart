import 'package:flutter/material.dart';
import 'package:html/dom.dart' show Document;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class RFQListScreen extends StatefulWidget {
  const RFQListScreen({Key key}) : super(key: key);

  @override
  _RFQListScreenState createState() => new _RFQListScreenState();
}

class _RFQListScreenState extends State<RFQListScreen> {
  List<RFQ> rfqList = new List<RFQ>();

  Future<List<String>> fetchData() async {
    //initialize a new list for the return statement
    List<String> _rfqList = new List<String>();

    //connect to the city's RFQ portal
    http.Response response = await http
        .get("http://web1.capetown.gov.za/web1/ProcurementPortal/RFQ");

    //parse and extract the data from the web site
    Document document = parser.parse(response.body);
    document.getElementsByClassName("gridDetails").forEach((row) {
      rfqList.add(RFQ(
        reference: row.getElementsByTagName("td")[0].text,
        title: row.getElementsByTagName("td")[1].text,
        category: row.getElementsByTagName("td")[2].text,
        closing: row.getElementsByTagName("td")[3].text,
        posted: row.getElementsByTagName("td")[4].text,
      ));
    });
    print("data is loaded");
    //just to wait until the get request completed
    return _rfqList;
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RFQ"),
      ),
      body: !loading
          ? RefreshIndicator(
              child: RFQListView(list: rfqList),
              onRefresh: () async {
                rfqList.clear();
                await fetchData();
                setState(() {});
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class RFQListView extends StatefulWidget {
  final List<RFQ> list;
  const RFQListView({Key key, this.list}) : super(key: key);

  @override
  RFQListViewState createState() => new RFQListViewState();
}

class RFQListViewState extends State<RFQListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView();
  }
}

class RFQ {
  String reference, title, category, closing, posted;
  RFQ({this.reference, this.title, this.category, this.closing, this.posted});
}
