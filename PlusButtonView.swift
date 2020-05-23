//
//  PlusButtonView.swift
//  Camilyo App
//
//  Created by Max Pevsner on 21/11/2018.
//  Copyright © 2018 Camilyo. All rights reserved.
//

import UIKit

protocol PlusButtonViewDelegate: class {
    func fabTapped(isOpen: Bool)
}

protocol AddMenuDelegate: class {
    func addMenuOptionTapped(index: Int)
}

class PlusButtonView: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var addButtonView: UIView!
    @IBOutlet weak var addButtonViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingTableViewConstraint: NSLayoutConstraint!
    
    weak var plusButtonDelegate: PlusButtonViewDelegate?
    weak var menuDelegate: AddMenuDelegate?
    var menuRows: Array<AddMenuRow> = Array<AddMenuRow>()
    
    private var closingOverlayTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    private var isMenuOpen: Bool = false //default value
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    //MARK: - Initialization
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PlusButtonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButtonView.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView.register(UINib(nibName: "AddMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "AddMenuTableViewCell")
    }
    
    
    //MARK: - Actions
    @IBAction func addButtonTapped(gestureRecognizer: UITapGestureRecognizer) {
        openCloseMenu()
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0 //default value
        
        numRows = menuRows.count
        
        return numRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMenuTableViewCell", for: indexPath) as! AddMenuTableViewCell
        
        cell.setData(addMenuRow: menuRows[indexPath.row])
        
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = menuDelegate {
            delegate.addMenuOptionTapped(index: indexPath.row)
        }
        openCloseMenu()
    }
    
    
    //MARK: - UIGestureRecognizerDelegate Methods
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if touchView.isDescendant(of: optionsTableView) {
                return false
            }
        }
        
        return true
    }
    
    
    //MARK: - Private Methods
    private func openCloseMenu() {
        if !isMenuOpen {
            topTableViewConstraint.constant = optionsTableView.rowHeight * CGFloat(menuRows.count) + (addButtonViewHeightConstraint.constant / 2) + 8//bottom margin
            bottomTableViewConstraint.constant = addButtonViewHeightConstraint.constant + 8
            leadingTableViewConstraint.constant = 150
        } else {
            topTableViewConstraint.constant = 0
            bottomTableViewConstraint.constant = 0
            leadingTableViewConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if !self.isMenuOpen {
                self.addButtonView.transform = CGAffineTransform(rotationAngle: CGFloat(5 * Double.pi / -4))
                self.overlayView.layer.opacity = 1
                self.optionsTableView.isHidden = false
            } else {
                self.addButtonView.transform = .identity
                self.overlayView.layer.opacity = 0
                self.optionsTableView.isHidden = true
            }
            if let plusButtonDelegate = self.plusButtonDelegate {
                plusButtonDelegate.fabTapped(isOpen: self.isMenuOpen)
            }
            self.layoutIfNeeded()
        }) { (completed) in
            self.isMenuOpen = !self.isMenuOpen
        }
    }
}
