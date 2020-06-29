# Birdie App


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Twitter](https://img.shields.io/badge/twitter-@byaruhaf-blue.svg)](http://twitter.com/byaruhaf)


## Week 5 Assignment

Build Birdie​ a Twitter-like app with tableviews

### Assignment Requirements completed
* Populate the Tableview with both text Posts & Image Post's
* Make custom cells using Xibs
* Use Type Casting to determine which custom Xib to use in the tableview
* Add a text post to the tableview

### Stretch Above and Beyond Requirements completed:
* Add an image post to the tableview
* Move the logic in cellForRowAt into a MediaPostsCellCoordinator. The MediaPostsCellCoordinator determines which cell to display based on the Media Type.

### Additional Assignment Goals completed
* Refactored tableview Datasource from ViewController to MediaPostsDataSource
* Refactored Image Picking function to ImagePicker class and use delegates and protocols pattern to return selected image to ViewController
* Refactored UIAlert for user post data from ViewController to MediaPostsHandler and use completion closure to tableview reload when valid data has been input
* Added custom separator to tableview


## App Demo

![Birdie](Demo/Birdie.gif)

## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).