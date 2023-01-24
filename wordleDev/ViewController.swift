//
//  ViewController.swift
//  wordleDev
//
//  Created by Aman Dhruva Thamminana on 1/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    let answer = "after"
    private var guesses :[[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6) // 5 character for 6 tries
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .darkGray
        
        addVC();
    }
    
    private func addVC(){
        addChild(keyboardVC);
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.delegate = self
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC);
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.dataSource = self
        view.addSubview(boardVC.view)
        
        NSLayoutConstraint.activate([
            
                
            
                boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
                boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
                
                keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                

            ])
    
    }
    
    


}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character) {
        print(letter)
        
//        var stop = false
        
        for i in 0..<guesses.count{
            for j in 0..<guesses[i].count{
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    boardVC.reloadData()
                    return
//                    stop = true
//                    break
                }
            }
//            if stop {
//                break
//            }
        }
        
        boardVC.reloadData()
    }
    
    
}

extension ViewController: BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap({$0}).count
        
        guard count == 5 else {
            return nil
        }
        
        
        
        let answerArr = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row] , answerArr.contains(letter) else {
            return nil
        }
        
        

        if answerArr[indexPath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
    }
}

