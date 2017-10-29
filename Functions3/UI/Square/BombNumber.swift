//
//  BombNumber.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

final class BombNumber: Square {

    var isInvisible = false

    convenience init(with number: Int)
    {
        self.init()
        self.number = number
        squareType = .bomb

        setUpEvent()
    }

    override func fireEvent() {
        super.fireEvent()

        tile?.fillColor = isInvisible ? FStyle.fNumberColor() : UIColor.black
        isInvisible = !isInvisible
    }
}
