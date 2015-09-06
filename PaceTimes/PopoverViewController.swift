//
//  PopoverViewController.swift
//  PaceTimes
//
//  Created by Kyle Mills on 9/2/15.
//  Copyright (c) 2015 Kyle Mills Dev. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissViewController(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
