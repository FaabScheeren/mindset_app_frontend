//
//  DailyOverViewViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyOverViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func BackToPeopleScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPersonScreen", sender: sender)
    }
    
    @IBAction func BackToTaskScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToTaskScreen", sender: sender)
    }
    
}
