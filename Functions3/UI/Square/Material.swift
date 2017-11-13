//
//  Material.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

final class Material: Square {
    init(with materialType: MaterialType) {
        super.init()
        self.squareType = .material
        self.materialType = materialType
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setInnerShapeProperties() {
        super.setInnerShapeProperties()

        innerShape = FSpriteNodeBase(imageNamed: shapeInnerImage())

        if  let innerShape = innerShape {
            innerShape.isUserInteractionEnabled = false
            innerShape.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            addChild(innerShape)
            innerShape.position = CGPoint(x: size.width / 2, y: size.height / 2)
            innerLabel?.text = ""
        }
    }

    func shapeInnerImage() -> String {

        switch materialType {
        case .golden:
            return "golden"
        case .diamond:
            return "diamond"
        case .emerald:
            return "emerald"
        }
    }
}
