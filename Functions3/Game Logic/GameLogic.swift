//
//  GameLogic.swift
//  Functions3
//
//  Created by Erdi Kanik on 11.11.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

import Foundation

fileprivate enum Constants {
    static let gameLogicWaitDuration: TimeInterval = 0.01
    static let gameLogicRandomFunctionsDuration: TimeInterval = 10
}

@objc protocol GameLogicDelegate: class {
    func gameLogic(_ gameLogic: GameLogic, time:TimeInterval, gameOvered: Bool)
    func gameLogic(_ gameLogic: GameLogic, functionResulted result: Int)
    func gameLogic(_ gameLogic: GameLogic, functionChanged function: Polynomal)
}

@objc class GameLogic: NSObject {
    weak var delegate: GameLogicDelegate?
    @objc var number: Int = 0 {
        didSet {
            if let num = polynomal?.getValue(CGFloat(number)) {
                let totalNumber = Double(num)
                score += totalNumber * 0.1
                scoreTime += totalNumber * 0.5
                delegate?.gameLogic(self, functionResulted: Int(totalNumber))
            }
        }
    }
    var score: Double = 0

    private var scoreTime: TimeInterval = 1
    private var timer: Timer?
    private var functionTimer: Timer?
    private var methodTimer: Timer?
    private var totalNumber = 0
    private var polynomal: Polynomal?

    private var initialTime: TimeInterval = 1


    required init(with gameOverTime: TimeInterval) {
        super.init()
        self.initialTime = gameOverTime
        self.scoreTime = gameOverTime
    }

    func gameStarted() {
        Timer.scheduledTimer(withTimeInterval: Constants.gameLogicWaitDuration, repeats: true) { [weak self] (timer) in
            if (self?.scoreTime)! <= 0 {
                self?.timer?.invalidate()
                self?.delegate?.gameLogic(self!, time: (self?.scoreTime)!, gameOvered: true)
            } else {
                self?.scoreTime -= Constants.gameLogicWaitDuration
                self?.delegate?.gameLogic(self!, time: (self?.scoreTime)!, gameOvered: false)
            }
        }

        initializeRandomFunction()
    }

    func initializeRandomFunction() {
        functionTimer = Timer.scheduledTimer(withTimeInterval: Constants.gameLogicRandomFunctionsDuration,
                                             repeats: true,
                                             block: { (timer) in
            self.randomFuntion()
        })
    }

    private func randomFuntion() {
        polynomal = Functions.getRandomFunction()
        delegate?.gameLogic(self, functionChanged: polynomal!)
    }
}
