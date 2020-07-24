

import Foundation
import UIKit

extension UIProgressView {
    
    func animate(duration: Double) {
        
        setProgress(0.01, animated: true)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.setProgress(1.0, animated: true)
        }, completion: nil)
    }
}

// I've had to use a lot of progress bars in my projects. This animates the progress bar like a countdown.
// How it's used: progressBar.animate(duration: 10)
