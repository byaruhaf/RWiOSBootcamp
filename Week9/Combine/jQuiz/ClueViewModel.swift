//
//  ClueViewModel.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 23/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import Combine

class ClueViewModel {
    private var cancellable: AnyCancellable?
    var clues: Clues = []
    var qestion:String?
    var qestionCategory:String?
    var correctanswer:String?
    var answerArray:[String] = []

    func refreshClues(completion: @escaping () -> Void) {
        cancellable = Networking.sharedInstance.loadData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                }

            }) { clues in
//                print(clues)
//                self.clues = clues
                let selectedClue = clues.randomElement()
                 self.qestion = selectedClue?.question
                self.qestionCategory = selectedClue?.category?.title
                 self.correctanswer = selectedClue?.answer
                 self.answerArray = clues.compactMap {$0.answer}
                completion()
        }
    }

//    func setupQuizData() -> (qestion:String,correctanswer:String,answerArray:[String]) {
//    func setupQuizData(){
//        refreshClues()
//        print(qestion)
//        print(correctanswer)
//        print(answerArray)
//    }
}
