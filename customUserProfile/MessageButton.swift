//
//  MessageButton.swift
//  PoppyChat
//
//  Created by Gabor Csontos on 11/20/15.
//  Copyright © 2015 Gabor Csontos. All rights reserved.
//

import UIKit

class MessageButton: UIButton {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 23/255, green: 131/255, blue: 1, alpha: 1).CGColor
     
    }
}
