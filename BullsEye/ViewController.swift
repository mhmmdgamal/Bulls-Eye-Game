//
//  ViewController.swift
//  BullsEye
//
//  Created by Mohamed Gamal on 7/6/19.
//  Copyright © 2019 Barmagli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var currentValue: Int = 0
  var targetValue: Int = 0
  var score = 0
  var round = 0
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    startNewGame()
    updateLabels()
    
    // Custom slider
    let thumbnailImageNormal = UIImage(named: "SliderThumb-Normal")
    slider.setThumbImage(thumbnailImageNormal, for: .normal)
    
    let thumbnailImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
    slider.setThumbImage(thumbnailImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
    let trackLeftImage = UIImage(named: "SliderTrackLeft")
    let trackLeftResizeable = trackLeftImage?.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
    
    let trackRightImage = UIImage(named: "SliderTrackRight")
    let trackRightResizeable = trackRightImage?.resizableImage(withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
  }
  
  @IBAction func showAlert() {
    let difference = abs(currentValue - targetValue)
    var points = 100 - difference
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "Almost perfect"
      points += 50
    } else if difference < 20 {
      title = "Okay..."
    } else {
      title = "You suck"
    }
    
    score += points
    
    let message = "Your score is \(points) points.\n" +
    "You hit the value: \(currentValue)"
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { action in
                                self.startNewRound()
                                self.updateLabels()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value)
  }
  
  @IBAction func startOver() {
    startNewGame()
    updateLabels()
  }
  
  func startNewGame() {
    score = 0
    round = 0
    startNewRound()
    
    let transition = CATransition()
    transition.type = kCATransitionFade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    view.layer.add(transition, forKey: nil)
  }
  
  func startNewRound() {
    round += 1
    targetValue = 1 + Int(arc4random_uniform(100))
    currentValue = 50
    slider.value = Float(currentValue)
  }
  
  func updateLabels() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    roundLabel.text = String(round)
  }
}

