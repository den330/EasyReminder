//
//  ViewController.swift
//  EasyReminder
//
//  Created by Yaxin Yuan on 16/4/22.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewController: UITableViewController{
    
    var managedObjectContext: NSManagedObjectContext!
    var dateForm = NSDateFormatter()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Thing", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entity
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private struct constantNum{
        static let rowHeight: CGFloat = 70
    }
    
    func performFetch(){
        do{
            try fetchedResultsController.performFetch()
        }catch{
            fatalError()
        }
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ThingsToRememberCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "ThingCell")
        dateForm.dateFormat = "yyyy-MM-dd"
        performFetch()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = fetchedResultsController.sections{
            return sectionInfo[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    func configureCell(cell: ThingsToRememberCell, indexPath: NSIndexPath){
        let thing = fetchedResultsController.objectAtIndexPath(indexPath) as! Thing
        cell.titleLabel.text = thing.title
        let dateNow = thing.date
        cell.subTitle.text = dateForm.stringFromDate(dateNow)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("ThingCell", forIndexPath: indexPath) as! ThingsToRememberCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return constantNum.rowHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let thing = fetchedResultsController.objectAtIndexPath(indexPath)
        performSegueWithIdentifier("ShowDetail", sender: thing)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let thing = fetchedResultsController.objectAtIndexPath(indexPath) as! Thing
            managedObjectContext.deleteObject(thing)
            
            do{
                try managedObjectContext.save()
            }catch{
                fatalError()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! DetailViewController
        controller.managedObjectContext = managedObjectContext
        let identifier = segue.identifier!
        switch identifier{
        case "ShowDetail":
                controller.thingToEdit = sender as? Thing
                default: break
        }
    }
}


extension ReminderViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            print("*** NSFetchedResultsChangeInsert (object)")
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            
        case .Delete:
            print("*** NSFetchedResultsChangeDelete (object)")
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
        case .Update:
            print("*** NSFetchedResultsChangeUpdate (object)")
            if let cell = tableView.cellForRowAtIndexPath(indexPath!) as? ThingsToRememberCell {
                configureCell(cell, indexPath: indexPath!)
            }
        case .Move:
            print("*** NSFetchedResultsChangeMove (object)")
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    

    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}



