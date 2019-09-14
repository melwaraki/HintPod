//
//  ViewController.swift
//  HintPod
//
//  Created by melwaraki on 03/21/2019.
//  Copyright (c) 2019 melwaraki. All rights reserved.
//

import UIKit
import HintPod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedPresent(_ sender: Any) {
        HintPod.present(title: "App Feedback")
    }

}

