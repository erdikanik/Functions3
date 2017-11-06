//
//  SKAction+Additions.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

extension SKNode {

    func repeatAction(with duration: TimeInterval, selector: Selector, count: Int, completion:@escaping ()->()) {

        let wait = SKAction.wait(forDuration: duration)
        let perform = SKAction.perform(selector, onTarget: self)
        let sequence = SKAction.sequence([wait, perform])
        let repeatAction = SKAction.repeat(sequence, count: count)

        self.run(repeatAction) {
            completion()
        }
    }

    func repeatActionForever(with duration: TimeInterval, selector: Selector) {
        let wait = SKAction.wait(forDuration: duration)
        let perform = SKAction.perform(selector, onTarget: self)
        let sequence = SKAction.sequence([wait, perform])
        let repeatAction = SKAction.repeatForever(sequence)
        self.run(repeatAction)
    }
}
