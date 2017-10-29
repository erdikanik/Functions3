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
    func squareTapped(number: Square)
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
    static let numberWaitForDuration: TimeInterval = 1
}

class Square: FSpriteNodeBase {
    
    var number: Int? {
        didSet {
            innerLabel?.text = String(describing: number)
        }
    }
    var squareType: SquareType?
    var materialType: MaterialType?
    var moving = false
    var innerLabel: SKLabelNode?
    var innerShape: FSpriteNodeBase?
    var tile: SKShapeNode?

    var edge: CGFloat? {
        didSet {
            if let edge = edge {
                size = CGSize(width: edge, height: edge)
                updateInnerLabelProperties()
            }
        }
    }

    weak var delegate: SquareDelegate?
    
    init() {
        super.init(texture: nil, color: FStyle.fNumberColor(),
                   size: CGSize.init(width: SquareConstants.numberSize, height: SquareConstants.numberSize))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpEvent() {
        let wait = SKAction.wait(forDuration: SquareConstants.numberWaitForDuration)
        let performSelector = SKAction.perform(#selector(fireEvent), onTarget: self)
        let sequence = SKAction .sequence([wait, performSelector])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction)
    }

    func fireEvent() {
        // override
    }

    func updateInnerLabelProperties() {
        tile = SKShapeNode()
        tile?.path = CGPath.init(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerWidth: 5, cornerHeight: 5, transform: nil)
        tile?.strokeColor = FStyle.fNumberTextColor()
        tile?.fillColor = color
        color = UIColor.clear

        innerLabel = SKLabelNode(fontNamed: FStyle.fMainFont())
        innerLabel?.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        innerLabel?.verticalAlignmentMode = .center
        innerLabel?.horizontalAlignmentMode = .center
        innerLabel?.fontSize = size.height * SquareConstants.numberFontSizeFactor
        innerLabel?.fontColor = FStyle.fNumberTextColor()
        innerLabel?.text = String(describing: number)
        innerLabel?.position = CGPoint(x: size.width / 2,y: size.height / 2)

        setInnerShapeProperties()

        guard let tile = tile, let innerLabel = innerLabel else {
            return
        }

        addChild(tile)
        addChild(innerLabel)
    }

    func setInnerShapeProperties() {
        // override
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        delegate?.squareTapped(number: self)
    }
}
