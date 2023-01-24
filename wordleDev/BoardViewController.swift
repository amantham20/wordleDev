//
//  BoardViewController.swift
//  wordleDev
//
//  Created by Aman Dhruva Thamminana on 1/16/23.
//

import UIKit

protocol BoardViewControllerDataSource: AnyObject {
    var currentGuesses: [[Character?]] {get}
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

//    var guesses :[[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6) // 5 character for 6 tries
    weak var dataSource: BoardViewControllerDataSource?
    
    var FinishedRows : [Bool] = Array(repeating: false, count: 6)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyCVCell.self, forCellWithReuseIdentifier: KeyCVCell.identifier)
        
        collectionView.backgroundColor = .clear
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        

    }
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    func flipAnimations(rowIndex: Int){
        
    }
    

}

extension BoardViewController{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = dataSource?.currentGuesses ?? []
        
        return guesses[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCVCell.identifier, for: indexPath) as? KeyCVCell else{
            fatalError()
        }
        
        cell.backgroundColor = dataSource?.boxColor(at: indexPath)
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.borderWidth = 2
        
        let guesses = dataSource?.currentGuesses ?? []
        
        if let letter = guesses[indexPath.section][indexPath.row] {
            cell.configure(with: letter)
//            if FinishedRows[indexPath.section] == false {
//                cell.GetFlipped()
//            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGFloat = (collectionView.frame.size.width - 20 )/5
        
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 1)
    }
    
}
