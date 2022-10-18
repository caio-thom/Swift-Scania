//
//  AppDelegate.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 26/09/22.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        //O delegate é definido no UNUserNotificationCenter como sendo esta propria classe
                //com isso a classe ira responder pelo UNUserNotificationCenter
                UNUserNotificationCenter.current().delegate = self
                
                //primeiro [e solicitado que seja fornecido o ajuste atual, ou seja o que o usuario respondeu quando foi solicitado a permissao
                UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                    
                    //se o status de autorizacao for notDetermined siginifica que o usuario nunca foi pedido para aceitar (ou seja é a primeria vez que o app pe aberto
                    //Nessa caso, sera solicitado a permissao
                    if settings.authorizationStatus == .notDetermined {
                        
                        //cria um arquivo de opcoes, indicando o que a notificacao ira fazer
                        //ira mostrar o alerta da notoficacao e trocar em som
                        let options : UNAuthorizationOptions = [.alert, .sound]
                        
                        //solicitamos a autorizacao atravez do metado requestAuthorization
                        UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: { (success,error) in
                            
                            //a propriedade success indica se o usuario autorizou ou nao
                            if error == nil{
                                print(success)
                            }
                            else {
                        print(error!.localizedDescription)
                    }
                })
                
            }
            //se o usuario tiver negado, sempre sera imprimido a mensagem abaixo
            else if settings.authorizationStatus == .denied {
                print("User negou a notificacao ")
            }
        }

        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ScaniaAssist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //chamado quando a notificacao for aparecer com o app aberto
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler ([.list, .banner,  .sound])
        /*.list sends notifications only to Notification Center.
        // .banner sends notifications only to banner.
        [.list] will only show the notification in the notification center (the menu that shows when you pull down from the top)
        [.banner] will only pop down a banner from the top like a normal push notification
        [.list, .banner] will do both: show the banner and also make sure it's on the list.
        [.alert] does essentially the same as having [.list, .banner], from what I can tell. They just added these two options to give more granular control.
*/
    }
        //chamado quando a notificacao for aparecer com o app fechado ou em background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
