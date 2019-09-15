//
//  APIManager.swift
//  HintPod
//
//  Created by Marawan Alwaraki on 23/03/2019.
//

import Foundation
import Alamofire

class APIManager {
    
    static func loadSuggestions(success: @escaping ([Suggestion]) -> (), error: @escaping (String) -> ()) {
        
        guard let projectId: String = UserDefaults.standard.string(forKey: "HPProjectId") else {
            error("Failed to load project id")
            return;
        }
        
        guard let companyId: String =
            UserDefaults.standard.string(forKey: "HPCompanyId") else {
                error("Failed to load company id")
                return;
            }
        
        Alamofire.request(Constants.baseURL + "loadSuggestions?projectId=\(projectId)" +
            "&companyId=\(companyId)").responseJSON { (response) in
            if (response.error != nil) {
                // Handle error.
                error("Failed to load suggestions")

            } else {
                // Success...
                if let json = response.result.value {
                    var array:Array<AnyObject>!

                    array = json as? Array<AnyObject>
                    
                    var suggestions = [Suggestion]()
                    
                    for a in array {
                        let suggestion = Suggestion(json: a)
                        suggestions.append(suggestion)
                    }

                    success(suggestions)

                } else {
                    error("No date types found!")
                }

            }
        }
    }
    
    static func addSuggestion(title: String, content: String, success: @escaping () -> (), error: @escaping (String) -> ()) {
        
        guard let userId: String = UserDefaults.standard.string(forKey: "HPUserId") else {
            error("Failed to load user id")
            return;
        }
        guard let projectId: String = UserDefaults.standard.string(forKey: "HPProjectId") else {
            error("Failed to load project id")
            return;
        }
        
        var parameters = "addSuggestion?title=\(title)&content=\(content)&userId=\(userId)&projectId=\(projectId)"
        
        print(parameters)
        
        parameters = parameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        print(parameters)
        
        Alamofire.request(Constants.baseURL + parameters).response { (response) in
            if (response.error != nil) {
                // Handle error.
                error("Failed to add suggestion, \(response.error!.localizedDescription)")
                
            } else {
                // Success...
                success()
                
            }
        }
    }
    
    static func loadComments(suggestionId: String, success: @escaping ([Comment]) -> (), error: @escaping (String) -> ()) {
        
//        guard let userId: String = UserDefaults.standard.string(forKey: "HPUserId") else {
//            error("Failed to load user id")
//            return;
//        }
        
        Alamofire.request(Constants.baseURL + "loadComments?suggestionId=\(suggestionId)").responseJSON { (response) in
            if (response.error != nil) {
                // Handle error.
                error("Failed to load comments")
                
            } else {
                // Success...
                if let json = response.result.value {
                    var array:Array<AnyObject>!
                    
                    array = json as? Array<AnyObject>
                    
                    var comments = [Comment]()
                    
                    for a in array {
                        let comment = Comment(json: a)
                        comments.append(comment)
                    }
                    
                    success(comments)
                    
                } else {
                    error("No date types found!")
                }
                
            }
        }
    }
    
    static func addComment(suggestionId: String, comment: String, success: @escaping () -> (), error: @escaping (String) -> ()) {
        
        guard let userId: String = UserDefaults.standard.string(forKey: "HPUserId") else {
            error("Failed to load user id")
            return;
        }
        
        var parameters = "addComment?userId=\(userId)&content=\(comment)&suggestionId=\(suggestionId)"
        parameters = parameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(Constants.baseURL + parameters).response { (response) in
            if (response.error != nil) {
                // Handle error.
                error("Failed to add comment, \(response.error!.localizedDescription)")
                
            } else {
                // Success...
                success()
                
            }
        }
    }
    
    static func vote(suggestionId: String, upvote: Bool, voting: Bool, success: @escaping () -> (), error: @escaping (String) -> ()) {
        
        guard let userId: String = UserDefaults.standard.string(forKey: "HPUserId") else {
            error("Failed to load user id")
            return;
        }
        guard let projectId: String = UserDefaults.standard.string(forKey: "HPProjectId") else {
            error("Failed to load project id")
            return;
        }
        
        var parameters = "voteSuggestion?userId=\(userId)&projectId=\(projectId)"
            + "&suggestionId=\(suggestionId)&upvote=\(upvote ? "true" : "false")"
            + "&voting=\(voting ? "true" : "false")"
        
        parameters = parameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(Constants.baseURL + parameters).response(completionHandler: { (response) in
            if (response.error != nil) {
                // Handle error.
                error(("Failed to vote on suggestion, \(response.error!.localizedDescription)"))
                
            } else {
                // Success...
                success()
                
            }
        })
        
    }
    
    static func registerUser(id: String, name: String?, success: @escaping (String) -> (), error: @escaping (String) -> ()) {
        
        guard let projectId: String = UserDefaults.standard.string(forKey: "HPProjectId") else {
            error("Failed to load project id")
            return;
        }
        
        var parameters = ""
        if name == nil {
            parameters = "verifyUser?uniqueId=\(id)&projectId=\(projectId)"
        } else {
            parameters = "verifyUser?uniqueId=\(id)&name=\(name!)&projectId=\(projectId)"
        }
        
        print(parameters)
        parameters = parameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(parameters)
        parameters = parameters.replacingOccurrences(of: " ", with: "+")
        print(parameters)
        
        Alamofire.request(Constants.baseURL + parameters).responseString(completionHandler: { (response) in
            if (response.error != nil) {
                // Handle error.
                error(("Failed to verify user, \(response.error!.localizedDescription)"))
                
            } else {
                // Success...
                success(response.result.value!)
                
            }
        })
    }
    
}
