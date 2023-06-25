# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2022-04-12

### Changed

- Refactor network layer, changed from Alamofire to swift Async Await function.

## [2.1.0] - 2022-04-08

### Added

- Router navigation pattern with router configurator.

## [2.0.0] - 2022-02-08

### Added

- App icon added.
- Added colors asset and color extension.

### Changed

- Changed app ui and colors.

## [1.1.0] - 2021-11-30

### Changed

- Replaced Bond framework with Apple Combine, used for view model/view controller binding.

## [1.0.2] - 2020-10-23

### Changed

- Refactored mapper name and switched from class to struct. Deleted mapper protocol.
- DTO and models name refactor.
- Deleted unused models.

## [1.0.1] - 2020-10-22

### Changed

- Renamed local files and folder data to Persistence

## [1.0] - 2020-10-20

### Added

- Start using "changelog" file.

### Changed

- ViewModel are now struct
- Saved locally DTO instead model
- Now method to check if new http call is neede, check date of Summary DTO model