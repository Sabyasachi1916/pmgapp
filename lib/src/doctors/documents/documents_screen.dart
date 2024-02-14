import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/customsidemenu.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/src/doctors/documents/documents_model.dart';
import 'package:pmgapp/src/doctors/documents/documents_service.dart';
import 'package:pmgapp/src/doctors/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsScreen extends StatefulWidget {
  final String leadNumber;
  const DocumentsScreen({super.key, required this.leadNumber});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<Document>? documents;
  final DateFormat formatter = DateFormat('MM-dd-yyyy HH:mm');

  _launchURL(urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
      }
  }
  @override
  void initState() {
    setState(
      () {
        isLoading = true;
      },
    );
    super.initState();
    DocumentService()
        .getDocuments(widget.leadNumber)
        .then((value) => {setState((){
          documents = value?.list;
          isLoading = false;
        } )});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomSideMenu(
          globalKey: _scaffoldKey,
        ),
        backgroundColor: Constants.mainTheme,
        // appBar: appbar(),
        body: SafeArea(
          child: Stack(children: [
            (documents != null)
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: documents?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ()=>{_launchURL(documents?[index].documentUrl ?? "")},
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                     
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.file_copy, size: 40,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      
                                      Text(
                                          formatter.format(
                                              documents![index].createdOn),
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text("View File"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text("No data available for now."),
                  )),
            if (isLoading == true) LoadingView(),
          ]),
        ));
  }
}
