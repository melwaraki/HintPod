
public class HintPod {
    
    public init() {
    }
    
    public static func present(with title: String?) {
        let bundle = Bundle(identifier: "org.cocoapods.HintPod")
        let sb = UIStoryboard(name: "HPMain", bundle: bundle!)
        let vc: UIViewController = sb.instantiateInitialViewController()!
        
//        if let title = title {
//            vc.children.first?.title = title
//        }
        
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
    public static func authenticate(user: HPUser, projectId: String, companyId: String) {
        
        if user.name != nil {
            UserDefaults.standard.set(user.name, forKey: "HPUserName")
        } else {
            UserDefaults.standard.set("Anonymous", forKey: "HPUserName")
        }
        
        UserDefaults.standard.set(projectId, forKey: "HPProjectId")
        UserDefaults.standard.set(companyId, forKey: "HPCompanyId")
        
        APIManager.registerUser(id: user.id, name: user.name, success: { HPid in
            UserDefaults.standard.set(HPid, forKey: "HPUserId")
            print("registered user")
        }) { (error) in
            print(error)
        }
        
    }
}
