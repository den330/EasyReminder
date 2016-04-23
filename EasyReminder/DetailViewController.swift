//
//  DetailViewController.swift
//  EasyReminder
//
//  Created by Yaxin Yuan on 16/4/22.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentText: String?
    var currentTitle: String?
    
    @IBOutlet weak var passageTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passageTitle.text = currentTitle
        Content.text = currentText
    }
    
    
    
    

    
}
