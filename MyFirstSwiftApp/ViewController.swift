//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/14/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate {
	
	var items: [ChecklistItem] = []
	
	let dataFilePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/Checklists.plist"
	
	func saveChecklistsItems() -> Bool {
		var data: NSMutableData = NSMutableData.alloc()
		var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
		archiver.encodeObject(items, forKey: "ChecklistItems")
		archiver.finishEncoding()
		data.writeToFile(dataFilePath, atomically: true)
		return true
	}
	
	func loadChecklistItems() {
		let filePath = self.dataFilePath
		if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
			var data: NSData = NSData(contentsOfFile: filePath)
			var unArchiver: NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
			items = unArchiver.decodeObjectForKey("ChecklistItems") as [ChecklistItem]
			unArchiver.finishDecoding()
		} else {
			println("No data archive exists, creating empty Checklist")
		}
	}
	
	init(coder aDecoder: NSCoder!) {
		super.init(coder: aDecoder)
		self.loadChecklistItems()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func configureCheckmarkForCell(cell: UITableViewCell, index: Int) {
		let label: UILabel = cell.viewWithTag(101) as UILabel
		let isChecked = items[index].checked
		if (isChecked) {
			label.text = "√"
		} else {
			label.text = ""
		}
	}
	
	func configureTextForCell(cell: UITableViewCell, item: ChecklistItem) {
		let label: UILabel = cell.viewWithTag(100) as UILabel
		label.text = item.text
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as UITableViewCell
		let item: ChecklistItem = items[indexPath.row]
		
		configureTextForCell(cell, item: item)
		configureCheckmarkForCell(cell, index: indexPath.row)
		
		return cell
	}
	
	override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)
		let item: ChecklistItem = items[indexPath.row]
		
		item.checked = !item.checked
		configureCheckmarkForCell(cell, index: indexPath.row)
		
		self.saveChecklistsItems()
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		var navController:  UINavigationController = segue.destinationViewController as UINavigationController
		var addItemController: AddItemViewController = navController.topViewController as AddItemViewController
		if segue.identifier == "Add Item" {
			addItemController.delegate = self
		} else if segue.identifier == "EditItem" {
			addItemController.delegate = self
			addItemController.title = "Edit Item"
			let cell: UITableViewCell = sender as UITableViewCell
			let editingCellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)
			addItemController.itemToEdit = items[editingCellIndexPath.row]
		}
	}
	
	func addItemViewControllerDidCancel() {
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
	func didFinishAddingItem(item: ChecklistItem) {
		let newRowIndex = items.count
		items.append(item)
		let indexPathToAdd = NSIndexPath(forRow: newRowIndex, inSection: 0)
		tableView.insertRowsAtIndexPaths([indexPathToAdd], withRowAnimation: UITableViewRowAnimation.Automatic)
		self.saveChecklistsItems()
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
	func didFinishEditingItem(editedItem: ChecklistItem) {
		self.saveChecklistsItems()
		tableView.reloadData()
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
	
//	@IBAction func addItem(sender: AnyObject?) {
//		let newRowIndex = items.count
//		let item = ChecklistItem(text: "New item", checked: false)
//		items.append(item)
//		let indexPathToAdd = NSIndexPath(forRow: newRowIndex, inSection: 0)
//		tableView.insertRowsAtIndexPaths([indexPathToAdd], withRowAnimation: UITableViewRowAnimation.Automatic)
//	}
	
	override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
		items.removeAtIndex(indexPath.row)
		self.saveChecklistsItems()
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
	}
}

