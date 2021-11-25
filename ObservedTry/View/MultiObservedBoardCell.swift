//
//  MultiObservedBoardCell.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/11/25.
//

import UIKit

class MultiObservedBoardCell: BasicBoardCell {
    
    private let viewModel: MultiObservedViewModel = MultiObservedViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        observed()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.updateID(nil)
    }
    
    private func observed() {
        viewModel.$blog {
            [weak self] blog in
            guard let self = self else { return }
            
            self.titleLabel.text = blog.id
            
            self.countLabel.text = String(blog.count)
            
            self.toggleColor(blog.toggle)
        }
    }
    
    func configureID(_ id: String?) {
        viewModel.updateID(id)
    }
}

// MARK: objc
extension MultiObservedBoardCell {
    
    @objc override func add() {
        viewModel.add()
    }
    
    @objc override func subtract() {
        viewModel.subtract()
    }
    
    @objc override func toggle() {
        viewModel.toggle()
    }
}
