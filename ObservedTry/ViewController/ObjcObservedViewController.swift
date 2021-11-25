//
//  ObjcObservedViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/11/25.
//

import UIKit


class ObjcObservedViewController: UIViewController {
    private let colors: [UIColor] = [.green, .red]
    private let images: [String] = ["100", "101", "102"]
    private var circles: [UIView] {
        return [greenCircle, redCircle]
    }

    private var observation: NSKeyValueObservation?
    
    private let greenCircle: Circle = Circle()
    
    private let redCircle: Circle = Circle()
    
    private enum Light {
        case green, red
    }
    
    private var state: Light = .red {
        didSet {
            if oldValue != state {
                changeLight()
            }
        }
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.isPagingEnabled = true
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configuteUI()
        configuteScrollView()
        observed()
    }
    
    deinit {
        print("ObjcObservedViewController is deinit")
    }
    
    private func configuteUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 50, bottom: 0, right: 50)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        for i in circles.indices {
            let circle = circles[i]
            circle.backgroundColor = colors[i]
            circle.layer.borderWidth = 1.2
            circle.layer.borderColor = UIColor.darkGray.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            let constraint = circle.widthAnchor.constraint(equalTo: circle.heightAnchor)
            constraint.priority = .init(rawValue: 999)
            constraint.isActive = true
            stackView.addArrangedSubview(circle)
        }
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20)
        ])
    }

    private func configuteScrollView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        images.forEach {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: $0)
            imageView.layer.borderColor = UIColor.red.cgColor
            imageView.layer.borderWidth = 2
//            imageView.backgroundColor = .systemGray4
            stackView.addArrangedSubview(imageView)
           
            let width = imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            width.priority = .init(rawValue: 999)
            width.isActive = true
            
            let height = imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            height.priority = .init(rawValue: 999)
            height.isActive = true
        }
    }
}

extension ObjcObservedViewController {
    
    private func changeLight() {
        greenCircle.openLight(state != .red)
        redCircle.openLight(state != .green)
    }
    
    private func observed() {
        observation = scrollView.observe(\.contentOffset, options: [.initial, .new], changeHandler: {
            [unowned self] _,change in
            if let point = change.newValue {
                self.state = point.x == self.scrollView.bounds.width * 2 ? .red : .green
            }
        })
    }
    
    
}



class Circle: UIView {
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height / 2
            blackView.frame = bounds
            blackView.layer.cornerRadius = bounds.height / 2
        }
    }
    let blackView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        blackView.backgroundColor = .black.withAlphaComponent(0.8)
        addSubview(blackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func openLight(_ isHidden: Bool) {
        blackView.isHidden = isHidden
    }
}
