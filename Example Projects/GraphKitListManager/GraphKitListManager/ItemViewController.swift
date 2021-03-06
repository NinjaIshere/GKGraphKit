//
//  ItemViewController.swift
//  GraphKitListManager
//
//  Created by Daniel Dahan on 2015-03-06.
//  Copyright (c) 2015 GraphKit, Inc. All rights reserved.
//

import UIKit
import GKGraphKit

class ItemViewController: UIViewController, UITextViewDelegate {
	
	private let item: GKEntity!
	private lazy var graph: GKGraph = GKGraph()
	private lazy var textView: UITextView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	init(item: GKEntity!) {
		super.init(nibName: nil, bundle: nil)
		self.item = item
	}
	
	// #pragma mark View Handling
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// background color
		view.backgroundColor = .whiteColor()
		
		textView.delegate = self
		textView.text = item["note"] as? String
		view.addSubview(textView)
	}
	
	override func viewWillAppear(animated: Bool) {
		
	}
	
	override func viewDidAppear(animated: Bool) {
		var rightButton: UIBarButtonItem
		if nil == item["note"] {
			textView.becomeFirstResponder()
			rightButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: "SaveTask")
		} else {
			rightButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "SaveTask")
		}
		navigationController!.navigationBar.topItem!.rightBarButtonItem = rightButton
	}
	
	override func viewWillDisappear(animated: Bool) {
		navigationController!.navigationBar.topItem!.rightBarButtonItem = nil
		
		if 0 == countElements(textView.text) {
			item?.delete()
		}
	}
	
	// MARK: - Selectors
	
	func SaveTask() {
		if 0 < countElements(textView.text) {
			item["note"] = textView.text
			graph.save() { (success: Bool, error: NSError?) in }
		}
		navigationController!.popViewControllerAnimated(true)
	}
}
