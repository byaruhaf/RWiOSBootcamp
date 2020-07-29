import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Animations
//: In **Use a Group of Tasks**, you learned how you can use GCD dispatch groups to be notified when a set of GCD tasks completes, and how you can wrap an existing asynchronous API to use dispatch groups.
//: 
//: __Homework:__ The `UIView` animation API is asynchronous, but doesn't make it easy to determine when multiple simultaneous animations complete. Your challenge is to extend the `UIView` animation API to accept a `DispatchGroup` argument, and hence determine when a set of animations completes.
//:
//: **Step 1**: Implement this new `UIView` function:
extension UIView {
  static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?) {
    
  // TODO: Fill in this implementation
  
  }
}
//: ## Setup
// Use this dispatch group:
let animationGroup = DispatchGroup()
// This should only print once all the animations are complete
animationGroup.notify(queue: DispatchQueue.main) {
  print("Animations Completed!")
}
//: ## Views
//: The animation uses the following views
// A red square
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red
// A yellow box
let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
box.backgroundColor = UIColor.yellow
view.addSubview(box)
// Note: Enable Xcode▸Editor▸Live View to see the animation.
PlaygroundPage.current.liveView = view
//: **Step 2**: Rewrite the following animation to be notified when all sub-animations complete:
UIView.animate(withDuration: 1, animations: {
  // Move box to lower right corner
  box.center = CGPoint(x: 150, y: 150)
  }, completion: {
    _ in
    UIView.animate(withDuration: 2, animations: {
      // Rotate box 45 degrees
      box.transform = CGAffineTransform(rotationAngle: .pi/4)
      }, completion: .none)
})

UIView.animate(withDuration: 4, animations: { () -> Void in
  // Change background color to blue
  view.backgroundColor = UIColor.blue
})
//: __Note:__ Manually stop execution of this playground when the animation finishes: click the stop button below.
