import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmgapp/constants.dart';
import 'package:pmgapp/login/login.dart';
import 'package:pmgapp/map/map.dart';
import 'package:pmgapp/measure/measure.dart';
import 'package:pmgapp/src/doctors/home/home.dart';
import 'package:pmgapp/src/doctors/patientInfo/patient_model.dart';
import 'package:pmgapp/src/doctors/patientInfo/patientinfo_service.dart';

class PatientInfoScreen extends StatefulWidget {
  String leadNumber;
  PatientInfoScreen({super.key, required this.leadNumber});

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  PatientInfoResponse? patientInfo;
  bool isloading = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    print("Lead # is -- ${widget.leadNumber}", );
    PatientInfoService().getPatientInfo(widget.leadNumber).then((value) => {
          setState(
            () {
              patientInfo = value;
              isloading = false;
            },
          )
        });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainTheme,
      // appBar: appbar(),
      body: SafeArea(
        child: Stack(alignment: Alignment.bottomRight, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  GeneralInfoWidget(patient_info: patientInfo),
                  
                ],
              ),
            ),
          ),
          // Row(
          //   children: [
          //     const Spacer(),
          //     FloatingActionButton.small(
          //       heroTag: "1",
          //       onPressed: () {},
          //       child: const Icon(Icons.edit),
          //     ),
          //     FloatingActionButton.small(
          //       heroTag: "2",
          //       onPressed: () {},
          //       child: const Icon(Icons.upload),
          //     ),
          //     FloatingActionButton.small(
          //       heroTag: "3",
          //       onPressed: () {},
          //       child: const Icon(Icons.videocam),
          //     )
          //   ],
          // ),
          if (isloading == true) LoadingView(),
        ]),
      ),
    );
  }
}

class DocumentsWidget extends StatelessWidget {
  const DocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Constants.appTheme,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Documents/Files",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return const Text("Blood Test Report.pdf, Date: 10th Oct, 2023");
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                ),
              ),
            ])));
  }
}

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.appTheme,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeasurePage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.camera_enhance))
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "Pain first occourred 9 days ago, and has been persistent. Presents in rest, but is particularly painful whenexerting himself."),
                        const Text(
                          "Dr. Peter Parker, Date:  20th Oct, 2023",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return const Text(
                                "Dr. Peter Parker, Date: 10th Oct, 2023");
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: Colors.white,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}

class GeneralInfoWidget extends StatefulWidget {
  PatientInfoResponse? patient_info;

  GeneralInfoWidget({super.key, required this.patient_info});

  @override
  State<GeneralInfoWidget> createState() => _GeneralInfoWidgetState();
}

class _GeneralInfoWidgetState extends State<GeneralInfoWidget> {
  StateList? stateList;
  List<InsuranceList>? insuranceList;
  final DateFormat formatter = DateFormat('MM-dd-yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PatientInfoService().getStateList().then((sl) {
      setState(() {
        if (sl != null){
          stateList =  sl;
        }
      });
    },);
    PatientInfoService().getInsuranceList().then((val) {
      setState(() {
        if (val != null){
          insuranceList =  val;
        }
      });
    },);
  }
 String getState(int id){
    var stname = '';
    if (stateList != null){
      for (int i=0; i< stateList!.data.length; i++){
        if (stateList!.data[i].id == id){
          stname = stateList!.data[i].stateName;
        }
      }
    }
    return stname;
  }
  String insurance(int id){
    var insuranceName = '';
    if (insuranceList != null){
      for (int i=0; i< insuranceList!.length; i++){
        if (insuranceList![i].id == id){
          insuranceName = insuranceList![i].insurancePrimaryName;
        }
      }
    }
    return insuranceName;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "General Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Patient Age',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        getState(widget.patient_info?.list[0].patientAge ?? 0),
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Gender',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].patGender ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Ethnicity',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].ethnicity ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text(
                            'Race',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(
                        widget.patient_info?.list[0].race ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Latest Ht.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].latestHt ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                     SizedBox(height: 20,),
                      const Text(
                        'Latest Wt.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                       Text(
                        widget.patient_info?.list[0].latestWt ?? "",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Latest BMI',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        "${widget.patient_info?.list[0].latestBmi ?? ""} " ,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      
                      
                    ],
                  ),
                ),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'How many Children',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].hwMnyChldrnDyHv.toString() ?? '',
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Covid Positive',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].covidPositive ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Smoking History',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].dyrHvYVrSmkdTbcc ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Surgery History date',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].surgHistDate != null ? formatter.format(widget.patient_info?.list[0].surgHistDate ?? DateTime.now()) : "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Surgery History Proc',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].surgHistProc ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Family History Prob',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].famHistProb ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Level of Alcohol Consumption',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        widget.patient_info?.list[0].whtSYrLvlFLchlCnsmptn ?? "" ,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      
                      
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class photoEmailWidget extends StatefulWidget {
//   PatientInfoResponse? patient_info;

//   photoEmailWidget({super.key, required this.patient_info});

//   @override
//   State<photoEmailWidget> createState() => _photoEmailWidgetState();
// }

// class _photoEmailWidgetState extends State<photoEmailWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Constants.appTheme,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.network(
//                       "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover)),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${widget.patient_info?.firstName ?? ""} ${widget.patient_info?.lastName ?? ""}",
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                         onPressed: () {},
//                         style: TextButton.styleFrom(
//                           minimumSize: Size.zero,
//                           padding: EdgeInsets.zero,
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         child: const Icon(
//                           Icons.email_outlined,
//                           size: 20,
//                         )),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.patient_info?.email ?? "",
//                       style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.grey),
//                     ),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
