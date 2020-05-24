//
//  ScoreViewController.swift
//  One to 50
//
//  Created by Balaganesh S on 29/03/20.
//  Copyright © 2020 Balaganesh. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreCommentLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    public var scoreValue = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roundedValue = Float(round(100 * scoreValue) / 100)
        scoreLabel.text = String(roundedValue)
        scoreLabel.textColor = .firstColor
        scoreCommentLabel.numberOfLines = 0
        scoreCommentLabel.lineBreakMode = .byWordWrapping
        
        if (roundedValue < 25) {
            scoreCommentLabel.text = .impossible
        } else if (roundedValue >= 25 && roundedValue < 35) {
            scoreCommentLabel.text = .awesome
        } else if (roundedValue >= 35 && roundedValue < 40) {
            scoreCommentLabel.text = .great
        } else if (roundedValue >= 40 && roundedValue < 50) {
            scoreCommentLabel.text = .notBad
        } else if (roundedValue >= 50 && roundedValue < 60) {
            scoreCommentLabel.text = .doItWell
        } else if (roundedValue >= 60 && roundedValue < 70) {
            scoreCommentLabel.text = .tryAgain
        } else if (roundedValue >= 70 && roundedValue < 80) {
            scoreCommentLabel.text = .slow
        } else {
            scoreCommentLabel.text = .verySlow
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension String {
    
    static let impossible = "Impossible!!!"
    static let awesome = "Awesome!!"
    static let great = "Great!"
    static let notBad = "Not bad, but average."
    static let doItWell = "You can do it well."
    static let tryAgain = "Try again!"
    static let slow = "Slow. Try again!"
    static let verySlow = "Very slow. Try again!"
}
