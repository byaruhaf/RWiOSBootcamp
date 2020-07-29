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

    func refreshClues(completion: @escaping () -> Void, errorFailure: @escaping (_ error:Error) -> Void) {
        cancellable = Networking.sharedInstance.loadData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
//                        print("received error: ", error)
//                        print(error.localizedDescription)
                        errorFailure(error)
                }

            }) { clues in
//                print(clues)
//                self.clues = clues
                let selectedClue = clues.randomElement()
                 self.qestion = selectedClue?.question
                self.qestionCategory = selectedClue?.category?.title
                 let uncleanCorrectanswer = selectedClue?.answer
                self.correctanswer = uncleanCorrectanswer?.nonAsciStripped
                let uncleanAnswerArray = clues.compactMap {$0.answer}
                self.answerArray = uncleanAnswerArray.map {$0.nonAsciStripped}
                completion()
        }
    }
}
