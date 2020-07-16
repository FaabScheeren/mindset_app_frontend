
//  DailyMindsetQuestionViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 14/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

//class QuestionTableViewCell: UITableViewCell {
//    @IBOutlet weak var questionTitleLabel: UILabel!
//}

var mindsetQuestions = [Question]()

class DailyMindsetQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
    
//        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "OpenQuestionCell", bundle: nil), forCellReuseIdentifier: "MindsetQuestionsCell")
        mindsetQuestions = savedData.questions.filter { question in
        return question.category == "morning_mindset"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mindsetQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MindsetQuestionsCell", for: indexPath) as! OpenQuestionCell

        let country = mindsetQuestions[indexPath.row]
        cell.questionTitleLabel?.text = country.question
        
        cell.textChanged {[weak tableView] (_) in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        
        self.tableHeight?.constant = self.tableView.contentSize.height
        return cell
    }
}
