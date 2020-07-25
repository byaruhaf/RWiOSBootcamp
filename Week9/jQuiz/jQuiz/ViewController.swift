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

    var answerArray: [String] = []
    var points: Int = 0
    
    private let clueViewModel = ClueViewModel()
    private var hasUserSelectedAnswer = false
     var imageCancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://cdn.dribbble.com/users/1405795/screenshots/4801691/1.jpg")!

        self.imageCancellable = URLSession.shared
            .downloadTaskPublisher(for: url)
            .map { UIImage(contentsOfFile: $0.url.path)! }
            .replaceError(with: UIImage(named: "fallback"))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self.logoImageView)


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

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker.3.fill"), for: .normal)
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
        nextButton.isEnabled = false
        nextButton.alpha = nextButton.isEnabled ? 1.0 : 0.5
//        alpha = isEnabled ? 1.0 : 0.5
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
            nextButton.pulsate()
            nextButton.shake()
            nextButton.flash()
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



