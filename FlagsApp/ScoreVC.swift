//
//  ScoreVC.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import UIKit

class ScoreVC: UIViewController {
    @IBOutlet weak var labelScore: UILabel!
    
    var correctScore: Int? = nil
    var wrongScore: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showQuizMessage()
    }
    
    private func showQuizMessage() {
        if let correct = correctScore {
                        
            labelScore.text = "Toplam Quiz skorunuz: \(correct * 5). Tekrar oynamak ister misiniz?"
        }
    }
    
    @IBAction func playAgain() {
        navigationController?.popViewController(animated: true)
    }
    
}
