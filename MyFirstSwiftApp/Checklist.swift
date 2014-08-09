//
//  Checklist.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 8/3/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding {
	var name: String
	var items: [ChecklistItem] = []
	
	func encodeWithCoder(aCoder: NSCoder!) {
		aCoder.encodeObject(name, forKey: "Name")
		aCoder.encodeObject(items, forKey: "Items")
	}
	
	required init(coder aDecoder: NSCoder!) {
		self.name = aDecoder.decodeObjectForKey("Name") as String
		self.items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
	}
	
	init(name: String) {
		self.name = name
	}
	
	override init() {
		self.name = ""
	}
}