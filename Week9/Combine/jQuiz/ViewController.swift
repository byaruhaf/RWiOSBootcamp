//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

struct CellType {
    static let answerCell = "AnswerCell"
}

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var answerArray: [String] = []
    var points: Int = 0
    
    private let clueViewModel = ClueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let Answernib = UINib(nibName: "AnswerTableViewCell", bundle: nil)
        tableView.register(Answernib, forCellReuseIdentifier: CellType.answerCell)
        
        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
        SoundManager.shared.playSound()
        clueViewModel.refreshClues {
            self.checkUP()
        }
    }

    @IBAction func submit(_ sender: Any) {
        clueViewModel.refreshClues {
            self.checkUP()
        }
    }

    func checkUP() {
        print(clueViewModel.qestionCategory!)
        print(clueViewModel.qestion!)
        print(clueViewModel.correctanswer!)
        print(clueViewModel.answerArray)
        categoryLabel.text = clueViewModel.qestionCategory
        clueLabel.text = clueViewModel.qestion
        self.answerArray = clueViewModel.answerArray
        tableView.isUserInteractionEnabled = true
        tableView.reloadData()
    }


    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.answerCell) as! AnswerTableViewCell
        cell.qLable.text = answerArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false
    }

}



