//
//  SuporteViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 16/10/22.
//

import UIKit

class SuporteViewController: UIViewController {
    
    @IBOutlet weak var tfUrgencia: UITextField!
    @IBOutlet weak var tfProblema: UITextField!
    @IBOutlet weak var lbMenssagem: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMenssagem.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func checkTextfhields(_ sender: UIButton) {
        
        lbMenssagem.text = ""
        if tfProblema.text!.isEmpty || tfUrgencia.text!.isEmpty {
            lbMenssagem.text = "Todos os campos precisam ser preenchidos"
        }
        else{
            lbMenssagem.text = "Problema enviado com sucesso "
        }
        
    }
}
