//
//  StartViewController.swift
//  Functions3
//
//  Created by Erdi Kanık on 26.01.2018.
//  Copyright © 2018 ekanik. All rights reserved.
//

import Foundation
import GameKit
import GoogleMobileAds

class StartViewController: BaseViewController {
    @IBOutlet private weak var maximumScoreLabel: UILabel!
    fileprivate var authenticated = false
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticatePlayer()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMaximumScore()
        addScoreToLeaderboard()
    }
    
    @IBAction func leaderboardButtonTapped(_ sender: Any) {
        if GKLocalPlayer.local.isAuthenticated {
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
        
        let localPlayer = GKLocalPlayer.local
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

extension StartViewController {
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}

extension StartViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
