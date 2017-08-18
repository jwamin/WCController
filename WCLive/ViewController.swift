//
//  ViewController.swift
//  WCLive
//
//  Created by Joss Manger on 7/31/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GameAndWatchDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var status: StatusLight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateLabel(str:String){
        print(str)
        label.text = str
    }

    func sendMessage(str: String) {
        updateLabel(str: str)
    }
    
}

@IBDesignable class StatusLight : UIView {
    
    @IBInspectable var cornerRadiusValue:CGFloat = 10.0{
        didSet {
            self.setUpView()
        }
    }
    
    @IBInspectable var color:UIColor = UIColor.red{
        didSet {
            self.setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.cornerRadiusValue
        self.layer.backgroundColor = self.color.cgColor
    }
    
}
