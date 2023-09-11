import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/models/detail_koordinator_model.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support_detail/controllers/support_detail.controller.dart';
import 'package:intl/intl.dart';

class SupportDetailKoorView extends GetView {
  SupportDetailKoorView({Key? key}) : super(key: key);
  @override
  final SupportDetailController controller = Get.put(SupportDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: PemiluService.getDataKoorlapDetail(id: controller.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DetailKoordinatorModel dataKoordinatorModel =
              snapshot.data as DetailKoordinatorModel;
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              _header(dataKoordinatorModel),
              _statistilk(dataKoordinatorModel),
              _listTitle(
                  title: 'Nama Lengkap', subTitle: dataKoordinatorModel.name),
              _listTitle(title: 'TPS', subTitle: dataKoordinatorModel.tps),
              _listTitle(
                  title: 'Tampat & Tanggal Lahir',
                  subTitle:
                      '${(dataKoordinatorModel.born ?? '')} ${(dataKoordinatorModel.birthday ?? '').toString().split(' ').first}'),
              // _listTitle(
              //     title: 'Usia',
              //     subTitle:dataKoordinatorModel.birthday.isBlank? :(DateTime.now()
              //                 .difference(dataKoordinatorModel.birthday)
              //                 .inDays ~/
              //             365.25)
              //         .toString()),
              // _listTitle(title: 'Agama', subTitle: ''),
              _listTitle(
                  title: 'Status Perkawian',
                  subTitle: dataKoordinatorModel.statusKawin ?? ''),
              _listTitle(
                  title: 'Pekerjaan', subTitle: dataKoordinatorModel.job ?? ''),
              _listTitle(title: 'No. Hp', subTitle: dataKoordinatorModel.phone),
              _listTitle(
                  title: 'Kelurahan / Desa',
                  subTitle: dataKoordinatorModel.nameVillage),
              _listTitle(
                  title: 'Kecamatan',
                  subTitle: dataKoordinatorModel.nameDistrict),
              _listTitle(
                  title: 'Kabupaten / Kota',
                  subTitle: dataKoordinatorModel.nameRegency),
              _listTitle(
                  title: 'Provinsi',
                  subTitle: dataKoordinatorModel.nameProvince),
            ],
          );
        } else {
          return Center(child: loadingDefault());
        }
      },
    ));
  }

  Padding _statistilk(DetailKoordinatorModel dataKoordinatorModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(marginHorizontal, 20, marginHorizontal, 20),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              const Text(
                'Total Dukungan',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                NumberFormat.decimalPattern('id')
                    .format(dataKoordinatorModel.totalDukungan),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: colorTextPrimary),
              ),
              Text(
                'Dukungan yang Direkrut Oleh Dukungan Ini',
                textAlign: TextAlign.center,
                style: TextStyle(color: colorTextGray),
              ),
            ],
          )),
          Container(
            height: 100,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: colorGray,
          ),
          Expanded(
              child: Column(
            children: [
              const Text(
                'Presentase Dukungan',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${NumberFormat.decimalPattern('id').format(dataKoordinatorModel.presentaseDukungan)}%',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: colorTextPrimary),
              ),
              Text(
                'Dari Keseluruhan Dukungan Anda (${NumberFormat.decimalPattern('id').format(dataKoordinatorModel.totalTarget)})Dukungan',
                textAlign: TextAlign.center,
                style: TextStyle(color: colorTextGray),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Container _listTitle({required String title, required String subTitle}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 8),
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: colorGray))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: colorTextGray),
          ),
          Text(
            subTitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Row _header(DetailKoordinatorModel dataKoordinatorModel) {
    return Row(
      children: [
        ImageNetworkView(
          url: dataKoordinatorModel.photo,
          height: 80,
          width: 80,
          margin: EdgeInsets.only(right: 10, left: marginHorizontal),
          decoration: const BoxDecoration(shape: BoxShape.circle),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataKoordinatorModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Terdaftar pada ${dataKoordinatorModel.createAt.toString().split(' ').first}',
              style: TextStyle(color: colorTextGray, fontSize: 14),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: colorPrimary, borderRadius: BorderRadius.circular(2)),
              child: Text(
                dataKoordinatorModel.detailKoordinatorModelAs,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
