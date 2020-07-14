//
//  DailyMessageViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 10/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyMessageViewController: UIViewController, QuestionManagerDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var questionManager = QuestionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionManager.delegate = self
        questionManager.getData()
        // Do any additional setup after loading the view.
//        textView.isScrollEnabled = false
//        resize(textView: textView)
        }
    
    @IBAction func toNextScreen(_ sender: UIButton) {
        let result = questionManager.getFirstQuestions()
        print("HET IS GODVERDOMME GELUKT: \(result)")
    }
    
    func didUpdateQuestion(questions: [Question]) {
        let goal = questions.filter { question in
            return question.category == "goals"
        }
        DispatchQueue.main.async {
//            self.titleLabel.text = questions[0].question
            self.titleLabel.text = goal[0].question
        }
    }
}

    
//    fileprivate func resize(textView: UITextView) {
//        var newFrame = textView.frame
//        let width = newFrame.size.width
//        let newSize = textView.sizeThatFits(CGSize(width: width,
//                                                   height: CGFloat.greatestFiniteMagnitude))
//        newFrame.size = CGSize(width: width, height: newSize.height)
//        textView.frame = newFrame
//    }

