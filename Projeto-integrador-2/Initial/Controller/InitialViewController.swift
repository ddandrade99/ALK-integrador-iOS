//
//  InitialViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 06/09/22.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
       startButton.isUserInteractionEnabled = false
        participantsTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let participantes = Int(participantsTextField.text!) else {
            startButton.isUserInteractionEnabled = false
            startButton.backgroundColor = .gray
            return}
        if participantes < 1 {
            startButton.isUserInteractionEnabled = false
            startButton.backgroundColor = .gray
        } else {
            startButton.isUserInteractionEnabled = true
            startButton.backgroundColor = .systemGreen
        }
    }

    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard let participantes = Int(participantsTextField.text!) else {return}
        let categoriesViewController = CategoriesViewController(participantes)
        navigationController?.pushViewController(categoriesViewController, animated: true)
    }
    
    @IBAction func termsPressed(_ sender: Any) {
        let termsViewController = TermsViewController(nibName: "TermsViewController", bundle: nil)
        navigationController?.pushViewController(termsViewController, animated: true)
    }

}
