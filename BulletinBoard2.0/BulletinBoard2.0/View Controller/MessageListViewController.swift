//
//  MessageListViewController.swift
//  BulletinBoard2.0
//
//  Created by Owen Henley on 8/6/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		
		MessageController.shared.fetchAllMessagesFromCloud { (success) in
			if success {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
	// MARK: - Actions
	@IBAction func postButtonTapped(_ sender: Any) {
		guard let messageText = messageTextField.text, !messageText.isEmpty else { return }
		
		MessageController.shared.postNewMessage(with: messageText) { (success) in
			if success {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
}

// TableView Controller Delegate - DataSource
extension MessageListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageController.shared.messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
		
		// get the message
		let message = MessageController.shared.messages[indexPath.row]
		cell.textLabel?.text = message.messageText
		
		// Format the date
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
//		dateFormatter.timeStyle = .short
//		let formattedDate = dateFormatter.date(from: "\(message.timestamp)")
		cell.detailTextLabel?.text = "\(message.timestamp)"
		
		return cell
	}
}
