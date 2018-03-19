//
//  SpeedAndDirection.swift
//  Tenis
//
//  Created by 1 on 13.03.2018.
//  Copyright © 2018 ANDRE.CORP. All rights reserved.
//

import Foundation
import UIKit

enum HorizontalDirection {
    case Left
    case Right
}
enum VerticalDirection {
    case Up
    case Down
}
struct Speed {
    var horizontalSpeed: CGFloat = 3
    var verticalSpeed: CGFloat = 3
    
    init(speed: CGFloat) {
        self.horizontalSpeed = speed
        self.verticalSpeed = speed
    }
}
struct Direction {
    var horizontal: HorizontalDirection
    var vertical: VerticalDirection
    init(horizontal: HorizontalDirection, vertical: VerticalDirection) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
