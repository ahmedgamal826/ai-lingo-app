import '../models/complaint_models.dart';

/// Contract for complaints listing and reply operations (API later).
abstract class ComplaintsService {
  Future<ComplaintsPage> fetchComplaints(ComplaintsQuery query);

  Future<List<String>> fetchCategories();

  Future<ComplaintItem> fetchComplaintById(String id);

  Future<ComplaintItem> submitReply(ComplaintReplyRequest request);
}
