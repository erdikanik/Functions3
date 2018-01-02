//
//  Board.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

@objc protocol BoardDelegate: class {
    func board(board: Board, didTappedSquare square: Square)
}

class Board: FSpriteNodeBase {
    let boardLogic = FBoardLogic()
    var squares :[[Square]] = [[Square]]()
    var exceed = false
    weak var delegate: BoardDelegate?

    init(with size: CGSize) {
        super.init(color: FStyle.fMainDarkColor(), size: size)

        boardLogic.boardSize = size

        for _ in 0..<kFBoardTotalWidthSquareNumber {
            squares.append([Square]())
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        produceRandomSquare()
    }

    private func produceRandomSquare() {
        repeatAction(with: 3, selector: #selector(produceSquare), count: 1) {
            self.produceRandomSquare()
        }
    }

    @objc private func produceSquare() {
        guard let square = Square.getRandomSquare() else {
            return
        }

        square.isMoving = true
        square.delegate = self
        square.edge = boardLogic.numberEdgeSizes()
        square.position = boardLogic.fNumberStartPoint()
        let lastNumber = boardLogic.lastColumnNumber
        square.columnIndex = lastNumber

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
        if squares[lastNumber].count > kFBoardGameOverSquareNumber && !exceed {
            exceed = true
        }
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

    func reassignDestinationPointsAndMoveTo(index: Int, arrayIndex: Int) {
        guard index + 1 < squares[arrayIndex].count else {
            return
        }

        for idx in (index+1)..<squares[arrayIndex].count {
            let square = squares[arrayIndex][idx]
            square.isMoving = true
            square.moveToPoint = CGPoint(x: square.moveToPoint.x, y: square.moveToPoint.y - boardLogic.numberEdgeSizes())
            let distance = fabs(square.moveToPoint.y - square.position.y)
            let liftOff = SKAction.move(to: square.moveToPoint, duration: calculateTime(with: distance))
            square.run(liftOff, completion: {
                square.isMoving = false
            })
        }
    }
}

// MARK: - SquareDelegate

extension Board: SquareDelegate {
    func squareTapped(square: Square) {

        let squareIndex = squares[square.columnIndex].index { $0 == square}

        if squareIndex == nil {
            return
        }
        
        if square.squareType == .bomb && !square.isMoving {
            explodeSurroundingsNumbers(square: square)
            return
        }

        reassignDestinationPointsAndMoveTo(index: squareIndex!,
                                           arrayIndex: square.columnIndex)

        if let squareIndex = squareIndex {
            squares[square.columnIndex].remove(at: squareIndex)
        }

        square.removeFromParent()
        delegate?.board(board: self, didTappedSquare: square)
    }
}

// MARK: Bombers

extension Board {

    func explodeSurroundingsNumbers(square: Square) {
        let squareIndex = squares[square.columnIndex].index {$0 == square}
        if squareIndex != nil {
            if square.columnIndex > 0 {
                removeSquaresAtColumn(with: square.columnIndex - 1,
                                      squareIndex: squareIndex!)
            }

            if square.columnIndex < Int(kFBoardTotalWidthSquareNumber - 1) {
                removeSquaresAtColumn(with: square.columnIndex + 1,
                                      squareIndex: squareIndex!)
            }

            removeSquaresAtColumn(with: square.columnIndex,
                                  squareIndex: squareIndex!)

        }
    }

    func removeSquaresAtColumn(with columnIndex: Int, squareIndex: Int) {
        removeFromColumnIfItIsNotMoving(columnIndex: columnIndex,
                                        squareIndex: squareIndex + 1)
        removeFromColumnIfItIsNotMoving(columnIndex: columnIndex,
                                        squareIndex: squareIndex)
        if squareIndex > 0 {
            removeFromColumnIfItIsNotMoving(columnIndex: columnIndex,
                                            squareIndex: squareIndex - 1)
        }
    }

    func removeFromColumnIfItIsNotMoving(columnIndex: Int, squareIndex: Int) {

        if squares[columnIndex].count <= squareIndex {
            return
        }

        let previousNumber = squares[columnIndex][squareIndex]


        
        if !previousNumber.isMoving {
            previousNumber.explodeNumber(with: { [unowned self] in
                let previousNumberIndex = self.squares[columnIndex].index { $0 == previousNumber}
                self.reassignDestinationPointsAndMoveTo(index: previousNumberIndex!, arrayIndex: columnIndex)
                self.squares[columnIndex].remove(at: previousNumberIndex!)
                previousNumber.removeFromParent()
            })

        }
    }
}
