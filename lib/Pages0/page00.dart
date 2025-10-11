import 'package:atalaia_ar_condicionados_flutter_application/Pages/Config/app_colors.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/Config/app_text_style.dart';
import 'package:flutter/material.dart';

class Page00 extends StatelessWidget {
  const Page00({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorPages,
      appBar: AppBar(
        // backgroundColor: AppColors.backgroundColorAppBar,
        title: Text(
          "Page01",
          style: AppTextStyle.titleAppBar.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Page00", style: AppTextStyle.subtitlePages),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder_copy,
                            size: 33,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 14),
                          Text(
                            "Page00",
                            style: AppTextStyle.titleAppBar.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 45,
                        right: 25,
                        top: 10,
                      ),
                      child: Text(
                        "Page exemplo para implementação de novas telas",
                        style: AppTextStyle.subtitlePages.copyWith(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.orange,
                            ),
                          ),
                          onPressed: () {},
                          child: Text("aperte"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
