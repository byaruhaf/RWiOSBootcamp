# ColorSlider App


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Twitter](https://img.shields.io/badge/twitter-@byaruhaf-blue.svg)](http://twitter.com/byaruhaf)


## Week 1 Assignment: ColorSlider App

ColorSlider is a Color Picker App with both RGB and HSB modes. The app can be used with any iPhone that supports **[iOS 13](https://support.apple.com/en-il/guide/iphone/iphe3fa5df43/ios)**

### Assigment Requirements completed
* Users can pick a Red, Blue and Green value using sliders and use the resulting values to change color of the background of the app.
* The sliders should default to the leftmost position, and the labels should show 0 by default, when reset and when booted up.
* When moving a slider, the label to its right should update with an integer from 0 - 255.
* When the “Set Color” button is hit, an alert should appear asking the user to enter a color name
* Once a name is entered and the user presses “Enter” on the keyboard, the background of the app should change to a color corresponding to the RGB values entered by the sliders and their color name should appear in the top label.
* The alpha value should be hard-coded to 1.0.
* When “Reset” is hit, the sliders, labels and background color should return to the default values.
* The app should have a splash screen and app icon.
* The app should work in landscape and portrait orientation.
* The app should have an info button that presents the wikipedia page for RGB. That page should have a Close button to dismiss it.

### Stretch  Assignment Goal completed

* app functionality expanded to allow the user to use either RGB or HSB.
* Modify max range on the slider based on color mode
* Title labels adapt from “Red”, “Green” and “Blue” to be “Hue”, “Saturation” and “Brightness” depending on the mode selected.
* Change of mode resets the to defaults 
* select different color calculation based on the color mode HSB or RGB

### Additional Assignment Goals completed
* app functionality expanded to allow the user to use either sRGB p3RGB or HSB.
* app functionality expanded to save the current state to user defaults
* app functionality expanded to  Hex values for each color mode.


### Modes
sRGB Mode             |  HSB Mode	            | p3RGB Mode
:-------------------------:|:-------------------------:|:---------------------
![sRGB](https://i.imgur.com/yQEEJB9.png)  |  ![HSB](https://i.imgur.com/ro18QmQ.png) | ![p3RGB](https://i.imgur.com/iR5eMzZ.png) 

## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).
