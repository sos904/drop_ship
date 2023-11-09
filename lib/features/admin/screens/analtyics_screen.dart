import 'package:drop_ship/common/widgets/custom_button.dart';
import 'package:drop_ship/common/widgets/loader.dart';
import 'package:drop_ship/features/account/services/account_services.dart';
import 'package:drop_ship/features/admin/models/sales.dart';
import 'package:drop_ship/features/admin/services/admin_services.dart';
import 'package:drop_ship/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
//import 'package:drop_ship/features/admin/widgets/bottom_button.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                'Ghc$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 650,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earning,
                  ),
                ]),
              ),
              Form(
                  child: Column(children: [
                SizedBox(height: 10),
                // Expanded(
                //   child: Align(
                // alignment: Alignment.bottomCenter,
                // child:
                CustomButton(
                  text: 'Log Out',
                  onTap: () => AccountServices().logOut(context),
                ),
                // )
                //),
              ])),
            ],
          );
  }
}
