# Cryptly App 


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.2-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Twitter](https://img.shields.io/badge/twitter-@byaruhaf-blue.svg)](http://twitter.com/byaruhaf)


## Week 3 Assignment

Create an app called Cryptly that displays prices of cryptocurrencies

### Assignment Requirements completed
* Create an app data model CryptoCurrency
* Decode JSON data to the app data model
* Update the user interface based on the app data model. 
* use only filter() and/or reduce() to extract view data from the model 
* use protocols and NotificationCenter to change app theme based on the toggle button state

### Stretch Above and Beyond Requirements completed:
* Refactor setupViews() function in to a custom UIView
* Add trend & percentageRise variables to the app model
* Display Most Falling and Most Rising cryptocurrencies
* create a Roundable protocol for a custom view restricted to the class UIView.
 

### Additional Assignment Goals completed
* Added ViewModel to prepare the model data for the view. 
* Added animation during the change of theme's
* Added network component to fetch data from a remote [Nomics API](api.nomics.com)
* Using swift's Result type for the Asynchronous completion handler
* Disabled dark mode on the app



## App Demo

![Light2Dark](Demo/Light2Dark.gif)

|Light Mode|Dark Mode|
|:-------------------------:|:-------------------------
|![CryptlyLight](Demo/CryptlyLight.png)  |  ![CryptlyDark.png](Demo/CryptlyDark.png) |

## Attribution
App logo by [TempusInfernus](https://en.wikipedia.org/wiki/File:Cryptocurrency_Logo.svg)


## Contribution
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**


## License
[MIT License](https://github.com/byaruhaf/RWiOSBootcamp/blob/master/LICENSE).
