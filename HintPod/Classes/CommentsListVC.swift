//
//  CommentsListVC.swift
//  HintPod
//
//  Created by Marawan Alwaraki on 06/04/2019.
//

import UIKit

class CommentsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SuggCellDelegate {
    
    var commentAlert: AddCommentAlert?
    
    var suggestion: Suggestion!
    var comments: [Comment] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bundle = Bundle(for: self.classForCoder)
        commentAlert = bundle.loadNibNamed("AddCommentAlert", owner: self, options: nil)!.last as? AddCommentAlert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComments()
    }
    
    func loadComments() {
        APIManager.loadComments(suggestionId: suggestion.id, success: { (comments) in
            self.comments = comments
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : comments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionsListCell") as! SuggestionsListCell
            cell.loadCell(with: suggestion)
            
            if let userId = UserDefaults.standard.string(forKey: "HPUserId") {
                cell.checkVotes(for: userId, with: suggestion)
            }
            
            cell.delegate = self
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsListCell") as! CommentCell
            cell.commentLabel.text = comments[indexPath.row].content
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "Comments"
    }
    
    @IBAction func tappedComment(_ sender: Any) {
        
        let bundle = Bundle(for: self.classForCoder)
        commentAlert = bundle.loadNibNamed("AddCommentAlert", owner: self, options: nil)!.last as? AddCommentAlert
        commentAlert!.commentsListVC = self
        commentAlert!.present()
    }
    
    func loadNewComment() {
        APIManager.loadComments(suggestionId: self.suggestion.id, success: { (comments) in
            self.comments = comments
            self.tableView.reloadSections([1], with: .automatic)
        }, error: { (error) in
            print(error)
        })
    }
    
    func tappedUpvote(_ cell: SuggestionsListCell, selected: Bool) {
        vote(cell: cell, upvote: true, selected: selected)
    }
    
    func tappedDownvote(_ cell: SuggestionsListCell, selected: Bool) {
        vote(cell: cell, upvote: false, selected: selected)
    }
    
    func vote(cell: SuggestionsListCell, upvote: Bool, selected: Bool) {
        
        guard let suggestionId = suggestion.id else {
            print("can't find suggestion id")
            return;
        }
        
        if let p = self.parent?.children.first as? SuggestionsListVC {
            
            guard let userId = UserDefaults.standard.string(forKey: "HPUserId") else {
                return;
            }
            
            let pSuggestion = p.suggestions.filter{$0.id==suggestionId}.first
            
            if selected {
                pSuggestion?.votes[userId] = upvote
            } else {
                pSuggestion?.votes[userId] = nil
            }
            
            let index = p.suggestions.index(where: { (item) -> Bool in
                item.id == self.suggestion.id // test if this is the item you're looking for
            })!
            
            p.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
        }
        
        APIManager.vote(suggestionId: suggestionId, upvote: upvote, voting: selected, success: {
            print("successfully voted")
        }) { (error) in
            print(error)
        }
    }

}