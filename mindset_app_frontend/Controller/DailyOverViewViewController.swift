//
//  DailyOverViewViewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 21/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyOverViewViewController: UIViewController {

    var isUnwind: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackToDailyMessage(_ sender: Any) {
        performSegue(withIdentifier: "BackToDailyMessage", sender: sender)
    }
    
    @IBAction func BackToDailyMindset(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToDailyMindset", sender: sender)
    }
    
    @IBAction func BackToDailyGoal(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToDailyGoal", sender: sender)
    }
    
    @IBAction func BackToTaskScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToTask", sender: sender)
    }
    
    @IBAction func BackToPeopleScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPerson", sender: sender)
    }
    
    
    
}
