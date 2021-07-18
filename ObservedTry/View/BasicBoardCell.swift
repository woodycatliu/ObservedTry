//
//  Board.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

protocol BoardProtocol {
    func add()
    func subtract()
    func toggle()
}

typealias BoardCellProtocol = UITableViewCell & BoardProtocol

class BasicBoardCell: BoardCellProtocol {
    
    public enum Color {
        case yellow
        case blue
        
        var uiColor: UIColor {
            if self == .yellow {
                return .yellow
            }
            return .cyan
        }
        
        init(_ bool: Bool) {
            if bool {
                self = .yellow
                return
            }
            self = .blue
        }
    }
    
    public var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.brown.cgColor
        return view
    }()
    
    public lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .black
        lb.adjustsFontForContentSizeCategory = true
        lb.isUserInteractionEnabled = true
        return lb
    }()
    
    public lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .black
        lb.adjustsFontForContentSizeCategory = true
        return lb
    }()
    
    public lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(add), for: .touchUpInside)
        btn.setBackgroundImage(UIImage(systemName: "plus.rectangle"), for: .normal)
        return btn
    }()
    
    public lazy var subtractButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(subtract), for: .touchUpInside)
        btn.setBackgroundImage(UIImage(systemName: "minus.rectangle"), for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        
        let zoneView = UIView()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(zoneView)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 65),
            subtractButton.heightAnchor.constraint(equalToConstant: 40),
            subtractButton.widthAnchor.constraint(equalToConstant: 65),
        ])
        
        zoneView.addSubview(addButton)
        zoneView.addSubview(subtractButton)
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: subtractButton.leadingAnchor, constant: -5),
            subtractButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            addButton.centerYAnchor.constraint(equalTo: zoneView.centerYAnchor, constant: 40),
            addButton.centerXAnchor.constraint(equalTo: zoneView.centerXAnchor, constant: -35)
        ])
        
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        
        cardView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5)
        ])
        
        
        
        contentView.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggle)))
    }
    
}

// MARK: Logic
extension BasicBoardCell {

    func toggleColor(_ bool: Bool) {
        let colorType = Color.init(bool)
        cardView.backgroundColor = colorType.uiColor
    }
}


// MARK: objc
extension BasicBoardCell {
    
    @objc func add() {
    }
    
    @objc func subtract() {
    }
    
    @objc func toggle() {
    }
}
