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
    static let gameLogicRandomFunctionsDuration: Float = 500
}

@objc protocol GameLogicDelegate: class {
    func gameLogic(_ gameLogic: GameLogic, time:TimeInterval, gameOvered: Bool)
    func gameLogic(_ gameLogic: GameLogic, functionResulted result: Int)
    func gameLogic(_ gameLogic: GameLogic, functionChanged function: ExactMethod)
    func gameLogic(_ gameLogic: GameLogic, functionTimeDidChanged time: Float)
    func gameLogic(_ gameLogic: GameLogic, levelChanged level: Int)
}

@objc class GameLogic: NSObject {
    weak var delegate: GameLogicDelegate?
    @objc var number: Int = 0 {
        didSet {
            if let num = polynomal?.getValue(CGFloat(number)) {
                let result = Double(num)
                score += result > 0 ? result * 0.05 : 0
                scoreTime += result > 0 ? result * 0.2 : result + (Double(self.level) * 0.01)
                delegate?.gameLogic(self, functionResulted: Int(result))
            }
        }
    }

    var score: Double = 0

    private var scoreTime: TimeInterval = 1
    private var timer: Timer?
    private var functionTimer: Timer?
    private var polynomal: Polynomal?
    private var exactMethod: ExactMethod?
    private var functionChangingTime: Float = 0
    private var level: Int = 1
    private var initialTime: Int = 100
    private var latestResult = 0

    required init(gameOverTime: TimeInterval) {
        super.init()
        self.scoreTime = gameOverTime
    }

    func gameStarted() {
        randomFunction()
        self.functionChangingTime = Constants.gameLogicRandomFunctionsDuration
        self.timer = Timer.scheduledTimer(withTimeInterval: Constants.gameLogicWaitDuration, repeats: true) {
            [weak self] (timer) in

            guard let strongSelf = self else {
                return
            }

            if strongSelf.scoreTime <= 0 {
                strongSelf.timer?.invalidate()
                strongSelf.delegate?.gameLogic(strongSelf, time: strongSelf.scoreTime, gameOvered: true)
            } else {
                strongSelf.scoreTime -= Constants.gameLogicWaitDuration
                strongSelf.delegate?.gameLogic(strongSelf, time: strongSelf.scoreTime, gameOvered: false)
            }

            strongSelf.delegate?.gameLogic(strongSelf, functionTimeDidChanged: strongSelf.functionChangingTime / 10)
            strongSelf.functionChangingTime -= 1

            if strongSelf.functionChangingTime <= 0 {
                strongSelf.randomFunction()
                strongSelf.functionChangingTime = Constants.gameLogicRandomFunctionsDuration
            }

            strongSelf.initialTime += 1
            strongSelf.levelDetection()
        }
    }

    private func randomFunction() {
        exactMethod = ExactMethod()
        delegate?.gameLogic(self, functionChanged: exactMethod!)
    }

    private func levelDetection() {

        let doubleLevel = Double(level)
        let formula = 100 * doubleLevel * (level > 20 ? doubleLevel * (doubleLevel * 0.1) : 5)
        if (initialTime / Int(formula)) > 0 {
            level += 1
            delegate?.gameLogic(self, levelChanged: level)
        }
    }
}
