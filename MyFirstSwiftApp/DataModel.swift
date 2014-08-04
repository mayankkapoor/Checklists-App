//
//  DataModel.swift
//  MyFirstSwiftApp
//
//  Created by Mayank Kapoor on 8/3/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation

class DataModel: NSObject {
	var lists: [Checklist]? = []

	let dataFilePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/Checklists.plist"

	func saveChecklists() -> Bool {
		var data: NSMutableData = NSMutableData.alloc()
		var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
		archiver.encodeObject(self.lists, forKey: "Checklists")
		archiver.finishEncoding()
		data.writeToFile(dataFilePath, atomically: true)
		return true
	}
	
	func loadChecklists() -> Bool {
		let filePath = self.dataFilePath
		if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
			var data: NSData = NSData(contentsOfFile: filePath)
			var unArchiver: NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
			self.lists = unArchiver.decodeObjectForKey("Checklists") as? [Checklist]
			unArchiver.finishDecoding()
			println("Finished loading Checklists from data file \(filePath)")
		} else {
			println("No data archive exists, creating empty list")
			var lists: [Checklist] = []
			var list: Checklist = Checklist(name: "To do")
			var items: [ChecklistItem] = []
			list.items = items
			lists.append(list)
			self.lists = lists
		}
		return true
	}
	
	init() {
		super.init()
		if self.loadChecklists() {
			println("DataModel loaded")
		} else {
			println("Oops, something went wrong!")
		}
	}
}