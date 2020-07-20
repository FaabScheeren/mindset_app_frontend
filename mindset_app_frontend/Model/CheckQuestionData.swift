//
//  GoalData.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 20/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import Foundation

struct CheckQuestionData: Encodable {
    var title: String
    var done: Bool?
}


struct CheckQuestionResponse: Decodable {
    var goals: [GoalsData]
}

struct GoalsData: Decodable {
    var title: String
    var done: Bool
}
