//
//  ViewController.swift
//  AnimatedSegmentSwitch
//
//  Created by Tobias Schmid on 09/18/2015.
//  Copyright (c) 2015 Tobias Schmid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: AnimatedSegmentSwitch!

    fileprivate lazy var navBarSegmentSwitch: AnimatedSegmentSwitch = {

        let segmentControl = AnimatedSegmentSwitch()
        segmentControl.frame = CGRect(x: 30.0, y: 40.0, width: 200.0, height: 30.0)
        
        segmentControl.backgroundColor = .customYellowColor()
        segmentControl.borderColor = .clear
        
        segmentControl.selectedTitleColor = .customYellowColor()
        segmentControl.titleColor = .white
        segmentControl.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)

        segmentControl.thumbColor = .white
        segmentControl.thumbCornerRadius = 1.0
        segmentControl.thumbInset = 0.0
        
        segmentControl.addTarget(self, action: #selector(ViewController.segmentValueDidChange(_:)), for: .valueChanged)
        
        segmentControl.items = ["Swift", "Objective-C"]
        segmentControl.selectedIndex = 0

        return segmentControl
    }()
    
    fileprivate lazy var statsSegmentSwitch: AnimatedSegmentSwitch = {

        let segmentControl = AnimatedSegmentSwitch()
        segmentControl.frame = CGRect(x: 50.0, y: 20.0, width: self.view.bounds.width - 100.0, height: 30.0)
        segmentControl.autoresizingMask = [.flexibleWidth]
        
        segmentControl.backgroundColor = .customBlueColor()

        segmentControl.selectedTitleColor = .customBlueColor()
        segmentControl.titleColor = .white
        segmentControl.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        
        segmentControl.thumbColor = .white

        segmentControl.addTarget(self, action: #selector(ViewController.segmentValueDidChange(_:)), for: .valueChanged)
        
        segmentControl.items = ["Week", "Month", "Year"]

        return segmentControl
    }()
    
    fileprivate lazy var lyftSegmentSwitch: AnimatedSegmentSwitch = {

        let segmentControl = AnimatedSegmentSwitch()
        segmentControl.frame = CGRect(x: 50.0, y: 70.0, width: self.view.bounds.width - 100.0, height: 35.0)
        segmentControl.autoresizingMask = [.flexibleWidth]

        segmentControl.backgroundColor = .lyftLightGrayColor()

        segmentControl.selectedTitleColor = .white
        segmentControl.titleColor = .white
        segmentControl.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)

        segmentControl.borderColor = .lyftLightGrayColor()
        segmentControl.thumbColor = .lyftPinkColor()
        segmentControl.thumbInset = 2.0

        segmentControl.addTarget(self, action: #selector(ViewController.segmentValueDidChange(_:)), for: .valueChanged)

        segmentControl.items = ["Line", "Lyft", "Plus"]
        segmentControl.selectedIndex = 1

        return segmentControl
    }()
    
    fileprivate lazy var tipSegmentSwitch: AnimatedSegmentSwitch = {
        
        let segmentControl = AnimatedSegmentSwitch()
        segmentControl.frame = CGRect(x: 50.0, y: 125.0, width: self.view.bounds.width - 100.0, height: 35.0)
        segmentControl.autoresizingMask = [.flexibleWidth]
        
        segmentControl.backgroundColor = .white
        
        segmentControl.selectedTitleColor = .white
        segmentControl.titleColor = .lyftGrayColor()
        segmentControl.font = UIFont(name: "Avenir-Black", size: 13.0)

        segmentControl.thumbColor = .lyftPinkColor()
        segmentControl.thumbInset = 0.0

        segmentControl.cornerRadius = 1.4
        segmentControl.thumbCornerRadius = 1.4
        
        segmentControl.addTarget(self, action: #selector(ViewController.segmentValueDidChange(_:)), for: .valueChanged)
        
        segmentControl.items = ["No tip", "$ 1", "$ 2", "$ 5", "Other"]
        segmentControl.selectedIndex = 3
        
        return segmentControl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.statusBarStyle = .lightContent

        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = .customLightYellowColor()

        navigationItem.titleView = navBarSegmentSwitch
       
        view.addSubview(statsSegmentSwitch)
        
        view.addSubview(lyftSegmentSwitch)
        
        view.addSubview(tipSegmentSwitch)
        
        if let control = segmentControl {
            control.font = UIFont(name: "HelveticaNeue-Medium", size: 17.0)
            control.thumbCornerRadius = 1.0
            control.thumbInset = 0.0

            control.thumbColor = .customGreenColor()
            control.titleColor = .customRedColor()
            control.selectedTitleColor = .white

            control.items = ["Good", "Bad"]
        }
    }

    func segmentValueDidChange(_ sender: AnimatedSegmentSwitch) {
        print("valueChanged: \(sender.selectedIndex)")
    }

    @IBAction func segmentValueChanged(_ sender: AnimatedSegmentSwitch!) {

        sender.selectedTitleColor = .white

        if sender.selectedIndex == 0 {
            sender.thumbColor = .customGreenColor()
            sender.titleColor = .customRedColor()
        } else if sender.selectedIndex == 1 {
            sender.thumbColor = .customRedColor()
            sender.titleColor = .customGreenColor()
        }
    }
}

extension UIColor {

    class func customYellowColor() -> UIColor {
        return UIColor(red: 229.0/255.0, green: 163.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }

    class func customLightYellowColor() -> UIColor {
        return UIColor(red: 252.0/255.0, green: 182.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }

    class func customRedColor() -> UIColor {
        return UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    }

    class func customGreenColor() -> UIColor {
        return UIColor(red: 85.0/255.0, green: 238.0/255.0, blue: 151.0/255.0, alpha: 1)
    }

    class func customBlueColor() -> UIColor {
        return UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1)
    }

    class func lyftPinkColor() -> UIColor {
        return UIColor(red: 234.0/255.0, green: 11.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    }

    class func lyftGrayColor() -> UIColor {
        return UIColor(red: 51.0/255.0, green: 61.0/255.0, blue: 71.0/255.0, alpha: 1.0)
    }

    class func lyftLightGrayColor() -> UIColor {
        return UIColor(red: 77.0/255.0, green: 94.0/255.0, blue: 107.0/255.0, alpha: 1.0)
    }
}
