//
//  LoginViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 16/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lbMenssagem: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)

            }
    
    
    @IBAction func checkTextfhields(_ sender: UIButton) {
        
        lbMenssagem.text = ""
        if tfSenha.text!.isEmpty || tfEmail.text!.isEmpty {
            lbMenssagem.text = "Todos os campos precisam ser preenchidos"
        }
            else {
                performSegue(withIdentifier: "logar", sender: nil)
            }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMenssagem.text = ""

        

        // Do any additional setup after loading the view.
    }
    
    

    

}
