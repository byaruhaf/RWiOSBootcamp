//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit
import Combine

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

    var points: Int = 0
    
    private let clueViewModel = ClueViewModel()
    private var hasUserSelectedAnswer = false


    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.load(imageURL:K.URL.imageURL , key: K.Keys.iamgeKey )
        let c1 = UIColor(hue:0.704, saturation:0.884, brightness:0.719, alpha:1.000)
        let c2 = UIColor(hue:0.762, saturation:0.667, brightness:0.800, alpha:1.000)
        self.view.setGradientBackground(top: c2, bottom: c1)
        nextButton.roundCorners()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let Answernib = UINib(nibName: "AnswerTableViewCell", bundle: nil)
        tableView.register(Answernib, forCellReuseIdentifier: CellType.answerCell)
        
        self.scoreLabel.text = "\(self.points)"

        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        }
        if SoundManager.shared.isSoundEnabled == true {
            soundButton.setImage(UIImage(systemName: "speaker.3.fill"), for: .normal)
            //            SoundManager.shared.playSound()
        }

        clueViewModel.refreshClues {
            self.setupGameViews()
        }
    }

    @IBAction func submit(_ sender: Any) {
        clueViewModel.refreshClues {
            self.setupGameViews()
        }
    }

    func setupGameViews() {
        guard let qestionCategory = clueViewModel.qestionCategory else { return }
        guard let qestion = clueViewModel.qestion else { return }
        guard let correctanswer = clueViewModel.correctanswer else { return }

        if qestion == "" {
            print("****empty qestion*****")
            clueViewModel.refreshClues { self.setupGameViews()}
            return
        }

        print(qestionCategory)
        print(qestion)
        print(correctanswer)
        print(clueViewModel.answerArray)
        categoryLabel.pushTransition(1)
        categoryLabel.text = qestionCategory
        clueLabel.pushTransition(1)
        clueLabel.text = qestion
        nextButton.isEnabled = false
        nextButton.alpha = nextButton.isEnabled ? 1.0 : 0.5
        hasUserSelectedAnswer = false
        UIView.transition(with: tableView,
                          duration: 1,
                          options: .transitionFlipFromBottom,
                          animations: { self.tableView.reloadData()})
    }


    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker.3.fill"), for: .normal)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clueViewModel.answerArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.answerCell) as! AnswerTableViewCell
        cell.qLable.text = clueViewModel.answerArray[indexPath.row]
        cell.selectedBackgroundView = bgColorView
        cell.backView.backgroundColor = UIColor.white
        cell.qLable?.textColor = #colorLiteral(red: 0.2865216732, green: 0.2005397379, blue: 0.544816196, alpha: 1)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !hasUserSelectedAnswer{
            guard let cell = tableView.cellForRow(at: indexPath)  as? AnswerTableViewCell else { return }
            cell.qLable?.textColor = UIColor.white
            cell.qLable?.backgroundColor = UIColor.clear
            cell.backView.backgroundColor = gameCalculator(selecteAnswer: cell.qLable.text!)
            scoreLabel.text = points.description
            hasUserSelectedAnswer = true
            nextButton.isEnabled = true
            nextButton.alpha = nextButton.isEnabled ? 1.0 : 0.5
        }else {
            //Alert User to move to next qestiion.
            nextButton.shake()
            nextButton.flash()
            nextButton.shake()
        }
    }

    func gameCalculator(selecteAnswer:String) -> UIColor {
        if selecteAnswer == clueViewModel.correctanswer {
            points += 100
            return UIColor.systemGreen
        }else {
            points -= 20
            return UIColor.systemRed
        }
    }

}



