//
//  Board.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class Board: FSpriteNodeBase {
    let boardLogic = FBoardLogic()
    var squares :[[Square]] = [[Square]]()
    var exceed = false

    init(with size: CGSize) {
        super.init(color: FStyle.fMainDarkColor(), size: size)

        boardLogic.boardSize = size

        for i in 0..<kFBoardTotalWidthSquareNumber {
            squares[Int(i)] = [Square]()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {


    }

    private func produceRandomSquare() {
        repeatAction(with: 3, selector: #selector(produceSquare), count: 1) {
            self.produceRandomSquare()
        }
    }

    func produceSquare() {
        guard let square = Square.getRandomSquare() else {
            return
        }

        square.isMoving = true
        square.delegate = self
        square.edge = boardLogic.numberEdgeSizes()
        square.position = boardLogic.fNumberStartPoint()
        let lastNumber = boardLogic.lastColumnNumber

        resetRowArray(with: Int(lastNumber))
        addChild(square)
        calculateDestinationPoint(with: square)
        let distance = fabs(square.moveToPoint.y - square.position.y)
        let liftOff = SKAction.move(to: square.moveToPoint, duration: calculateTime(with: distance))
        let rep = SKAction.sequence([liftOff])
        square.run(rep) {
            square.isMoving = false
        }

    }

    func resetRowArray(with lastNumber: Int) {
        // exceed control
    }

   // func reassignDestinationPointsMoveTo:()
}

// MARK: - Helpers

extension Board {
    func calculateDestinationPoint(with square: Square) {
        squares[boardLogic.lastColumnNumber].append(square)
        let index = squares[boardLogic.lastColumnNumber].count - 1
        square.moveToPoint = CGPoint(x: square.position.x, y: boardLogic.numberEdgeSizes() * CGFloat(index))
    }

    func calculateTime(with distance: CGFloat) -> TimeInterval {
        return TimeInterval(distance / 60)
    }
}

// MARK: - SquareDelegate

extension Board: SquareDelegate {
    func squareTapped(square: Square) {

    }
}
