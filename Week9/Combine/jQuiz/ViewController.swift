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
    @IBOutlet weak var nextButton: UIButton!

    var answerArray: [String] = []
    var points: Int = 0
    
    private let clueViewModel = ClueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let c1 = UIColor(hue:0.704, saturation:0.884, brightness:0.719, alpha:1.000)
        let c2 = UIColor(hue:0.762, saturation:0.667, brightness:0.800, alpha:1.000)
        self.view.setGradientBackground(top: c2, bottom: c1)
        let b1 = UIColor(hue:0.101, saturation:0.900, brightness:1.000, alpha:1.000)
        let b2 = UIColor(hue:0.085, saturation:1.000, brightness:1.000, alpha:1.000)
        nextButton.layer.cornerRadius = nextButton.frame.size.height/2
        nextButton.layer.masksToBounds = true
        nextButton.setGradientBackground(top: b2, bottom: b1)

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
        categoryLabel.pushTransition(1)
        categoryLabel.text = clueViewModel.qestionCategory
        clueLabel.pushTransition(1)
        clueLabel.text = clueViewModel.qestion
        self.answerArray = clueViewModel.answerArray
        //        tableView.isUserInteractionEnabled = true
        //        tableView.reloadData()
//        tableView.reloadData()
        UIView.transition(with: tableView,
                          duration: 1,
                          options: .transitionFlipFromBottom,
//                          animations: { self.tableView.reloadSections([0], with: .bottom) })
            animations: { self.tableView.reloadData()})

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
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.answerCell) as! AnswerTableViewCell
        cell.qLable.text = answerArray[indexPath.row]
        cell.selectedBackgroundView = bgColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.isUserInteractionEnabled = false
    }

}



