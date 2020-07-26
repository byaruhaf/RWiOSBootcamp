# jQuiz App


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


## Week 9 Assignment

Complete JQUIZ app with networking & Audio feature  

### Assignment Requirements completed
* Getting the Clues and answers from the jservice API
* set up your ViewController to display a clue’s category, question, and 4 possible answers.
* Calculates the points based on the uses answers 
* Download image logo from the internet. 

### Stretch Above and Beyond Requirements completed:
* Add music the user can play while using the app, Save whether the user wants sound enabled in UserDefaults.
* Change the model to conform them to “codable”, use CodingKeys to change `category_id` to `categoryId` and `value` to `points`.
* Make an extension of UIImageView and use the **Flyweight Design Pattern** to implement a cache for your downloaded image.

### Additional Assignment Goals completed
* Added colors to answer to indicate correct (Green) or wrong (Red) answers 
* Added button so the user can control when to go to the next question. 
* Button is disabled until an answer is selected.
* User gets only once chance to pick the right answer, the button will flash if the user tries to change an answer


## App Features Demo
![App Demo](Demo/A1.gif)


## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).