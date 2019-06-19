//
//  ViewController.swift
//  ButtonExtensions
//
//  Created by Bruno Amezcua on 6/19/19.
//  Copyright © 2019 Bruno Amezcua. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var Button1: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // UI
        Button1.round()
    }
    @IBAction func Button1Actino(_ sender: Any) {
        Button1.shine()
    }
}

