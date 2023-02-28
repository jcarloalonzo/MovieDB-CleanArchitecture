import '../../../domain/enums.dart';
import '../../../domain/models/media/media.dart';
import '../../http/http.dart';

class TrendingAPI {
  TrendingAPI(this._http);

  final Http _http;

  getMoviesAndSeries(TimeWindow timeWindow) async {
    final response = await _http.request(
      '/trending/all/${timeWindow.name}',
      onSuccess: (json) {
        //
        final list = json['result'] as List<Map<String, dynamic>>;

        return list
            .where((e) => e['media_type'] != 'person')
            .map((e) => Media.fromJson(e))
            .toList();
      },
    );
  }
}
