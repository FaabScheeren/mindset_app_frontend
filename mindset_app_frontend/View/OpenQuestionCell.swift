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
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionInputField.delegate = self
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }

}

//extension OpenQuestionCell: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//
//    }
//}


