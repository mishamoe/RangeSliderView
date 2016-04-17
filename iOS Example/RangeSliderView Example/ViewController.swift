//
//  ViewController.swift
//  RangeSliderView Example
//
//  Created by Omar Abdelhafith on 07/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import RangeSliderView

class ViewController: UIViewController {

    @IBOutlet weak var rangeSliderView: RangeSliderView!
    @IBOutlet weak var maximumValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSliderView.minimumKnobView.knobMovementFinishedCallback = {
            print("minimumKnobView knobMovementFinishedCallback")
        }
        
        rangeSliderView.maximumKnobView.knobMovementFinishedCallback = {
            print("maximumKnobView knobMovementFinishedCallback")
        }
    }
    
    @IBAction func valueChanged(sender: UIControl) {
        guard let sender = sender as? RangeSliderView else { return }
    
        minimumValueLabel.text = "\(sender.minimumSelectedValue)"
        maximumValueLabel.text = "\(sender.maximumSelectedValue)"
    }

}
