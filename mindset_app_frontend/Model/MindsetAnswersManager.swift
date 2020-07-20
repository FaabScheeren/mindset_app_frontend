//
//  MindsetAnswersManager.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct MindsetAnswersManager {
    func encodeJSON(with answers: [MindsetAnswersData]) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(answers)
            return jsonData
        } catch {
            print("Error took place: \(error)")
            return nil
        }
    }

    func saveAnswers(with data: [MindsetAnswersData], finished: @escaping (Bool) -> ()) {
        let url = URL(string: "http://localhost:4000/daily_mindset/mindset_questions/\(Constants.currentMindsetId)")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = encodeJSON(with: data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error at session: \(error)")
                return
            }
            
            guard let data = data else {return}
            do {
                let savedAnswers = try JSONDecoder().decode(MindsetAnswersDataDecode.self, from: data)
                print("Response data:\n \(savedAnswers)")
            } catch let jsonErr {
                print("\(jsonErr)")
            }
            finished(true)
        }
        task.resume()
    }
}
