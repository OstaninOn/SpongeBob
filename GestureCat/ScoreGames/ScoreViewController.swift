//
//  ScoreViewController.swift
//  GestureCat
//
//  Created by  aleksandr on 20.11.22.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
        
    @IBOutlet weak var dateLabel: UILabel!
    
    var name = String()
    var place = String()
    var score = String()
    var date = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = name
        placeLabel.text = place
        scoreLabel.text = score
        dateLabel.text = date
        
    }
    

}
