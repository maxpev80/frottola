//
//  AddMenuTableViewCell.swift
//  Camilyo App
//
//  Created by Max Pevsner on 04/11/2018.
//  Copyright © 2018 Camilyo. All rights reserved.
//

import UIKit

class AddMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var addMenuItemIconImageView: UIImageView!
    @IBOutlet weak var addMenuItemTitleLabel: UILabel!

    //MARK: - Overridden Superclass Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData(addMenuRow: AddMenuRow) {
        addMenuItemIconImageView.image = UIImage(named: addMenuRow.addMenuRowImageName)
        addMenuItemTitleLabel.text = addMenuRow.addMenuRowTitle
        if addMenuRow.isDisabled {
            addMenuItemIconImageView.layer.opacity = 0.5
            addMenuItemTitleLabel.layer.opacity = 0.5
            isUserInteractionEnabled = false
        }
    }
    
}
