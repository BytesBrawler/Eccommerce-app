import 'package:amazon_clone/features/admin/widgets/charts_widgets.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../model/sales_model.dart';
import '../services/admin_services.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(
              //   height: 250,
              //   child: CategoryProductsChart(seriesList: [
              //     charts.Series(
              //       id: 'Sales',
              //       data: earnings!,
              //       domainFn: (Sales sales, _) => sales.label,
              //       measureFn: (Sales sales, _) => sales.earning,
              //     ),
              //   ]),
              // )
              SizedBox(
                //height: 250,
                child: BarChartWidget(earnings!),
              )
            ],
          );
  }
}
