//
//  AddItemViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/28/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate {
	func addItemViewControllerDidCancel()
	func didFinishAddingItem(item: ChecklistItem)
	func didFinishEditingItem(item: ChecklistItem)
}

class AddItemViewController: UITableViewController {
	var delegate: AddItemViewControllerDelegate? //Specifying as optional as we're not initializing AddItemViewController with a delegate. Delegate is assigned on the fly.
	
	@IBOutlet var textField : UITextField = nil
	
	var itemToEdit: ChecklistItem?
	
	override func viewDidLoad() {
		if itemToEdit != nil {
			textField.text = itemToEdit?.text
		}
	}
	
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.addItemViewControllerDidCancel()
	}

	@IBAction func done(sender: AnyObject) {
		if let editedItem = self.itemToEdit? { // Check for nil value
			editedItem.text = textField.text
			self.delegate?.didFinishEditingItem(editedItem)
		} else {
			let newItem = ChecklistItem(text: textField.text, checked: false)
			self.delegate?.didFinishAddingItem(newItem)
		}
	}
}
