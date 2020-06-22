//
//  customoperator.swift
//  ComparisonShopper
//
//  Created by Franklin Byaruhanga on 20/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
//  Thank you, Ole Begemann
//  https://oleb.net/blog/2016/12/optionals-string-interpolation/
//

import Foundation


// MARK: Operator Declaration
infix operator ??? : NilCoalescingPrecedence


// MARK: Operator Implementation
public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    return optional.map { String(describing: $0) } ?? defaultValue()
}
