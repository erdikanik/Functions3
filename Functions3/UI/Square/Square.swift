//
//  Square.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

import Foundation
import SpriteKit

protocol SquareDelegate: class {
    func squareTapped(number: Number)
}

enum SquareType: Int {
    case number
    case changableNumber
    case invisibleNumber
    case bomb
    case material
}

enum MaterialType: Int {
    case golden
    case diamond
    case emerald
}

enum SquareConstants {
    static let numberSize: CGFloat = 30
    static let numberFontSizeFactor: CGFloat = 0.5
    static let numberWaitForDuration: CGFloat = 1
}

class Square: FSpriteNodeBase {
    
    var number: Int?
    var edge: CGFloat?
    var squareType: SquareType?
    var materialType: MaterialType?
    
    weak var delegate: SquareDelegate?
    
    init() {
        super.init(texture: nil, color: FStyle.fNumberColor(),
                   size: CGSize.init(width: SquareConstants.numberSize, height: SquareConstants.numberSize))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
