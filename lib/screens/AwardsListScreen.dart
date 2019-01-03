import 'package:flutter/material.dart';
import 'package:html/dom.dart' show Document;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class AwardsListScreen extends StatefulWidget {
  const AwardsListScreen({Key key}) : super(key: key);

  @override
  _AwardsListScreenState createState() => new _AwardsListScreenState();
}

class _AwardsListScreenState extends State<AwardsListScreen> {
  List<Award> awardList = new List<Award>();

  Future<List<String>> fetchData() async {
    //initialize a new list for the return statement
    List<String> _awardList = new List<String>();

    //connect to the city's RFQ portal
    http.Response response = await http
        .get("http://web1.capetown.gov.za/web1/ProcurementPortal/Award/ViewAwards");

    //parse and extract the data from the web site
    Document document = parser.parse(response.body);
    document.getElementsByClassName("gridDetails").forEach((row) {
      awardList.add(Award(
        reference: row.getElementsByTagName("td")[0].text,
        title: row.getElementsByTagName("td")[1].text,
        category: row.getElementsByTagName("td")[2].text,
        status: row.getElementsByTagName("td")[3].text,
        awardedDate: row.getElementsByTagName("td")[4].text,
      ));
    });
    print("data is loaded");
    //just to wait until the get request completed
    return _awardList;
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
        title: Text("Awards"),
      ),
      body: !loading
          ? RefreshIndicator(
          child: AwardsListView(list: awardList),
          onRefresh: () async {
            awardList.clear();
            await fetchData();
            setState(() {});
          })
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AwardsListView extends StatefulWidget {
  final List<Award> list;
  const AwardsListView({Key key, this.list}) : super(key: key);

  @override
  AwardsListViewState createState() => new AwardsListViewState();
}

class AwardsListViewState extends State<AwardsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.list.isNotEmpty
          ? widget.list.map((item) {
        return ListTile(title: Text(item.title.trim()));
      }).toList()
          : [],
    );
  }
}

class Award {
  String reference, title, category, status, awardedDate;
  Award({this.reference, this.title, this.category, this.status, this.awardedDate});
}
