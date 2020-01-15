//
//  MenuController.swift
//  FinalProgcat0050Su19
//
//  Created by Christopher Tillery on 7/17/19.
//  Copyright © 2019 Christopher Tillery. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class MenuController: UIViewController {
    
    @IBOutlet weak var PvPButton: UIButton!
    @IBOutlet weak var PvAIButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        PvPButton.layer.cornerRadius = 4
        PvPButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 4, bottom: 7, right: 4)
        PvPButton.layer.shadowColor = UIColor.black.cgColor
        PvPButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        PvPButton.layer.masksToBounds = false
        PvPButton.layer.shadowOpacity = 0.3
        PvPButton.layer.shadowRadius = 0.5
        
        PvAIButton.layer.cornerRadius = 4
        PvAIButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 4, bottom: 7, right: 4)
        PvAIButton.layer.shadowColor = UIColor.black.cgColor
        PvAIButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        PvAIButton.layer.masksToBounds = false
        PvAIButton.layer.shadowOpacity = 0.3
        PvAIButton.layer.shadowRadius = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
