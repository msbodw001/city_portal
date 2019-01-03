import 'package:city_portal/screens/RFQDetailsScreen.dart';
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
    var rows = document.getElementsByClassName("gridDetails");
    rows.forEach((row) async {
      var _reference = row.getElementsByTagName("td")[0].text;
      var _title = row.getElementsByTagName("td")[1].text;
      var _category = row.getElementsByTagName("td")[2].text;
      var _closing = row.getElementsByTagName("td")[3].text;
      var _posted = row.getElementsByTagName("td")[4].text;
      var _detailsLink = row.querySelector(".linkDetails").attributes['href'];
      rfqList.add(RFQ(
        reference: _reference,
        title: _title,
        category: _category,
        closing: _closing,
        posted: _posted,
        detailsLink: "http://web1.capetown.gov.za/$_detailsLink",

      ));
    });
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
    return ListView(
      children: widget.list.isNotEmpty
          ? widget.list.map((item) {
              return ListTile(
                title: Text(item.title.trim()),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RFQDetailsScreen(item: item))),
              );
            }).toList()
          : [],
    );
  }
}

class RFQ {
  String reference, title, category, closing, posted, detailsLink;
  RFQ({this.reference, this.title, this.category, this.closing, this.posted, this.detailsLink });
}
