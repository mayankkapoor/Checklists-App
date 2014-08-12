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
	func didFinishEditingChecklist(editedChecklist: Checklist)
}

class ChecklistDetailViewController: UITableViewController {
	var delegate: ChecklistDetailViewControllerDelegate?
	var checklistToEdit: Checklist? = nil
	@IBOutlet var textField: UITextField!
	
	override func viewDidLoad() {
		if let unwrappedChecklist = self.checklistToEdit {
			textField.text = unwrappedChecklist.name
		} else {
			textField.text = ""
		}
	}
	
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.checklistDetailViewControllerDidCancel()
	}
	
	@IBAction func done(sender: AnyObject) {
		if let unwrappedChecklist = self.checklistToEdit {
			unwrappedChecklist.name = self.textField.text
			self.delegate?.didFinishEditingChecklist(unwrappedChecklist)
		} else {
			let newChecklist = Checklist(name: textField.text)
			self.delegate?.didFinishAddingChecklist(newChecklist)
		}
	}
	
}