//
//  KeyCVCell.swift
//  wordleDev
//
//  Created by Aman Dhruva Thamminana on 1/16/23.
//

import UIKit

class KeyCVCell: UICollectionViewCell {
    static let identifier  = "KeyCell"
    
    var isFlipped = false
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray3
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with letter: Character) {
        label.text = String(letter).uppercased()
    }
    
    func GetFlipped(){
        UIView.transition(with: self, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
        isFlipped = true
    }
}
