//
//  Board.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

class ObservedBoardCell: BasicBoardCell {
    
    var viewModel: BoardViewModel? {
        didSet {
            // about: $
            // 可以參考:
            // https://insights.dice.com/2019/06/12/xcode-swiftui-dollar-sign-prefix/
            viewModel?.$blog.cancel()
            
            viewModel?.$blog {
                [weak self] blog in
                guard let self = self else { return }
                
                self.titleLabel.text = blog.id
                
                self.countLabel.text = String(blog.count)
                
                self.toggleColor(blog.toggle)
                
            }
        }
    }
}

// MARK: objc
extension ObservedBoardCell {
    
    @objc override func add() {
        viewModel?.add()
    }
    
    @objc override func subtract() {
        viewModel?.subtract()
    }
    
    @objc override func toggle() {
        viewModel?.toggle()
    }
}
