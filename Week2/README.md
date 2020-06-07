# BullsEye Game App Collection 


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Twitter](https://img.shields.io/badge/twitter-@byaruhaf-blue.svg)](http://twitter.com/byaruhaf)


## Week 2 Assignment

ColorSlider is a Color Picker App with both RGB and HSB modes. The app can be used with any iPhone that supports **[iOS 13](https://support.apple.com/en-il/guide/iphone/iphe3fa5df43/ios)**

### Assigment Requirements completed
* Users can pick a Red, Blue and Green value using sliders

### Stretch Above and Beyond Requirements completed:
* “reverse” the BullsEye game to use a text field.
* Restrict users to enter only numberic values in to the text field for the RevBullsEye
* User can dissmiss the keyboard using two methords for the RevBullsEye
 	1. Tap screen
	2. Tap done button 
 

### Additional Assignment Goals completed
* Groups all game projects and packages under one xcode workspace so its easier to work on them together
* Model code for games BullsEye & RevBullsEye moved to Swift Package to avoid duplicating code.
* As an SPM Package model code can be distributed to other developer to make their own version of BullsEye
* Use Apples Combine framework to so UI can lissten for changes in the model 

### Class vs Struct:
My personal preference is always start with a struct, why you wonder. Because Crusty said so.

![Crusty](https://i.imgur.com/604g7JU.jpg) 

Jokes Aside, The reason i prefer structs are the value semantics esapcaly mutabilty.

But as game model required **mutation** 
I changed the model to a class to avoid adding mutation keyword to all my model funcitons.
The next version of the 3 games could be rewritten for **MVVM** so the **model** is a struct & the **view model** is a class.  

### Shared Game assets :
The shared game assets could also be moved from the indivaual game project to Swift Package.
The feature **[SE-0271:Package Manager Resources](https://github.com/apple/swift-evolution/blob/master/proposals/0271-package-manager-resources.md)** will be available in swift 5.3. So next version of BullsEye & RevBullsEye can take advantage of that. 

### Game App
!Put Screenshots heree!

## Contribution
<a href='https://www.freepik.com/free-photos-vectors/background'>Background vector created by upklyak - www.freepik.com</a>

<a href="https://www.freepik.com/free-photos-vectors/star">Star vector created by upklyak - www.freepik.com</a>

<a href="https://www.vecteezy.com/free-vector/exact">Exact Vectors by Vecteezy</a>

<a href="https://www.vecteezy.com/free-vector/game-background">Game Background Vectors by Vecteezy</a>

<a href="https://www.freepik.com/free-photos-vectors/background">Background vector created by upklyak - www.freepik.com</a>

<a href="https://www.freepik.com/free-photos-vectors/star">Star vector created by vectorpouch - www.freepik.com</a>

## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).
