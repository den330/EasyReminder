//
//  ViewController.swift
//  EasyReminder
//
//  Created by Yaxin Yuan on 16/4/22.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit





class ReminderViewController: UITableViewController {
    
    var things = [Thing]()
    var dateForm = NSDateFormatter()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ThingsToRememberCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "Things")
        
        let thing1 = Thing()
        let thing2 = Thing()
        
        thing1.title = "haha"
        thing1.text = "dasdasdasasa"
        thing2.title = "hehe"
        
        thing1.date = NSDate()
        thing2.date = NSDate()
        
        things.append(thing1)
        things.append(thing2)
        
        dateForm.dateFormat = "yyyy-MM-dd"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Things", forIndexPath: indexPath) as! ThingsToRememberCell
        cell.titleLabel.text = things[indexPath.row].title!
        let dateNow = things[indexPath.row].date
        if let dateReal = dateNow{
            cell.subTitle.text = dateForm.stringFromDate(dateReal)
        }else{
            cell.subTitle.text = "NA"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetail", sender: things[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let controller = segue.destinationViewController as! DetailViewController
            let thing = sender as! Thing
            controller.currentTitle = thing.title
            controller.currentText = thing.text
        }
    }
}

