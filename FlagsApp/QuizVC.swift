//
//  QuizVC.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import UIKit

class QuizVC: UIViewController {
    private var dao: FlagsDao?
    
    @IBOutlet weak var ivFlag: UIImageView!
    
    @IBOutlet var options: [UIButton]!
    @IBOutlet var scores: [UILabel]!
    
    private var flags: [Flag]?
    private var incorrectFlags: [Flag]?
    
    private var currentFlag: Flag?
    private var currentIndex: Int = 0
    private var correctOption: Int?
    private var isChosen: Bool = false
    
    private var correctScore: Int = 0
    private var wrongScore: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        clearScore()
        initFlagDao()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _scores = sender as? [Int]
        
        let _scoreVC = segue.destination as? ScoreVC
        
        if let scores = _scores, let scoreVC = _scoreVC {
            scoreVC.correctScore = scores[0]
            scoreVC.wrongScore = scores[1]
        }
    }
    
    private func clearScore() {
        self.currentIndex = 0
        self.correctOption = 0
        self.isChosen = false
        self.correctScore = 0
        self.wrongScore = 0
        
        scores[0].text = "Correct: \(self.correctScore)"
        scores[1].text = "Wrong: \(self.wrongScore)"
    }
    
    private func initFlagDao() {
        let resPath = Bundle.main.path(forResource: "flags", ofType: ".sqlite")
        let fm = FileManager.default
        let targetUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("flags.sqlite")
        
        if let targetResPath = resPath, let targetPath = targetUrl?.path {
            if fm.fileExists(atPath: targetPath) {
                print("The file is already exists.")
                fetchAll()
            } else {
                try? fm.copyItem(atPath: targetResPath, toPath: targetPath)
                fetchAll()
            }
        } else {
            print("The files are nil.")
        }
    }
    
    private func fetchAll() {
        dao = FlagsDao()
                
        if let daoFlags = dao?.fetchFlags() {
            self.flags = daoFlags
            getNextFlag()
        }
    }
    
    private func getNextFlag() {
        if isChosen {
            correctScore += 1
            scores[0].text = "Correct: \(correctScore)"
        }
        
        if currentIndex != self.flags!.count {
            currentFlag = self.flags?[currentIndex]
            self.incorrectFlags = dao?.fetchFlagsByRandomly(without: currentIndex)
            
            currentIndex += 1
            
            correctOption = Int.random(in: 0...3)
            
            if let imageName = currentFlag?.countryCode?.lowercased(), let countryName = currentFlag?.countryName {
                ivFlag.image = UIImage(named: String(describing: "\(imageName).png"))
                options[correctOption!].setTitle(countryName, for: .normal)
            }
            
            var wrongIndex = 0
            
            for (index, button) in self.options.enumerated() {
                if let flags = self.incorrectFlags, index != correctOption {
                    button.setTitle(flags[wrongIndex].countryName, for: .normal)
                    
                    wrongIndex += 1
                }
            }
        }else {
            performSegue(withIdentifier: "actionQuizToScore", sender: [correctScore, wrongScore])
        }
    }
    
    private func chosenWrongAnswer() {
        isChosen = false
        wrongScore += 1
        scores[1].text = "Incorrect: \(wrongScore)"
        getNextFlag()
    }
    
    @IBAction func actionA() {
        if options[0].currentTitle != currentFlag?.countryName {
            chosenWrongAnswer()
            return
        }
        
        isChosen = true
        
        getNextFlag()
    }
    @IBAction func actionB() {
        if options[1].currentTitle != currentFlag?.countryName {
            chosenWrongAnswer()
            return
        }
        
        isChosen = true
        
        getNextFlag()
    }
    @IBAction func actionC() {
        if options[2].currentTitle != currentFlag?.countryName {
            chosenWrongAnswer()
            return
        }
        
        isChosen = true
        
        getNextFlag()
    }
    @IBAction func actionD() {
        if options[3].currentTitle != currentFlag?.countryName {
            chosenWrongAnswer()
            return
        }
        
        isChosen = true
        
        getNextFlag()
    }
}

