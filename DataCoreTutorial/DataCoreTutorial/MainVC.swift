//
//  MainVC.swift
//  DataCoreTutorial
//
//  Created by Khoa on 10/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        generateTestData()
        attemptFetch()
    }

    func attemptFetch() {
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        if segment.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        } else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        } else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
//        self.controller = controller
        do {
            try controller.performFetch()
        }catch {
            let error = error as NSError
            print(error)
        }
    }

    @IBAction func segmentChange(_ sender: AnyObject) {
        
        attemptFetch()
        tableView.reloadData()
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                guard let cell = tableView.cellForRow(at: indexPath) as? ItemCell else {return}
                //update cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            break
        }
    }
    
    func generateTestData() {
        let item = Item(context: contex)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "Macbook apple"
        
        let item1 = Item(context: contex)
        item1.title = "Bose Headphones"
        item1.price = 300
        item1.details = "Headphones"
        
        let item2 = Item(context: contex)
        item2.title = "Tesla Model S"
        item2.price = 80000
        item2.details = "Tesla Cars"
        
        ad.saveContext() 
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        //updated cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailVC" {
            if let destinationVC = segue.destination as? ItemDetailVC {
                if let item = sender as? Item {
                    destinationVC.itemToEdit = item
                }
            }
        }
    }
    
}
