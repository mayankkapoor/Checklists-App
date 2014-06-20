//
//  ChecklistItem.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/17/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation

class ChecklistItem {
	var text: String?
	var checked: Bool
	
	init(text: String?, checked: Bool) {
		self.text = text
		self.checked = checked
	}
}