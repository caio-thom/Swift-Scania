//
//  AddViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 17/10/22.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var lbMensagem: UILabel!
    @IBOutlet weak var tfCadastrar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMensagem.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    
    @IBAction func checkTextfhields(_ sender: UIButton) {
        
        lbMensagem.text = ""
        if tfCadastrar.text!.isEmpty  {
            lbMensagem.text = "Nenhum codigo cadastrado"
        }
        else {
            lbMensagem.text = "Caminhão cadastrado com sucesso"
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
