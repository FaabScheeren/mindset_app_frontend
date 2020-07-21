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
    @IBOutlet weak var errorLabel: UILabel!
    
    var questionManager = QuestionManager()
    var messageManager = MessageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionManager.delegate = self
        questionManager.getQuestions()
    
//        textView.isScrollEnabled = false
//        resize(textView: textView)
        }
    
    @IBAction func toNextScreen(_ sender: UIButton) {
        if !textView.text.isEmpty {
            messageManager.saveMessage(data: textView.text, finished: {(succes) -> Void in
                if(succes) {
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ToDailyMindsetScreen", sender: sender)
                    }
                }
            })
        } else {
            errorLabel.text = "Please fill in your daily message."
        }
    }
    
    func didUpdateQuestion(questions: [Question]) {
        DispatchQueue.main.async {
            self.titleLabel.text = questions[0].question
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
