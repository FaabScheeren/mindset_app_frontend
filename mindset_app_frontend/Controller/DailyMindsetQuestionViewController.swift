
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
var mindsetAnswers = [MindsetAnswersData]()
var mindsetAnswersManager = MindsetAnswersManager()


class DailyMindsetQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "OpenQuestionCell", bundle: nil), forCellReuseIdentifier: "MindsetQuestionsCell")
        
        mindsetQuestions = savedData.questions.filter { question in
            return question.category == "morning_mindset"
        }
        
        for question in mindsetQuestions {
            // Appending a struct to the answer array
            let answer = MindsetAnswersData(question: question._id, answer: "")
            mindsetAnswers.append(answer)
        }
    }
    
    @IBAction func saveMindsetAnswers(_ sender: UIButton) {
        mindsetAnswersManager.saveAnswers(with: mindsetAnswers) { (succes) in
            if (succes) {
                DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ToGoalScreen", sender: sender)
                }
            } else {
//                errorLabel.text = "Something went wrong sorry."
                print("Error")
            }
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
        cell.id = country._id
        cell.indexOfCell = indexPath.row
        
        // Makes the tableview fit the content
        cell.textChanged {[weak tableView] (_) in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        
//        // Appending a struct to the answer array
//        let answer = MindsetAnswersData(question: country._id, answer: "")
//        mindsetAnswers.append(answer)
        
        if(mindsetAnswers[indexPath.row].answer != "") {
            cell.questionInputField.text = mindsetAnswers[indexPath.row].answer
        }
        
//        print(mindsetAnswers)
        return cell
    }
}
