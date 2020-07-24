//
//  DailyJournalViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 23/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

var journalAnswers = [MindsetAnswersData]()

class DailyJournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {
    @IBOutlet weak var tableView: UITableView!
    var journalQuestions = [Question]()
//    var journalQuestions = [["question": "Testing"] ["question": "Calling"]]
    
    override func viewDidLoad() {
        let questionManager = QuestionManager()
        
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OpenQuestionCell", bundle: nil), forCellReuseIdentifier: "MindsetQuestionsCell")
        
        if (savedData.questions.isEmpty) {
            questionManager.getQuestions() {(succes) in
                if(succes) {
                    self.journalQuestions = savedData.questions.filter { question in
                        return question.category == "evening_journal"
                    }

                    for question in self.journalQuestions {
                        // Appending a struct to the answer array
                        let answer = MindsetAnswersData(question: question._id, answer: "")
                        journalAnswers.append(answer)
                    }

                    DispatchQueue.main.async {
                        print("Testing")
                        self.tableView.reloadData()
                    }
                } else {

                }
            }
        } else {
            // Dubbele code? Hoe dit aanpassen en ervoor zorgen dat ik code niet hoef te kopieren?
            self.journalQuestions = savedData.questions.filter { question in
                return question.category == "evening_journal"
            }

            for question in self.journalQuestions {
                // Appending a struct to the answer array
                let answer = MindsetAnswersData(question: question._id, answer: "")
                journalAnswers.append(answer)
            }

            DispatchQueue.main.async {
//                print("Testing")
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MindsetQuestionsCell", for: indexPath) as! OpenQuestionCell
        cell.delegate = self
        
        let country = journalQuestions[indexPath.row]
        cell.questionTitleLabel?.text = country.question
        cell.id = country._id
        cell.indexOfCell = indexPath.row
        
        // Makes the tableview fit the content
        cell.textChanged {[weak tableView] (_) in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }

        if(journalAnswers[indexPath.row].answer != "") {
            cell.questionInputField.text = journalAnswers[indexPath.row].answer
        }
        
        return cell
    }
    
    func textViewChanged(textView: UITextView, indexOfCell: Int) {
        journalAnswers[indexOfCell].answer = textView.text
    }
    
//    func didUpdateQuestion(questions: [Question]) {
////        DispatchQueue.main.async {
//            print("Testing")
//            self.tableView.reloadData()
////        }
//    }
}
