//
//  OpenQuestionCell.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 16/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class OpenQuestionCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionInputField: UITextView!
    
    var textChanged: ((String) -> Void)?
    var indexOfCell: Int = 0
    var id: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionInputField.delegate = self
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        mindsetAnswers[indexOfCell].answer = textView.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // reset (hide) the checkmark label
        self.questionInputField.text = ""

    }
}
