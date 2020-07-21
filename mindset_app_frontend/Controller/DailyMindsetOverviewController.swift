//
//  DailyMindsetOverviewController.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 09/07/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

class DailyMindsetOverviewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func DailyMessage(_ sender: UIButton) {
        performSegue(withIdentifier: "ToMessageScreen", sender: sender)
    }
    
    @IBAction func StartDailyJournal(_ sender: UIButton) {
        performSegue(withIdentifier: "ToDailyOverViewScreen", sender: sender)
    }
}
