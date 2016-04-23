//
//  DetailViewController.swift
//  EasyReminder
//
//  Created by Yaxin Yuan on 16/4/22.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var currentText: String?
    var currentTitle: String?
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var passageTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passageTitle.text = currentTitle
        Content.text = currentText
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBAction func Done(){
        let thing = NSEntityDescription.insertNewObjectForEntityForName("Thing", inManagedObjectContext: managedObjectContext) as! Thing
        thing.content = Content.text
        thing.title = passageTitle.text
        thing.date = NSDate()
        do{
            try managedObjectContext.save()
        }catch{
            fatalError()
        }
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func Cancel(){
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    

    
}
