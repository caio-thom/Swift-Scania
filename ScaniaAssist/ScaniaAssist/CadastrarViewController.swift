//
//  CadastrarViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 16/10/22.
//

import UIKit

class CadastrarViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    @IBOutlet weak var lbMensagem: UILabel!
    @IBOutlet weak var tfConfirmar: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMensagem.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkTextFields(_ sender: UIButton) {
        view.endEditing(true)
        lbMensagem.text = ""
        if tfSenha.text!.isEmpty || tfEmail.text!.isEmpty || tfConfirmar.text!.isEmpty {
            lbMensagem.text = "Todos os campos precisam ser preenchidos"
        }
        
        else if  tfSenha.text != tfConfirmar.text {
            lbMensagem.text = "A senha deve ser igual"
            
        }
        
        else {
            performSegue(withIdentifier: "cadastrar", sender: nil)
        }
        
        
        

            
           
            
            
            
        }
        
    }

