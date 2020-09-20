//
//  CreatorViewController.swift
//  Print2PDF
//
//  Created by Gabriel Theodoropoulos on 14/06/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblInvoiceItems: UITableView!
    
    @IBOutlet weak var bbiTotal: UIBarButtonItem!
    
    @IBOutlet weak var tvRecipientInfo: UITextView!
    
    
    var invoiceNumber: String!
    
    var items: [[String: String]]!
    
    var totalAmount = "0"
    
    var saveCompletionHandler: ((_ invoiceNumber: String, _ recipientInfo: String, _ totalAmount: String, _ items: [[String: String]]) -> Void)!
    
    var firstAppeared = true
    
    var nextNumberAsString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as the delegate and the datasource of the tableview.
        tblInvoiceItems.delegate = self
        tblInvoiceItems.dataSource = self
        
        
        // Add a tap gesture recognizer to the view to dismiss the keyboard.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstAppeared {
            determineInvoiceNumber()
            displayTotalAmount()
            firstAppeared = false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: IBAction Methods
    
    @IBAction func addItem(_ sender: AnyObject) {
        let addItemViewController = storyboard?.instantiateViewController(withIdentifier: "idAddItem") as! AddItemViewController
        addItemViewController.presentAddItemViewControllerInViewController(originatingViewController: self) { (itemDescription, price) in
            
            DispatchQueue.main.async {
                if self.items == nil {
                    self.items = [[String: String]]()
                }
                
                self.items.append(["item": itemDescription, "price": price])
                self.tblInvoiceItems.reloadData()
                
                self.displayTotalAmount()
            }
        }
    }
    
    
    @IBAction func saveInvoice(_ sender: AnyObject) {
        if saveCompletionHandler != nil {
            if nextNumberAsString != nil {
                UserDefaults.standard.set(nextNumberAsString, forKey: "nextInvoiceNumber")
            }
            else {
                UserDefaults.standard.set("002", forKey: "nextInvoiceNumber")
            }
            
            saveCompletionHandler(_: invoiceNumber, _: tvRecipientInfo.text, _: bbiTotal.title!, _: items)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: Custom Methods
    
    func presentCreatorViewControllerInViewController(originalViewController: UIViewController, saveCompletionHandler: @escaping (_ invoiceNumber: String, _ recipientInfo: String, _ totalAmount: String, _ items: [[String: String]]) -> Void) {
        self.saveCompletionHandler = saveCompletionHandler
        originalViewController.navigationController?.pushViewController(self, animated: true)
    }
    
    
    func determineInvoiceNumber() {
        // Get the invoice number from the user defaults if exists.
        if let nextInvoiceNumber = UserDefaults.standard.object(forKey: "nextInvoiceNumber") {
            invoiceNumber = nextInvoiceNumber as? String
            
            // Save the next invoice number to the user defaults.
            let nextNumber = Int(nextInvoiceNumber as! String)! + 1
            
            if nextNumber < 10 {
                nextNumberAsString = "00\(nextNumber)"
            }
            else if nextNumber < 100 {
                nextNumberAsString = "0\(nextNumber)"
            }
            else {
                nextNumberAsString = "\(nextNumber)"
            }
        }
        else {
            // Specify the first invoice number.
            invoiceNumber = "001"
        }
        
        // Set the invoice number to the navigation bar's title.
        navigationItem.title = invoiceNumber
    }
    
    
    func calculateTotalAmount() {
        var total: Double = 0.0
        if items != nil {
            for invoiceItem in items {
                let priceAsNumber = NumberFormatter().number(from: invoiceItem["price"]!)
                total += Double(truncating: priceAsNumber!)
            }
        }
        
        totalAmount = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: "\(total)")
    }
    
    
    func displayTotalAmount() {
        calculateTotalAmount()
        bbiTotal.title = totalAmount
    }
    
    
    func dismissKeyboard() {
        if tvRecipientInfo.isFirstResponder {
            tvRecipientInfo.resignFirstResponder()
        }
    }
    
    
    // MARK: UITableView Delegate and Datasource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items != nil) ? items.count : 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath as IndexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "itemCell")
        }
        
        cell.textLabel?.text = items[indexPath.row]["item"]
        cell.detailTextLabel?.text = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: items[indexPath.row]["price"]!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    

    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            items.remove(at: indexPath.row)
            tblInvoiceItems.reloadData()
            displayTotalAmount()
        }
    }
    
}
