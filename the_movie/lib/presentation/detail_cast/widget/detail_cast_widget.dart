import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_images.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/presentation/detail_cast/widget/biography_widget.dart';

class DetailCastWidget extends StatelessWidget {
  final PeopleDetail peopleDetail;
  const DetailCastWidget({super.key, required this.peopleDetail});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  35,
                ),
                child: Image.network(
                  AppImages.getImageUrlCast(peopleDetail.profilePath ?? ''),
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                peopleDetail.name ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(
                          'Known For', peopleDetail.alsoKnownAs.toString()),
                      const Divider(),
                      _buildInfoRow(
                          'Known Credits', peopleDetail.id.toString()),
                      const Divider(),
                      _buildInfoRow('Gender',
                          (peopleDetail.gender == 1) ? "Male" : "Female"),
                      const Divider(),
                      _buildInfoRow(
                        'Birthday',
                        DateFormat('MMMM dd, yyyy')
                            .format(peopleDetail.birthday ?? DateTime.now()),
                      ),
                      const Divider(),
                      _buildInfoRow(
                          'Place of Birth', peopleDetail.placeOfBirth ?? ''),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BiographyWidget(
                fullText: peopleDetail.biography ??
                    'No information available about this castor.',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
