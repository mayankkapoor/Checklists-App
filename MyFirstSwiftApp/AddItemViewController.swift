//
//  AddItemViewController.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/28/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController {
	@IBAction func cancel(sender: AnyObject) {
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}

	@IBAction func done(sender: AnyObject) {
		navigationController.dismissViewControllerAnimated(true, completion: {})
	}
}
