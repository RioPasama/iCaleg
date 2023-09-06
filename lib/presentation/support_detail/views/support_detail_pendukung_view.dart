import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/models/voter_dukungan_model.dart';
import 'package:icaleg/app/data/services/voter_service.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support_detail/controllers/support_detail.controller.dart';

class SupportDetailPendukungView extends GetView {
  SupportDetailPendukungView({Key? key}) : super(key: key);

  @override
  final SupportDetailController controller = Get.put(SupportDetailController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VoterService.getVoterDukunganDetail(id: controller.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          VoterDukunganModel voterDukunganModel =
              snapshot.data as VoterDukunganModel;
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              _header(voterDukunganModel),
              const SizedBox(height: 20),
              _listTitle(
                  title: 'Nama Lengkap', subTitle: voterDukunganModel.name),
              _listTitle(
                  title: 'Tampat & Tanggal Lahir',
                  subTitle:
                      '${voterDukunganModel.born} ${voterDukunganModel.birthday.toString().split(' ').first}'),
              _listTitle(
                  title: 'Usia',
                  subTitle: (DateTime.now()
                              .difference(voterDukunganModel.birthday)
                              .inDays ~/
                          365.25)
                      .toString()),
              // _listTitle(title: 'Agama', subTitle: ''),
              _listTitle(
                  title: 'Status Perkawian',
                  subTitle: voterDukunganModel.statusKawin),
              _listTitle(title: 'Pekerjaan', subTitle: voterDukunganModel.job),
              _listTitle(title: 'No. Hp', subTitle: voterDukunganModel.phone),
              _listTitle(
                  title: 'Kelurahan / Desa',
                  subTitle: voterDukunganModel.nameVillage),
              _listTitle(
                  title: 'Kecamatan',
                  subTitle: voterDukunganModel.nameDistrict),
              _listTitle(
                  title: 'Kabupaten / Kota',
                  subTitle: voterDukunganModel.nameRegency),
              _listTitle(
                  title: 'Provinsi', subTitle: voterDukunganModel.nameProvince),
            ],
          );
        } else {
          return Center(child: loadingDefault());
        }
      },
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

  Row _header(VoterDukunganModel voterDukunganModel) {
    return Row(
      children: [
        ImageNetworkView(
          url: voterDukunganModel.photo,
          height: 80,
          width: 80,
          margin: EdgeInsets.only(right: 10, left: marginHorizontal),
          decoration: const BoxDecoration(shape: BoxShape.circle),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voterDukunganModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Terdaftar pada ${voterDukunganModel.survey.toString().split(' ').first}',
              style: TextStyle(color: colorTextGray, fontSize: 14),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: colorPrimary, borderRadius: BorderRadius.circular(2)),
              child: const Text(
                'PEMILIH',
                style: TextStyle(
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
