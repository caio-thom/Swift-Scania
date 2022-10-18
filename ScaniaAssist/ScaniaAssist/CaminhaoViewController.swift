//
//  CaminhaoViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 16/10/22.
//

import UIKit
import UserNotifications

class CaminhaoViewController: UIViewController {

    
    var datePicker = UIDatePicker()
    
    var alert: UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        datePicker.minimumDate = Date()
        
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
      
    }
    
    @objc func changeDate() {
        //o dateformatter = formatar a data
        let dateformatter = DateFormatter()
        
        //definindo o estilo que a data sera apresentada
        dateformatter.dateFormat = "dd/MM/yyyy HH:mm`h"
        
        //recuperando a data do datepicker para repassar para o TextField
        alert.textFields?.first?.text = dateformatter.string(from: datePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

        
    

    @IBAction func agendar(_ sender: UIButton) {
        
        //criando o Alert Controller como .alert
        alert = UIAlertController(title: "Lembrete", message: "QUando vôce quer ser lembrado de fazer a manutenção? ", preferredStyle: .alert)
        
        
        //Adicionar um text Field ao alert
        alert.addTextField {(textField) in
            textField.placeholder = "Data do lembrete"
            self.datePicker.date = Date()
            textField.inputView = self.datePicker // em vex de aparecer o telcado alfanumerico vai aparecer as datas
            
        }
        //adicionar botoes de agendar e cancelar
        // para criar a Action definimos o titulo e estilo
        //o estilo .default é padrao
        let okAction = UIAlertAction(title: "Agendar", style: .default) { (action) in
            self.schedule()
        }
        // a action nesse caso serve para cancelar a acao
        //melhor estilo para esse borao é .cancel
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        //adicina as duas actions ao alert
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        //mostra o alert para o usuario
        present(alert, animated: true, completion: nil)
    
    }
    
    func schedule() {
        let content = UNMutableNotificationContent()
        
        //Denini o titulo pela propriedade title
        content.title = "Lembrete"
        
        //defini a menssagem pela da propriedade body
        let title = "fazer manutenção"
        content.body = "fazer manutenção"
        
        //cria um objeto DateComponents que contem os elementos que formam uma data
        //Calendar = pega o calendario do device
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        
        //obejto que define a condicao para o disparo da notificacao
        let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponents , repeats: false)
        
        let request = UNNotificationRequest(identifier: "Lembrete", content: content, trigger: trigger)
        
        //Central de notoficacao do IOS
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }

}
