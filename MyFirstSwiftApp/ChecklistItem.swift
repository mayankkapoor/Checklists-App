//
//  ChecklistItem.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 6/17/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
	var text: String?
	var checked: Bool
	
	init(text: String?, checked: Bool) {
		self.text = text
		self.checked = checked
	}
	
	func encodeWithCoder(aCoder: NSCoder!) {
		aCoder.encodeObject(self.text, forKey: "Text")
		aCoder.encodeBool(self.checked, forKey: "Checked")
	}
	
	required init(coder aDecoder: NSCoder!) {
		self.text = aDecoder.decodeObjectForKey("Text") as? String //? as Text data can be nil
		self.checked = aDecoder.decodeBoolForKey("Checked")
	}
}