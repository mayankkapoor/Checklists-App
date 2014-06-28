//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/14/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
	
	var items: ChecklistItem[] = []
                            
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var newItem: ChecklistItem = ChecklistItem(text: "Buy Groceries", checked: false)
		items.append(newItem)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func configureCheckmarkForCell(cell: UITableViewCell, index: Int) {
		let isChecked = items[index].checked
		if (isChecked) {
			cell.accessoryType = UITableViewCellAccessoryType.Checkmark
		} else {
			cell.accessoryType = UITableViewCellAccessoryType.None
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
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	@IBAction func addItem(sender: AnyObject?) {
		let newRowIndex = items.count
		let item = ChecklistItem(text: "New item", checked: false)
		items.append(item)
		let indexPathToAdd = NSIndexPath(forRow: newRowIndex, inSection: 0)
		tableView.insertRowsAtIndexPaths([indexPathToAdd], withRowAnimation: UITableViewRowAnimation.Automatic)
	}
	
	override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
		items.removeAtIndex(indexPath.row)
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
	}
}

