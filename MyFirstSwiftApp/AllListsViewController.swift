//
//  AllListsViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 8/3/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

class AllListsViewController: UITableViewController, ChecklistDetailViewControllerDelegate {
	var data: DataModel = DataModel()
	
	required init(coder aDecoder: NSCoder!) {
		super.init(coder: aDecoder)
	}
	
	override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		if let lists = self.data.lists {
			return lists.count
		} else {
			return 0
		}
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Checklist") as UITableViewCell
		if let lists = self.data.lists {
			let list: Checklist = lists[indexPath.row]
			cell.textLabel.text = list.name
		}
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		if segue.identifier == "ShowChecklist" {
			let controller: ChecklistViewController = segue.destinationViewController as ChecklistViewController
			if let lists = self.data.lists {
				let cell: UITableViewCell = sender as UITableViewCell
				let clickedCellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)
				controller.checklist = lists[clickedCellIndexPath.row]
			}
		} else {
			let navController: UINavigationController = segue.destinationViewController as UINavigationController
			let checklistDetailController = navController.topViewController as ChecklistDetailViewController
			checklistDetailController.delegate = self
			if segue.identifier == "CreateChecklist" {
				
			} else if segue.identifier == "EditChecklist" {
				checklistDetailController.title = "Edit Checklist"
				let cell: UITableViewCell = sender as UITableViewCell
				let editingCellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)
				println("editingCellIndexPath.row = \(editingCellIndexPath.row)")
				checklistDetailController.checklistToEdit = self.data.lists?[editingCellIndexPath.row]
			}
		}
	}
	
	func checklistDetailViewControllerDidCancel() {
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
	func didFinishAddingChecklist(newChecklist: Checklist) {
		let newRowIndex = self.data.lists?.count
		self.data.lists?.append(newChecklist)
		let indexPathToAdd = NSIndexPath(forRow: newRowIndex!, inSection: 0)
		tableView.insertRowsAtIndexPaths([indexPathToAdd], withRowAnimation: UITableViewRowAnimation.Automatic)
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
	func didFinishEditingChecklist(editedChecklist: Checklist) {
		tableView.reloadData()
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
	override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
		self.data.lists?.removeAtIndex(indexPath.row)
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
	}
	
}