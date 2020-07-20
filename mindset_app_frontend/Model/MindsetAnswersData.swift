//
//  MindsetAnswersData.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct MindsetAnswersData: Encodable {
    var question: String
    var answer: String?
}

struct MindsetAnswersDataDecode: Decodable {
    var morning_mindsets: [QuestionData]
}

struct QuestionData: Decodable {
    var question: String
    var answer: String
}