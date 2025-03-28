import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
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
                ), // Bo góc nhẹ (tuỳ chỉnh)
                child: Image.network(
                  AppImages.getImageUrlCast(peopleDetail.profilePath ?? ''),
                  width: 240, // Chiều rộng ảnh
                  height: 240, // Chiều cao ảnh
                  fit: BoxFit.cover, // Đảm bảo ảnh không bị méo
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
                      _buildInfoRow('Known For',
                          peopleDetail.alsoKnownAs.toString() ?? ''),
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
                fullText: peopleDetail.biography ?? '',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
    ;
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh theo đầu dòng
        children: [
          SizedBox(
            width: 100, // Giới hạn độ rộng của label
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // Giúp value co dãn và xuống dòng khi cần
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

// class BiographyWidget extends StatefulWidget {
//   @override
//   _BiographyWidgetState createState() => _BiographyWidgetState();
// }

// class _BiographyWidgetState extends State<BiographyWidget> {
//   bool isExpanded = false;

//   final String fullText = """
// Charlie Thomas Cox (born 15 December 1982) is an English actor. He is best known for portraying Matt Murdock/Daredevil in the Marvel Cinematic Universe, beginning with the television series Daredevil (2015–2018). He is set to reprise the role in his seventh project as the character, Daredevil: Born Again (2025).

// Cox portrayed Owen Sleater in the second and third seasons of HBO's Boardwalk Empire (2011–2012) and Jonathan Hellyer Jones in the 2014 film The Theory of Everything. He starred in the RTÉ drama series Kin (2021–2023) and the Netflix spy miniseries Treason (2022). Cox's breakout role was as Tristan Thorn in the 2007 fantasy film Stardust, one of a series of roles he had in predominantly British productions during the first decade of his career. He made his West End debut the following year in a revival of the Harold Pinter plays The Lover and The Collection. Following his successes on-screen in the 2010s, he acted in a 2019 stage production of Harold Pinter's Betrayal, first in the West End and then on Broadway.

// Description above from the Wikipedia article Charlie Cox, licensed under CC-BY-SA, full list of contributors on Wikipedia.
// """;

//   @override
//   Widget build(BuildContext context) {
//     String displayedText =
//         isExpanded ? fullText : '${fullText.substring(0, 200)}...';

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//           text: displayedText,
//           style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
//           children: [
//             TextSpan(
//               text: isExpanded ? " View Less" : " View More",
//               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                   });
//                 },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
