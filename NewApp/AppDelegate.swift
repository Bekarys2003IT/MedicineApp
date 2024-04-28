//
//  AppDelegate.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = ScreenViewController()
        self.window?.makeKeyAndVisible()
        
        
        let userRequest = RegisterUserRequest(userName: "Bekarys",
                                              email: "bekaris000603@gmail.com",
                                              password: "Bekarys2003")
        Authservice.shared.registerUser(with: userRequest) { wasRegistered, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            print("User was registered", wasRegistered)
                
        }
        checkAuthentication()
        let config = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in

                        if (oldSchemaVersion < 1) {
                            // Nothing to do!
                            // Realm will automatically detect new properties and removed properties
                            // And will update the schema on disk automatically
                        }
                    })

                // Tell Realm to use this new configuration object for the default Realm
                Realm.Configuration.defaultConfiguration = config

                // Now that we've told Realm how to handle the schema change, opening the file
                // will automatically perform the migration
                let realm = try! Realm()

                return true
    }
   
    
    public func checkAuthentication(){
        if Auth.auth().currentUser ==  nil{
            self.goToController(with: SignViewController())
        } else {
            //go to TabbarController
            self.goToController(with: TabBarController())
        }
    }
    private func goToController(with viewController:UIViewController){
        DispatchQueue.main.async { [weak self] in
                  if let self = self {
                      UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                          self.window?.rootViewController = UINavigationController(rootViewController: viewController)
                      }, completion: nil)
                  }

        }
    }

   


}

