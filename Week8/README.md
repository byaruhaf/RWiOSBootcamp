# SandwichSaturation App in SwiftUI


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


## Week 8 Assignment

Rebuild the social media app Birdie from Week 5 in SwiftUI

### Assignment Requirements completed
* Work as a Team to complete the Assignment


### Stretch Above and Beyond Requirements completed:
* Added feature for user to Delete Birdie Post




### Other options for packaging seed data
**In your README, describe at least one other option for packaging seed data like this with an app. Which do you think makes the most sense if you were shipping SandwichSaturation, and why?**

File-based approach for persisting simply-structured data sets
Entire contents of a plist get loaded into memory when you access the file
Way to ship initial configuration for your app
Capable of storing lists of data with predictable size

JSON is a very simple, but very powerful way to express data. Anything you can do with a plist? You can do it in JSON as well. Furthermore, JSON tends to yield more compact data/files than XML, but still can be quite readable (unlike binary). The data structures map naturally onto concepts supported by just about every language and library, so having parser support for JSON is natural. In fact, you’ll find Apple supports JSON natively in the OS with NSJSONSerialization. Now you have a nice way on iOS or Mac OS X to convert your JSON to native Foundation objects, and gee wasn’t that the point of Property Lists? JSON isn’t supported as integrally as Property Lists are, but that the OS provides built-in support for JSON is welcome. You’ll even find that on most other platforms, other languages, other libraries, JSON support is a natural part of things. This makes use of JSON quite nice when you work in a multi-platform situation. Just write the file once, share it, life goes on.

For the most part on that other project, JSON became the file format of choice because everyone can share the files.



##### Angles for Analysis

* Where data is saved
* Who maintains the technology
* Data model complexity
* Data Size
* Compatibility
* Price

## App Demo




## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).