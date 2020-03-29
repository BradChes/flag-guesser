//
//  ViewController.swift
//  flag-guesser
//
//  Created by Bradley Chesworth on 28/01/2020.
//  Copyright © 2020 Brad Chesworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        if questionCount <= 11 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            title = "\(countries[correctAnswer].uppercased())?"
            
            questionCount += 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options:[], animations: {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished) in
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options:[], animations: {
                            sender.transform = .identity
                        }, completion: nil)
        }
    
        if sender.tag == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        
        askQuestion()
        
        if questionCount == 11 {
            let ac = UIAlertController(title: "GG", message: "Your final score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            questionCount = 0
            score = 0
        }
    }
    
    @IBAction func barButtonTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Current score", message: "\(score)", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { _ in
            return
        }))

        present(ac, animated: true)
    }
}

