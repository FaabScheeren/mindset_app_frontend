//
//  Questions.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 10/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

protocol QuestionManagerDelegate {
    func didUpdateQuestion(questions: [Question])
}

var savedData = QuestionsModel()

struct QuestionManager {
    var delegate: QuestionManagerDelegate?
//    var questionsArray: Questions
//    var questionsModel = QuestionsModel(questions: [QuestionModel]())
//    var questionsModel: QuestionsModel
    
    func parseJSON(data: Data) -> QuestionsModel? {
        do {
            let decodedData = try JSONDecoder().decode(Questions.self, from: data)
            savedData = QuestionsModel(questions: decodedData.questions)
            return savedData
        } catch {
            print("Error took place\(error).")
            return nil
        }
    }
    
    func getData() {
        let url = URL(string: "http://localhost:4000/questions")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response!)
            
            guard let data = data else { return }
            // Using parseJSON() function to convert data to Swift struct
            let todoItem = self.parseJSON(data: data)
            
            if let todoItemModel = todoItem {
                let goal = todoItemModel.questions.filter { question in
                    return question.category == "goals"
                }
                print("GOAL: \(goal)")
                self.delegate?.didUpdateQuestion(questions: goal)
//                self.delegate?.didUpdateQuestion(questions: todoItemModel.questions)
            }
        }
        task.resume()
    }
    
    func getFirstQuestions() -> Question {
        return savedData.questions[0]
    }
}

