//
//  ViewController.swift
//  testkit
//
//  Created by electrozone on 3/26/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var isHello = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblHello.text = "안녕하세요!"//class property
        lblHello.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblHello.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblHello.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        _ = sender // silence unused parameter warning
        if isHello{
            lblHello.text = "반갑습니다."
        }else{
            lblHello.text = "안녕하세요!"
        }
        isHello.toggle()
    }
    
}
