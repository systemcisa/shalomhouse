import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/order_model.dart';
import 'package:shalomhouse/router/locations.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:intl/intl.dart';

class OrderListWidget extends StatelessWidget {
  bool _suggestPriceSelected = false;
  final OrderModel order;
  double? imgSize;
  OrderListWidget(this.order,{Key? key, this.imgSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgSize == null) {
      Size size = MediaQuery.of(context).size;
      imgSize = size.width / 6;
    }

    return InkWell(
      onTap: () {
        BeamState beamState = Beamer.of(context).currentConfiguration!;
        String currentPath = beamState.uri.toString();
        String newPath = (currentPath == '/')
            ? '/$LOCATION_ORDER/${order.orderKey}'
            : '$currentPath/${order.orderKey}';
        logger.d('newPath - $newPath');
        context.beamToNamed(newPath);
      },
      child: SizedBox(
        height: imgSize,
        child: Row(
          children: [
            SizedBox(
                height: imgSize,
                width: imgSize,
                child: ExtendedImage.network(
                  order.imageDownloadUrls[0],
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                )),
            const SizedBox(
              width: common_sm_padding,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.title,
                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.black12
                          : Colors.black,),
                    ),
                    Text(
                      order.detail,
                      maxLines:1,
                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.black12
                          : Colors.black,),
                    ),
                    Text("???????????? ?????????",
                      style: TextStyle(color: (order.negotiable == true)
                        ? Colors.black12
                        : Colors.black,),),
                    Text(
                      DateFormat('MM-dd kkmm').format(order.createdDate),

                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.black12
                          : Colors.black,),
                    ),
                  ],
                )
            ),
            const SizedBox(width: 50,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('????????? ??????',style: TextStyle(color: (order.negotiable == true)
                        ? Colors.black12
                        : Colors.black,),),
                    Text(
                      order.studentname,
                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.black12
                          : Colors.black,),
                    ),
                    Text(
                      order.studentnum,
                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.black12
                          : Colors.black,),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "????????????",
                      style: TextStyle(color: (order.negotiable == true)
                          ? Colors.redAccent
                          : Colors.transparent,),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}