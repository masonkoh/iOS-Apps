//
//  Settings.swift
//  ColorSwitch
//
//  Created by Mason Ko on 2019-02-19.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0 // unsigned 32 bit integer // we don't want any physical assimilation(?)
    static let ballCategory: UInt32 = 0x1           // 01
    static let switchCategory: UInt32 = 0x1 << 1    // 10
}
