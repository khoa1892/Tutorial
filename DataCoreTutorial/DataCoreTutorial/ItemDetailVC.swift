//
//  ItemDetailVC.swift
//  DataCoreTutorial
//
//  Created by Khoa on 10/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import CoreData
class ItemDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsFeild: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
//        let store = Store(context: contex)
//        store.name = "Best Buy"
//        let store1 = Store(context: contex)
//        store1.name = "Tesla"
//        let store2 = Store(context: contex)
//        store2.name = "Apple"
//        let store3 = Store(context: contex)
//        store3.name = "Target"
//        let store4 = Store(context: contex)
//        store4.name = "Amazon"
//        let store5 = Store(context: contex)
//        store5.name = "K Mart"
//        ad.saveContext()
        
        getStore()
        if itemToEdit != nil {
            loadItem()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when selected
        
    }

    func getStore() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try contex.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
            
        }
    }
    
    @IBAction func saveBtnPressed(sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: contex)
        picture.image = thumbImage.image

        if itemToEdit == nil {
            item = Item(context: contex)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsFeild.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func loadItem() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsFeild.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while(index < stores.count)
            }
            
        }
    }
    
    @IBAction func deleteBtnPressed(sender: UIBarButtonItem) {
        guard let item = itemToEdit else {return}
        contex.delete(item)
        ad.saveContext()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func imageBtnPressed(sender: UIButton) {
        
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
