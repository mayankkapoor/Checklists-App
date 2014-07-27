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
	@IBOutlet var textField : UITextField!
	var itemToEdit: ChecklistItem? = nil
	
	override func viewDidLoad() {
		if let unwrappedItem = self.itemToEdit {
			textField.text = unwrappedItem.text
		} else {
			textField.text = ""
		}
	}
	
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.addItemViewControllerDidCancel()
	}

	@IBAction func done(sender: AnyObject) {
		if let unwrappedEditedItem = self.itemToEdit {
			unwrappedEditedItem.text = textField.text
			self.delegate?.didFinishEditingItem(unwrappedEditedItem)
		} else {
			let newItem = ChecklistItem(text: textField.text, checked: false)
			self.delegate?.didFinishAddingItem(newItem)
		}
	}
}
