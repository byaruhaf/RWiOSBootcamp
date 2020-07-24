

import Foundation
import UIKit

extension UITableView {
    
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func hideExcessCells() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
}

// It's annoying to always have to type out the block of code to update a UITableView
// on the main thread. So I moved it to an extension

// How it's used: tableView.reloadOnMainThread()
