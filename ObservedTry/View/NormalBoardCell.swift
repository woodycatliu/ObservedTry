//
//  NormalBoardCell.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

protocol NormalBoardCellDelegate: AnyObject {
    func add(_ indexPath: IndexPath?)
    
    func subtract(_ indexPath: IndexPath?)
    
    func toggle(_ indexPath: IndexPath?)
}

class NormalBoardCell: BasicBoardCell {
    weak var delegate: NormalBoardCellDelegate?
    
    var indexPath: IndexPath?
}


// MARK: objc
extension NormalBoardCell {
    
    @objc override func add() {
        delegate?.add(indexPath)
    }
    
    @objc override func subtract() {
        delegate?.subtract(indexPath)
    }
    
    @objc override func toggle() {
        delegate?.toggle(indexPath)
    }
}
