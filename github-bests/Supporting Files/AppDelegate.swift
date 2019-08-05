//
//  AppDelegate.swift
//  github-bests
//
//  Created by Paulo Lourenço on 02/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import OHHTTPStubs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    private func stubRequestsIfNeeded() {
//        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
//            print("TESTANDOOOOOOOOW")
//            stub(condition: { (request) -> Bool in
//                if let url = request.url?.absoluteString, url.contains("github.com"), url.contains("&page=1") {
//                    return true
//                }
//                return false
//            }) { (request) -> OHHTTPStubsResponse in
////                let stubPath = OHPathForFile("Mocks/page1.json", type(of: self))
////                return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
//                return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
//            }
//        }
//    }
    
    private func stubAPICallsIfNeeded() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            stub(condition: { (request) -> Bool in
                if let url = request.url?.absoluteString {
                    if url.contains("github.com"), url.contains("?page=1") {
                        return true
                    }
                    if url.contains("google-novo-logo.jpg") {
                        return true
                    }
                }
                return false
            }) { (request) -> OHHTTPStubsResponse in
                let repositories = SearchAPIMock().generateRepositories(count: 20)
                let results = SearchResults<[Repository]>(totalCount: repositories.count, incompleteResults: false, items: repositories)

                if let url = request.url?.absoluteString {
                    if url.contains("github.com") {
                        return OHHTTPStubsResponse(data: results.toData() ?? Data(), statusCode: 200, headers: nil)
                    } else if url.contains("google-novo-logo") {
                        let img = #imageLiteral(resourceName: "background")
                        return OHHTTPStubsResponse(data: img.pngData() ?? Data(), statusCode: 200, headers: nil)
                    }
                }
                return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        stubRequestsIfNeeded()

        stubAPICallsIfNeeded()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

