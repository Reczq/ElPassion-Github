import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        application.statusBarStyle = UIStatusBarStyle.lightContent

        return true
    }
}

