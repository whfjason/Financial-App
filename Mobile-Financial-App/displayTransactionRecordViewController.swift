//
//  displayTransactionRecordViewController.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-05.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import MessageUI

class displayTransactionRecordViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    let filename = "transactionRecord.csv"
    var csvText = "Name, Amount\n"
    var authEmail = ""
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tableViewTransaction: UITableView!
    
    @IBAction func export(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } 
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filename)
        do { try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8) } catch { print("\(error)") }
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["\(authEmail)"])
        mailComposerVC.setSubject("Financial Record Data Export Request")
        mailComposerVC.setMessageBody("Hello, \n\nThe financial record is attached as csv file!\n", isHTML: false)
        do { try mailComposerVC.addAttachmentData(NSData(contentsOf: path!) as Data, mimeType: "text/csv", fileName: "\(filename)") } catch { print("\(error.localizedDescription)") }
        return mailComposerVC
    }
    
    var transactionList = [TransactionModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let transaction: TransactionModel
        transaction = transactionList[indexPath.row]
        cell.labelTransactionName.text = transaction.payableTo
        cell.labelTransactionAmount.text = transaction.amount
        return cell
    }
    
    var refTransaction: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        
        refTransaction = Database.database().reference().child("transaction")
        let auth_userId = Auth.auth().currentUser!.uid
        authEmail = Auth.auth().currentUser!.email!
        var transaction = TransactionModel(payableTo: "", amount: "")
        
        refTransaction.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.transactionList.removeAll()
                
                for record in snapshot.children.allObjects as! [DataSnapshot] {
                    let transactionObject = record.value as! [String: AnyObject]
                    let transaction_uid = transactionObject["userId"]! as! String
                    
                    if (transaction_uid != auth_userId) {
                        continue
                    } else {
                        let transactionName = (transactionObject["payableTo"] as! String)
                        
                        let amount = Double((transactionObject["amount"] as! String))
                        let transactionAmount = currencyFormatter.string(from: NSNumber(value: amount!))
                        
                
                        if (transactionName != "" && transactionAmount != "") {
                            let newLine = "\(transactionName), \(String(describing: transactionAmount))\n"
                            self.csvText.append(newLine)
                        }
                        
                        transaction = TransactionModel(payableTo: transactionName,
                                                       amount: transactionAmount)
                    }
                    self.transactionList.append(transaction)
                }
                self.tableViewTransaction.reloadData()
            }
        })
    }
}
