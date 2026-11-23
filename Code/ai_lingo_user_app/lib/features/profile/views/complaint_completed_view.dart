import 'package:flutter/material.dart';
import '../widgets/profile_components.dart';

class ComplaintCompletedView extends StatelessWidget {
  const ComplaintCompletedView({super.key});
  @override
  Widget build(BuildContext context) => ProfilePage(title: 'Complaints & Support', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Expanded(child: Container(alignment: Alignment.center, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: const Color(0xFFF3F4F8), borderRadius: BorderRadius.circular(8)), child: const Text('New complaint', style: TextStyle(fontSize: 10, color: ProfileColors.muted)))),
      const SizedBox(width: 8),
      Expanded(child: Container(alignment: Alignment.center, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: ProfileColors.primaryLight, borderRadius: BorderRadius.circular(8)), child: const Text('My History', style: TextStyle(fontSize: 10, color: ProfileColors.primary, fontWeight: FontWeight.w600)))),
    ]),
    const SizedBox(height: 18),
    Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: ProfileColors.green, borderRadius: BorderRadius.circular(10)),
      child: const Row(children: [
        SvgAssetIcon('circle-check', color: Color(0xFF31B78A), size: 20),
        SizedBox(width: 9), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Complaint submitted', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF218D6B))),
          Text('Your request has been received. We’ll get back to you soon.', style: TextStyle(fontSize: 9, color: Color(0xFF438F7B))),
        ])),
      ])),
    const SizedBox(height: 20),
    const SectionTitle('My complaints'),
    const SizedBox(height: 10),
    const _ComplaintTile(title: 'Weekly test score looks incorrect', status: 'Pending', color: Color(0xFFE7A34A), id: 'BC-1042'),
    const SizedBox(height: 10),
    const _ComplaintTile(title: 'Conversation audio is not clear', status: 'In Progress', color: ProfileColors.primary, id: 'BC-1038'),
    const SizedBox(height: 10),
    const _ComplaintTile(title: 'Unable to save a new word', status: 'Resolved', color: Color(0xFF31B78A), id: 'BC-1029'),
    const SizedBox(height: 24),
    PrimaryButton(label: 'Submit New Complaint', onPressed: () => Navigator.pushNamed(context, '/profile/complaints')),
  ])));
}

class _ComplaintTile extends StatelessWidget {
  const _ComplaintTile({required this.title, required this.status, required this.color, required this.id});
  final String title, status, id; final Color color;
  @override
  Widget build(BuildContext context) => ProfileCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ProfileColors.ink))),
      Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: color.withOpacity(.13), borderRadius: BorderRadius.circular(20)), child: Text(status, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w700)))]),
    const SizedBox(height: 7),
    Text('Request #$id  •  Submitted recently', style: const TextStyle(fontSize: 9, color: ProfileColors.muted)),
  ]));
}
