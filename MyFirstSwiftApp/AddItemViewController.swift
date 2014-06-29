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
}

class AddItemViewController: UITableViewController {
	var delegate: AddItemViewControllerDelegate? //Specifying as optional as we're not initializing AddItemViewController with a delegate. Delegate is assigned on the fly.
	
	@IBOutlet var textField : UITextField = nil
	
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.addItemViewControllerDidCancel()
	}

	@IBAction func done(sender: AnyObject) {
		let newItem = ChecklistItem(text: textField.text, checked: false)
		self.delegate?.didFinishAddingItem(newItem)
	}
}
