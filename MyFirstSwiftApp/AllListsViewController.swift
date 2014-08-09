//
//  AllListsViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 8/3/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

class AllListsViewController: UITableViewController {
	var data: DataModel! = DataModel()
	
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
		}
	}
}