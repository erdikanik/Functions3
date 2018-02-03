//
//  FunctionBoard.swift
//  Functions3
//
//  Created by Erdi Kanık on 26.01.2018.
//  Copyright © 2018 ekanik. All rights reserved.
//

import Foundation

class FunctionBoard: FSpriteNodeBase {
    
    var text: String? {
        didSet {
            functionLabel?.text = text
            repeatAction(with: 0.1, selector: #selector(functionColorChanged), count: 10) {
                self.tile?.fillColor = FStyle.fNumberColor()
            }
        }
    }
    
    var timeText: String? {
        didSet {
            timeLabel?.text = timeText
        }
    }
    
    var promotionNumber = 0 {
        didSet {
            promotionLabel?.text = "\(promotionNumber)f"
        }
    }
    
    var functionLabel: SKLabelNode?
    var tile: SKShapeNode?
    var timeLabel: SKLabelNode?
    var promotionLabel: SKLabelNode?
    
    init(with size: CGSize) {
        super.init(color: FStyle.fNumberColor(), size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        let tile = SKShapeNode()
        tile.path = CGPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerWidth: 5, cornerHeight: 5, transform: nil)
        tile.fillColor = self.color
        tile.strokeColor = FStyle.fNumberTextColor()
        color = .clear
        addChild(tile)

        self.tile = tile
        
        let functionLabel = SKLabelNode(fontNamed: FStyle.fMainFont())
        functionLabel.fontSize = 15
        functionLabel.verticalAlignmentMode = .center
        functionLabel.horizontalAlignmentMode = .center
        functionLabel.fontColor = FStyle.fNumberTextColor()
        addChild(functionLabel)
        functionLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
    
        self.functionLabel = functionLabel
        
        let timeLabel = SKLabelNode(fontNamed: FStyle.fMainFont())
        timeLabel.fontSize = 14
        timeLabel.verticalAlignmentMode  = .center
        timeLabel.horizontalAlignmentMode = .left
        timeLabel.fontColor = FStyle.fNumberTextColor()
        addChild(timeLabel)
        timeLabel.position = CGPoint(x: size.width * 0.05, y: size.height * 0.8)
        
        self.timeLabel = timeLabel
        
        let promotionLabel = SKLabelNode(fontNamed: FStyle.fMainFont())
        promotionLabel.fontSize = 17
        promotionLabel.verticalAlignmentMode = .center
        promotionLabel.horizontalAlignmentMode = .right
        promotionLabel.fontColor = FStyle.fNumberTextColor()
        addChild(promotionLabel)
        promotionLabel.position = CGPoint(x: size.width * 0.95, y: size.height * 0.8)
        
        self.promotionLabel = promotionLabel
    }
    
    @objc private func functionColorChanged() {
        self.tile?.fillColor = FStyle.getRandomColor()
    }
}
