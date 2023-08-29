import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_get_x/src/constants/api_const.dart';
import 'package:weather_get_x/src/constants/app_colors.dart';
import 'package:weather_get_x/src/constants/app_text.dart';
import 'package:weather_get_x/src/constants/app_text_styles.dart';
import 'package:weather_get_x/src/controller/weather_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ctl = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppText.text,
          style: AppTextStyles.appBarStyle,
        ),
      ),
      body: ctl.weather.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/weather.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await ctl.weatherLocation();
                        },
                        color: AppColors.white,
                        iconSize: 50,
                        icon: const Icon(Icons.near_me),
                      ),
                      IconButton(
                        onPressed: () {
                          ctl.showBotton(context);
                        },
                        color: AppColors.white,
                        iconSize: 50,
                        icon: const Icon(Icons.location_city),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 14),
                      Obx(
                        () => Text(
                          '${(ctl.weather.value!.temp - 273.15).toInt()}',
                          style: AppTextStyles.body1,
                        ),
                      ),
                      Image.network(
                        ApiConst.getIcon(ctl.weather.value!.icon, 4),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FittedBox(
                              child: Obx(() {
                                return Text(
                                  ctl.weather.value!.description
                                      .replaceAll(' ', '\n'),
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.body2,
                                );
                              }),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FittedBox(
                              child: Obx(() {
                                return Text(
                                  ctl.weather.value!.city,
                                  style: AppTextStyles.city,
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
