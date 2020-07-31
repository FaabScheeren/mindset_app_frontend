//
//  MessageManager.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct MessageManager {
    
    func encodeJSON(with message: String, day: String?) -> Data? {
        let newMessageItem = MessageData(today_message: message, day: day)
        do {
            let jsonData = try JSONEncoder().encode(newMessageItem)
            return jsonData
        } catch {
            print("Error took place\(error).")
            return nil
        }
    }
    
    func encodeUpdateJSON(with message: String) -> Data? {
        let newMessageItem = UpdateMessageData(today_message: message)
        do {
            let jsonData = try JSONEncoder().encode(newMessageItem)
            return jsonData
        } catch {
            print("Error took place\(error).")
            return nil
        }
    }
    
    
    func saveMessage(data: String, day: String, finished: @escaping (Bool)->()) {
        let url = URL(string: "http://localhost:4000/daily_mindset/today_message")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = encodeJSON(with: data, day: day)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do {
                let todoItemModel = try JSONDecoder().decode(MessageData.self, from: data)
                Constants.currentMindsetId = todoItemModel._id!
                print("Response data:\n \(todoItemModel)")
            } catch let jsonErr{
                print(jsonErr)
            }
            finished(true)
        }
        task.resume()
    }
    
    func updateMessage(with data: String, finished: @escaping (Bool) -> ()) {
        let url = URL(string: "http://localhost:4000/daily_mindset/today_message/\(Constants.currentMindsetId)")
        guard let requestUrl = url else {fatalError()}
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = encodeUpdateJSON(with: data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error at session: \(error)")
                return
            }
            
            guard let data = data else {return}
            do {
                    let savedAnswers = try JSONDecoder().decode(UpdateMessageData.self, from: data)
                    print("Response data:\n \(savedAnswers)")
            } catch let jsonErr {
                print("\(jsonErr)")
            }
            finished(true)
        }
        task.resume()
    }
}
