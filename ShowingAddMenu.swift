//
//  ShowingAddMenu.swift
//  Camilyo App
//
//  Created by Max Pevsner on 05/11/2018.
//  Copyright © 2018 Camilyo. All rights reserved.
//

import Foundation

protocol ShowingAddMenu: class {
    var widthConstraint: NSLayoutConstraint? {get set}
    var heightConstraint: NSLayoutConstraint? {get set}
    var widthMargin: CGFloat {get set}
    var heightMargin: CGFloat {get set}
    var plusButtonView: PlusButtonView? {get set}
    var addOptions: Array<AddMenuRow>? {get set}
    
    func showPlusButton(delegate: AddMenuDelegate, bottomMargin: CGFloat)
    func hidePlusButton(hidden: Bool)
}

extension ShowingAddMenu where Self: UIViewController, Self: PlusButtonViewDelegate {
    
    func hidePlusButton(hidden: Bool) {
        plusButtonView?.isHidden = hidden
    }
    
    func showPlusButton(delegate: AddMenuDelegate, bottomMargin: CGFloat = 0) {
        if (plusButtonView == nil) {
            if let addOptions = addOptions {
                plusButtonView = PlusButtonView.instanceFromNib() as? PlusButtonView
                view.addSubview(plusButtonView!)
                plusButtonView!.translatesAutoresizingMaskIntoConstraints = false
                view.addConstraints([NSLayoutConstraint(item: plusButtonView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: plusButtonView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: bottomMargin)])
                
                widthMargin = view.frame.size.width - plusButtonView!.frame.size.width
                heightMargin = view.frame.size.height - plusButtonView!.frame.size.height - 44
                widthConstraint = NSLayoutConstraint(item: plusButtonView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: widthMargin)
                heightConstraint = NSLayoutConstraint(item: plusButtonView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: heightMargin)
                view.addConstraints([widthConstraint!, heightConstraint!])
                plusButtonView!.plusButtonDelegate = self
                plusButtonView!.menuDelegate = delegate
                plusButtonView!.menuRows = addOptions
            }
        }
    }
    
    
    //MARK: - PlusButtonViewDelegate Methods
    func fabTapped(isOpen: Bool) {
        if !isOpen {
            widthConstraint!.constant = 0
            heightConstraint!.constant = 0
        } else {
            widthConstraint!.constant = widthMargin
            heightConstraint!.constant = heightMargin
        }
        self.view.layoutIfNeeded()
    }
}
