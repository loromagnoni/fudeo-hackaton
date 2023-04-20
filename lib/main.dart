import 'package:fudeo_hackaton/app/app.dart';
import 'package:fudeo_hackaton/bootstrap.dart';

void main() {
  bootstrap(
    builder: (jobOfferRepository, favouriteRepository) => App(
      jobOfferRepository: jobOfferRepository,
      favouritesRepository: favouriteRepository,
    ),
  );
}
