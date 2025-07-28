//
//  AppDelegate.swift
//  Tea recipe
//


import UIKit
import OneSignalFramework
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation: UIInterfaceOrientationMask = .all
    private let oneSignalIDCheker = OneSignalIDChecker()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // AppsFlyer Init
           AppsFlyerLib.shared().appsFlyerDevKey = "foKmeP3eBS8q83MR2BZBCb"
           AppsFlyerLib.shared().appleAppID = "6749095515"
           AppsFlyerLib.shared().delegate = self
           AppsFlyerLib.shared().isDebug = true
           
        AppsFlyerLib.shared().start()
        let appsFlyerId = AppsFlyerLib.shared().getAppsFlyerUID()
        
        //MARK: - One signal
        OneSignal.initialize("b730e0ba-0ab7-4802-8415-a5831ae7fb9a", withLaunchOptions: nil)
        oneSignalIDCheker.startCheckingOneSignalID()
        
        OneSignal.login(appsFlyerId)
        
        // Установка external_id для текущего пользователя
        OneSignal.User.addTags(["external_id": appsFlyerId])
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


}

