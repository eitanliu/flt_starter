import 'package:flt_starter/flt_starter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../viewmodel/base_paging_view_model.dart';

class PagingFooter<VM extends BasePagingViewModel> extends StatelessWidget {
  /// 给底部加载的footer添加一个底部间距(不包含footer本身高度64px)
  final double footerBottom;

  const PagingFooter({
    Key? key,
    this.footerBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasePagingViewModel viewModel = context.viewModel<VM>();
    return ValueListenableBuilder<FooterStatus>(
        valueListenable: viewModel.footerStatus,
        builder: (context, value, child) {
          if (value == FooterStatus.noMore) {
            /// 无更多数据
            return Container(
              height: 64.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: footerBottom),
              child: Text(
                "没有更多数据",
                style: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 12.sp,
                ),
              ),
            );
          } else if (value == FooterStatus.failed) {
            /// 加载失败，可点击重试
            return InkWell(
              onTap: () {
                viewModel.loadMore();
              },
              child: Container(
                height: 64.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: footerBottom),
                child: Text(
                  "重试",
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            );
          } else if (value == FooterStatus.loading) {
            /// 加载中
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  radius: 8.sp,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  height: 64.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: footerBottom),
                  child: Text(
                    "正在加载中",
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text("");
          }
        });
  }
}
