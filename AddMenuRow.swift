//
//  AddMenuRow.swift
//  Camilyo App
//
//  Created by Max Pevsner on 04/11/2018.
//  Copyright © 2018 Camilyo. All rights reserved.
//

import UIKit

class AddMenuRow: NSObject {
    let addMenuRowImageName: String
    let addMenuRowTitle: String
    let isDisabled: Bool
    
    //MARK: - Initialization
    init(with imageName: String, title: String, disabled: Bool = false) {
        addMenuRowImageName = imageName
        addMenuRowTitle = title
        isDisabled = disabled
        
        super.init()
    }
}
