//
//  ScoreVC.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import UIKit

class ScoreVC: UIViewController {
    @IBOutlet weak var labelScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func playAgain() {
        navigationController?.popViewController(animated: true)
    }
    
}
