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
                schemaVersion: 3, // Ensure this matches the highest schema version used
                migrationBlock: { migration, oldSchemaVersion in
                    // Update migrations here if needed
                    if oldSchemaVersion < 2 {
                        // Example migration logic for schema version 2
                        migration.enumerateObjects(ofType: Medicine.className()) { oldObject, newObject in
                            // Initialize any new properties or handle data migration
                        }
                    }
                }
            )

            // Set this as the default configuration
            Realm.Configuration.defaultConfiguration = config

            // Now access Realm to trigger the migration
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

