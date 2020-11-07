//
//  ExactMethod.swift
//  Functions3
//
//  Created by Erdi on 7.12.2018.
//  Copyright © 2018 ekanik. All rights reserved.
//

class ExactMethod: NSObject {
    private enum ValueType: Int {
        case positive
        case negative
    }
    
    private enum StateType: Int {
        case exact
        case different
    }
    
    private var total = 0
    private var valueType: ValueType
    private var stateType: StateType
    private var number: Int = 0
    
    override init() {
        let valueResult = Int(FMath.getRandomGenerator(givenRange: 0, withSecond: 1))
        let stateResult = Int(FMath.getRandomGenerator(givenRange: 0, withSecond: 1))
        valueType = ValueType(rawValue: valueResult)!
        stateType = StateType(rawValue: stateResult)!
        
        number = Int(FMath.getRandomGenerator(givenRange: 15, withSecond: 50)) *
            (valueType == .negative ? -1 : 1)
    }
    
    func methodDescription() -> String {
        var resultString = ""
        
        if stateType == .exact {
            resultString = "EXACT"
        } else {
            if valueType == .positive {
                resultString = "GREATER THAN"
            } else {
                resultString = "LOWER THAN"
            }
        }
        
        resultString += " " + String(number)
        
        return resultString
    }
    
    func add(value: Int) {
        total += value
    }
    
    func isCompleted() -> Bool {
        if stateType == .exact && total == number {
            return true
        }
        
        if stateType == .different {
            switch(valueType) {
            case .positive:
                return total >= number
            case .negative:
                return total <= number
            }
        }
        
        return false
    }
}
