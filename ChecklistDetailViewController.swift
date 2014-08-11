//
//  ChecklistDetailViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 8/10/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

protocol ChecklistDetailViewControllerDelegate {
	func checklistDetailViewControllerDidCancel()
	func didFinishAddingChecklist(newChecklist: Checklist)
}

class ChecklistDetailViewController: UITableViewController {
	var delegate: ChecklistDetailViewControllerDelegate?
	
	@IBOutlet var textField: UITextField!
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.checklistDetailViewControllerDidCancel()
	}
	@IBAction func done(sender: AnyObject) {
		let newChecklist = Checklist(name: textField.text)
		self.delegate?.didFinishAddingChecklist(newChecklist)
	}
	
}