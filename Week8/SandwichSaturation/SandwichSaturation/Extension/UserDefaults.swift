//
//  UserDefaults.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 18/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

extension UserDefaults {

    private enum Keys {

        static let DidSeedPersistentStore = "didSeedPersistentStore"

    }

    class func setDidSeedPersistentStore(_ didSeedPersistentStore: Bool) {
        UserDefaults.standard.set(didSeedPersistentStore, forKey: Keys.DidSeedPersistentStore)
    }

    class var didSeedPersistentStore: Bool {
        return UserDefaults.standard.bool(forKey: Keys.DidSeedPersistentStore)
    }

}
