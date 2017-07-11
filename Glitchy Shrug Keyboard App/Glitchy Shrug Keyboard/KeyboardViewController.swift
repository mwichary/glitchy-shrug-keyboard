//
//  KeyboardViewController.swift
//  Glitchy Shrug Keyboard
//
//  Created by Marcin Wichary on 7/10/17.
//  Copyright © 2017 Marcin Wichary. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

  @IBOutlet var shrugButton: UIButton!
  @IBOutlet var nextKeyboardButton: UIButton!
  @IBOutlet var slider: UISlider!
  
  private var currentShrugString: String!

  private func getShrugString(value: Int) -> String {
    var text = "¯\\_("
    for _ in 0...value {
      text += "ツ"
    }
    text += ")_/¯"
    return text
  }
  
  @objc
  private func didTapButton(sender: UIButton) {
    //if let entity = sender.representedEntity {
      textDocumentProxy.insertText(self.currentShrugString + " ")
    //}
  }
  
  @objc
  private func didMoveSlider(sender: UISlider) {
    let value = Int(sender.value)
    self.currentShrugString = self.getShrugString(value: value)
    self.shrugButton.setTitle(self.currentShrugString, for: [])
  }
  
  private func addUserInterface() {
    // Shrug button
    
    self.shrugButton = UIButton(type: .custom) // .custom prevents animation when changing title
    
    self.shrugButton.setTitle(NSLocalizedString(self.currentShrugString, comment: "TK"), for: [])
    self.shrugButton.contentEdgeInsets = UIEdgeInsetsMake(70, 0, 70, 0)
    self.shrugButton.sizeToFit()
    self.shrugButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.shrugButton.titleLabel?.textAlignment = NSTextAlignment.center
    self.shrugButton.setTitleColor(UIColor.black, for: .normal)
    
    self.shrugButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
    
    self.view.addSubview(self.shrugButton)
    
    self.shrugButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.shrugButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    self.shrugButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    
    // Slider
    
    self.slider = UISlider()
    
    self.slider.minimumValue = 0
    self.slider.maximumValue = 20
    self.slider.translatesAutoresizingMaskIntoConstraints = false
    
    self.slider.addTarget(self, action: #selector(didMoveSlider(sender:)), for: .valueChanged)
    
    self.view.addSubview(self.slider)
    
    self.slider.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.slider.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    self.slider.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.shrugButton.frame.size.height).isActive = true
    
    
    // Next keyboard button
    
    self.nextKeyboardButton = UIButton(type: .system)
    
    self.nextKeyboardButton.setTitle(NSLocalizedString("More kbs", comment: "TK"), for: [])
    self.nextKeyboardButton.sizeToFit()
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    
    self.view.addSubview(self.nextKeyboardButton)
    
    self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
  

  override func updateViewConstraints() {
    super.updateViewConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.currentShrugString = self.getShrugString(value: 0)
    
    self.addUserInterface()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func textWillChange(_ textInput: UITextInput?) {
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    var textColor: UIColor
    let proxy = self.textDocumentProxy
    if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
      textColor = UIColor.white
    } else {
      textColor = UIColor.black
    }
    self.nextKeyboardButton.setTitleColor(textColor, for: [])
  }

}
