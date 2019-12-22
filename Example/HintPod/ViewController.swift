//
//  ViewController.swift
//  HintPod
//
//  Created by melwaraki on 03/21/2019.
//  Copyright (c) 2019 melwaraki. All rights reserved.
//

import UIKit
import HintPod

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var jokesTable: UITableView!
    var jokes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokes.append("Have you ever tried eating a clock? It’s really time-consuming, especially if you go for seconds.")
        jokes.append("I used to be a banker but I lost interest…")
        jokes.append("Why can’t bikes stand? Because they are two tired")
        jokes.append("I was wondering why the frisbee was getting bigger, then it hit me.")
        jokes.append("Two antennas met on a roof, fell in love and got married. The ceremony wasn’t much, but the reception was excellent.")
        jokes.append("Why doesn’t the Sun go to college? – Because it has a million degrees.")
        jokes.append("I got hit in the head with a can of soda yesterday. Luckily for me, it was a soft drink.")
        jokes.append("I Googled “How to start a Wildfire”. I got 48,500 matches.")
        jokes.append("Did you hear about the restaurant on the moon? Great food, No atmosphere.")
        jokes.append("I make science puns, but only periodically.")
        jokes.append("Last night I had a dream that I was swimming in an ocean of orange soda. I guess it was just a Fanta sea!")
        jokes.append("Why did the gym close down? – It just didn’t work out.")
        jokes.append("Why did the electron leave the atom? Because it had its Ion someone else.")
        jokes.append("What is the best thing about living in Switzerland? – Well, the flag is a big plus.")
        jokes.append("I was very lonely so I bought some shares. It’s nice to have a bit of company")
    }

    @IBAction func tappedPresent(_ sender: Any) {
        HintPod.present(title: "App Feedback")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell") as! JokeCell
        cell.jokeLabel.text = jokes[indexPath.row]
        return cell
    }

}

class JokeCell: UITableViewCell {
    
    @IBOutlet weak var jokeLabel: UILabel!
}

