import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/runFindLoadApiGet.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/availableLoadsTextWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:liveasy/widgets/loadApiDataDisplayCard.dart';
import 'package:liveasy/widgets/loadingPointImageIcon.dart';
import 'package:liveasy/widgets/loadingWidget.dart';
import 'package:liveasy/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/widgets/addressInputWidget.dart';

class FindLoadScreen extends StatefulWidget {
  @override
  _FindLoadScreenState createState() => _FindLoadScreenState();
}

class _FindLoadScreenState extends State<FindLoadScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  var findLoadApiData;
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    if (Provider.of<ProviderData>(context).loadingPointCityFindLoad != "") {
      print(transporterIdController.transporterId);
      controller1 = TextEditingController(
          text:
              ("${providerData.loadingPointCityFindLoad} (${providerData.loadingPointStateFindLoad})"));
      findLoadApiData = runFindLoadApiGet(providerData.loadingPointCityFindLoad,
          providerData.unloadingPointCityFindLoad);
    }
    if (Provider.of<ProviderData>(context).unloadingPointCityFindLoad != "") {
      controller2 = TextEditingController(
          text:
              ("${providerData.unloadingPointCityFindLoad} (${providerData.unloadingPointStateFindLoad})"));
      findLoadApiData = runFindLoadApiGet(providerData.loadingPointCityFindLoad,
          providerData.unloadingPointCityFindLoad);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          providerData.clearLoadingPointFindLoad();
                          providerData.clearUnloadingPointFindLoad();
                        },
                        child: Icon(Icons.arrow_back_ios_rounded),
                      ),
                      SizedBox(
                        width: space_3,
                      ),
                      HeadingTextWidget("Find Load"),
                      // HelpButtonWidget(),
                    ],
                  ),
                  HelpButtonWidget(),
                ],
              ),
              SizedBox(
                height: space_5,
              ),
              AddressInputWidget(
                  hintText: "Loading Point",
                  icon: LoadingPointImageIcon(
                    height: 12,
                    width: 12,
                  ),
                  controller: controller1,
                  onTap: () {
                    providerData.clearLoadingPointFindLoad();
                  }),
              SizedBox(
                height: space_4,
              ),
              AddressInputWidget(
                hintText: "Unloading Point",
                icon: UnloadingPointImageIcon(
                  height: 12,
                  width: 12,
                ),
                controller: controller2,
                onTap: () {
                  providerData.clearUnloadingPointFindLoad();
                },
              ),
              SizedBox(
                height: space_3,
              ),
              Container(
                color: solidLineColor,
                height: borderWidth_12,
              ),
              SizedBox(
                height: space_4,
              ),
              findLoadApiData == null
                  ? Container()
                  : FutureBuilder(
                      future: findLoadApiData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.2),
                              child: LoadingWidget());
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AvailableLoadsTextWidget(),
                                /*FilterButtonWidget()*/
                              ],
                            ),
                            SizedBox(
                              height: space_4,
                            ),
                            Container(
                              height: 450,
                              //TODO to be modified
                              //alternative-(MediaQuery.of(context).size.height-(previous height))
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(),
                                itemCount: (snapshot.data.length),
                                itemBuilder: (BuildContext context, index) =>
                                    LoadApiDataDisplayCard(
                                  loadId: snapshot.data[index].loadId,
                                  loadingPoint:
                                      snapshot.data[index].loadingPoint,
                                  loadingPointCity: snapshot
                                      .data[index].loadingPointCityFindLoad,
                                  loadingPointState: snapshot
                                      .data[index].loadingPointStateFindLoad,
                                  unloadingPoint:
                                      snapshot.data[index].unloadingPoint,
                                  unloadingPointCity: snapshot
                                      .data[index].unloadingPointCityFindLoad,
                                  unloadingPointState: snapshot
                                      .data[index].unloadingPointStateFindLoad,
                                  productType: snapshot.data[index].productType,
                                  truckType: snapshot.data[index].truckType,
                                  noOfTrucks: snapshot.data[index].noOfTrucks,
                                  weight: snapshot.data[index].weight,
                                  status: snapshot.data[index].status,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
