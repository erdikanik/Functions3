//
//  StartViewController.swift
//  Functions3
//
//  Created by Erdi Kanık on 26.01.2018.
//  Copyright © 2018 ekanik. All rights reserved.
//

import Foundation
import GameKit

class StartViewController: BaseViewController {
    @IBOutlet private weak var maximumScoreLabel: UILabel!
    fileprivate var authenticated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticatePlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMaximumScore()
        addScoreToLeaderboard()
    }
    
    @IBAction func leaderboardButtonTapped(_ sender: Any) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            checkLeaderboard()
        } else {
            authenticatePlayer()
        }
    }
    
    private func loadMaximumScore() {
        let totalPoint = UserDefaults.standard.integer(forKey: "totalPoint")
        maximumScoreLabel.text = "HIGHEST SCORE\n" + "\(totalPoint)"
    }
}

// MARK: - GameKit
extension StartViewController {
    fileprivate func authenticatePlayer() {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { [weak self] (viewController, error) -> Void in
            if let viewController = viewController {
                self?.present(viewController, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self?.authenticated = true
            }
        }
    }
    
    fileprivate func addScoreToLeaderboard() {
        let totalPoint = UserDefaults.standard.integer(forKey: "totalPoint")
        
        let bestScore = GKScore(leaderboardIdentifier: ApplicationIds.leaderboardId)
        bestScore.value = Int64(totalPoint)
        GKScore.report([bestScore], withCompletionHandler: nil)
    }
    
    fileprivate func checkLeaderboard() {
        let gameController = GKGameCenterViewController()
        gameController.gameCenterDelegate = self
        gameController.viewState = .leaderboards
        gameController.leaderboardIdentifier = ApplicationIds.leaderboardId
        present(gameController, animated: true, completion: nil)
    }
}

// MARK: - GKGameCenterControllerDelegate
extension StartViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
