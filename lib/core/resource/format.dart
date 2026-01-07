import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDate(dynamic date) {
  initializeDateFormatting('id_ID', null);
  return DateFormat('d MMMM yyyy', 'id_ID').format(date);
}
