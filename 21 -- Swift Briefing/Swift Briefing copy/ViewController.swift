//
//  ViewController.swift
//  Swift Briefing copy
//
//  Created by Joe Rocca on 4/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet var agentNameTextField: UITextField!
    @IBOutlet var agentPasswordTextField: UITextField!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var missionBriefingTextView: UITextView!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        agentNameTextField.text = ""
        greetingLabel.text = "";
        missionBriefingTextView.text = "";
        
        agentNameTextField.delegate = self
        agentPasswordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func authenticateAgent(sender: UIButton)
    {
      authenticate()
    }
    

    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        if textField == agentNameTextField
        {
        agentNameTextField.resignFirstResponder()
        agentPasswordTextField.becomeFirstResponder()
        }
        if textField == agentPasswordTextField
        {
            agentPasswordTextField.resignFirstResponder()
            
            
            if !agentPasswordTextField.text.isEmpty
            {
            authenticate()
            }
        }
        
        return true
    }
    
    
    
    
    
    func authenticate()
    {
        
        
        if !agentNameTextField.text.isEmpty && !agentPasswordTextField.text.isEmpty
        {
            var nameParts = (agentNameTextField.text.componentsSeparatedByString(" "))
            var agentName = nameParts[0]
            if nameParts.count == 2
            {
                agentName = nameParts[1]
            }
            greetingLabel.text = String(format: "Good evening, Agent %@", agentName)
            
            self.missionBriefingTextView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(agentName), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds."
            
            
            
            self.view.backgroundColor = UIColor.greenColor()
            
            
        }
        else
        {
            self.view.backgroundColor = UIColor.redColor()
        }
        
    }
    
    
    
    
    
    
    
    
    
}

