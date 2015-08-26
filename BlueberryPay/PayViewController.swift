//
//  PayViewController.swift
//  BlueberryPay
//
//  Created by Marek Bendík on 01/08/15.
//  Copyright © 2015 BlueberryApps. All rights reserved.
//

import UIKit
import MaterialKit
//import AKPickerView

class PayViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let priceValues = Array<Int>(1...100)

    @IBOutlet var balanceLabel: UILabel!
    var balance = 0 {
        didSet{
            balanceLabel.text = "-\(balance)"
        }
    }
    @IBOutlet var payButton: MKButton! {
        didSet {
            payButton.cornerRadius = payButton.frame.height/2
            payButton.rippleLocation = .Center
            payButton.rippleLayerColor = UIColor(hex: 0x4FA264)
            payButton.backgroundColor = UIColor(hex: 0x65D080)
            payButton.layer.shadowRadius = 10
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = userDefaults.stringForKey("name")
        }
    }
    @IBOutlet var pickerView: AKPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.interitemSpacing = 10
            pickerView.highlightedTextColor = UIColor.redColor()
            pickerView.selectItem(4)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return priceValues.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        let value = priceValues[item]
        return "\(value)"
    }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        let selected = item + 1
        payButton.setTitle("\(selected)", forState: UIControlState.Normal)
    }

    @IBAction func updateBalance(sender: UIButton) {
        let value = pickerView.selectedItem+1
        balance = balance + value
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


