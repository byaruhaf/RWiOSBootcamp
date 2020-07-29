//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit
import Combine

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
        self.view.setGradientBackground(top: K.Colours.c2, bottom: K.Colours.c1)
        nextButton.roundCorners()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let Answernib = UINib(nibName: "AnswerTableViewCell", bundle: nil)
        tableView.register(Answernib, forCellReuseIdentifier: CellType.answerCell)
        
        self.scoreLabel.text = "\(self.points)"

        soundController()

        gameStart()

    }

    @IBAction func submit(_ sender: Any) {
        gameStart()
    }

    func setupGameViews() {
        guard let qestionCategory = clueViewModel.qestionCategory else { return }
        guard let qestion = clueViewModel.qestion else { return }
//        guard let correctanswer = clueViewModel.correctanswer else { return }

        if qestion == "" {
            gameStart()
            return
        }

//        print(qestionCategory)
//        print(qestion)
//        print(correctanswer)
//        print(clueViewModel.answerArray)
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
      soundController()
    }

    func soundController() {
        if SoundManager.shared.isSoundEnabled {
            soundButton.setImage(UIImage(systemName: "speaker.3.fill"), for: .normal)
            SoundManager.shared.playSound()
        } else {
            soundButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            SoundManager.shared.stopSound()
        }
    }

    fileprivate func gameStart() {
        clueViewModel.refreshClues(completion: { [unowned self]  in 
            self.setupGameViews()
        }) { (error) in
            Alert.showBasic(title: error.localizedDescription, message: "Contact Developer", vc: self)
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



