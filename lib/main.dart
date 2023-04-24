import 'package:fudeo_hackaton/app/app.dart';
import 'package:fudeo_hackaton/bootstrap.dart';

void main() {
  bootstrap(
    builder: (
      jobOfferRepository,
      favouriteRepository,
      socialShareRepository,
    ) =>
        App(
      jobOfferRepository: jobOfferRepository,
      socialShareRepository: socialShareRepository,
      favouritesRepository: favouriteRepository,
    ),
  );
}
