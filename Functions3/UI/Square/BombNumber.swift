//
//  BombNumber.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

final class BombNumber: Square {

    var isInvisible = false

    init(with number: Int)
    {
        super.init()
        self.number = number
        squareType = .bomb

        setUpEvent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fireEvent() {
        super.fireEvent()

        tile?.fillColor = isInvisible ? FStyle.fNumberColor() : UIColor.black
        isInvisible = !isInvisible
    }
}
