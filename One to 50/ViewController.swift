//
//  ViewController.swift
//  One to 50
//
//  Created by Balaganesh S on 29/03/20.
//  Copyright © 2020 Balaganesh. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell {
    
    var value: Int!
    var isFlipped: Bool = false
    
    @IBOutlet weak var valueLabel: UILabel!
}

class ViewController: UIViewController {

    let reuseIdentifier = "GridViewCell"
    
    var firstHalf: Array = Array(1...25)
    var secondHalf: Array = Array(26...50)
    
    var currentValue = 1
    
    var timer: Timer!
    var startTime = TimeInterval()
    var scoreValue = TimeInterval()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var numbersGridView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstHalf.suffle()
        secondHalf.suffle()
        
        numbersGridView.dataSource = self
        numbersGridView.delegate = self
        
        restartButton.tintColor = .firstColor
        restartButton.layer.borderColor = UIColor.firstColor.cgColor
        restartButton.layer.borderWidth = 1
        restartButton.layer.cornerRadius = 5.0
        
        timerLabel.text = String(scoreValue)
    }
    
    
    @IBAction func restartTapped(_ sender: Any) {
        restartGame()
    }
    
    func startGame() {
        startTime = Date.timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer) in
            let currentTime = Date.timeIntervalSinceReferenceDate
            self.scoreValue = currentTime - self.startTime
            DispatchQueue.main.async {
                let roundedValue = Float(round(100 * self.scoreValue) / 100)
                self.timerLabel.text = String(roundedValue)
            }
        })
    }
    
    func restartGame() {
        stopTimer()
        currentValue = 1
        scoreValue = TimeInterval()
        timerLabel.text = String(scoreValue)
        firstHalf.suffle()
        secondHalf.suffle()
        numbersGridView.reloadData()
    }
    
    func stopTimer() {
        if (timer != nil) {
            timer.invalidate()
            timer = nil
        }
    }
    
    func showScore() {
        
        stopTimer()
        
        let scoreViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        scoreViewController.scoreValue = scoreValue
        
        self.present(scoreViewController, animated: true, completion: { [unowned self] in
            self.restartGame()
        })
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GridViewCell
        
        cell.backgroundColor = .firstColor
        cell.isFlipped = false
        cell.value = firstHalf[indexPath.item]
        cell.valueLabel.text = String(firstHalf[indexPath.item])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! GridViewCell
        
        if (currentValue == 1 && cell.value == 1) {
            startGame()
        } else if (currentValue == 50) {
            showScore()
            return
        }
        
        if (cell.value == currentValue) {
            
            currentValue += 1
            if (!cell.isFlipped) {
                cell.value = secondHalf[indexPath.item]
                cell.valueLabel.text = String(secondHalf[indexPath.item])
                cell.backgroundColor = .secondColor
                cell.isFlipped = true
            } else {
                cell.backgroundColor = .white
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 20) / 5
        let height = (collectionView.frame.height - 20) / 5
        
        return CGSize(width: width, height: height)
    }
}

extension Array {
    
    mutating func suffle() {
        
        let length = self.count
        
        for index in 0..<length {
            
            let randomInt = Int.random(in: 0..<length)
            self.swapAt(index, randomInt)
        }
    }
}

extension UIColor {
    
    public class var firstColor: UIColor {
        return UIColor(red: 0.2902, green: 0.4078, blue: 1, alpha: 1.0)
    }
    
    public class var secondColor: UIColor {
        return UIColor(red: 0.1647, green: 0.3333, blue: 0.8667, alpha: 1.0)
    }
}
