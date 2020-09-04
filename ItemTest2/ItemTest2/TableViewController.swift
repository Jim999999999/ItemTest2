//
//  TableViewController.swift
//  ItemTest2
//
//  Created by James Miller on 9/2/20.
//  Copyright © 2020 James Miller. All rights reserved.
//

import UIKit
import PMAlertController

class TableViewController: UITableViewController {
    
    var dummyArray = ["A", "B", "C", "D", "E"]
    var dummyStores = ["1", "2", "3", "4"]
    var inputString: String = ""
    var pickerView = UIPickerView()
    var selectedStore: String?
    var storeTextField: String?
    var textLabel = UITextField()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = dummyArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print ("Add Button Pressed")
        var itemTextField = UITextField()
        var storeTextField = UITextField()

        let screenSize = UIScreen.main.bounds
        
        let alertVC = PMAlertController(title: "A Title", description: "My Description", image: UIImage(named: "img.png"), style: .alert)

        let pickerFrame = UIPickerView(frame: CGRect(x:5, y: 20, width: screenSize.width - 20, height: 140))
        pickerFrame.tag = 555
        pickerFrame.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self

        alertVC.addTextField { (textField2) in
            textField2?.placeholder = "enter item name here"
            itemTextField = textField2!
        }
        
        
        alertVC.addTextField { (textField) in
            textField?.placeholder = "select store here"
            textField?.inputView = pickerView
            
            pickerView.delegate = self
            pickerView.dataSource = self
            
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.default
            toolbar.isTranslucent = true
            
            textField?.inputAccessoryView = toolbar
            textField?.inputView = pickerView
            
            storeTextField = textField!
        }
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("Capture action Cancel")
        }))
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
            print(itemTextField.text)
            print(storeTextField.text)
            
            self.dummyArray.append(itemTextField.text!)
            self.tableView.reloadData()
            
        }))
        self.present(alertVC, animated: true, completion: nil)
        
    }

}


extension TableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dummyStores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dummyStores[row]
    }
    
}

extension TableViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int)  {
//        let selectedStore = dummyStores[row]
//        print(selectedStore)
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStore = dummyStores[row]
        textLabel.text = selectedStore
    }
}
