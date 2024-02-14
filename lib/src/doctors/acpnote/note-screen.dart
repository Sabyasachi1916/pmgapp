import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmgapp/measure/measure.dart';
import 'package:pmgapp/src/doctors/acpnote/note_model.dart';
import 'package:pmgapp/src/doctors/acpnote/note_services.dart';

class ACPNoteScreen extends StatefulWidget {
  const ACPNoteScreen({super.key, required this.leadNumber});
  final String leadNumber;
  @override
  State<ACPNoteScreen> createState() => _ACPNoteScreenState();
}

class _ACPNoteScreenState extends State<ACPNoteScreen> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ApsImage>? notes;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Note_Services().getNoteList(widget.leadNumber).then((value) => {
          setState(() {
            notes = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MM-dd-yyyy HH:mm');

    return Scaffold(
        body: Container(
      child: Stack(alignment: Alignment.bottomRight, children: [
        (notes != null)
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notes?.length ?? 0,
                  itemBuilder: (context, index) {
                   return ((notes?.length ?? 0) >= 1) ?  Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              notes?[index].image ?? "",
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(notes?[index].leadNumber ?? ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(formatter.format(
                                  notes?[index].createdOn ?? DateTime.now())),
                            )
                          ],
                        ),
                      ),
                    ) : Text("");
                  },
                ),
              )
            : Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text("No data available for now."),
              )),
        FloatingActionButton.small(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeasurePage(),
              ),
            );
          },
          child: const Icon(Icons.camera_enhance),
        ),
      ]),
    ));
  }
}
