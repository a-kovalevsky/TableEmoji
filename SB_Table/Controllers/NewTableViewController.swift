//
//  NewTableViewController.swift
//  SB_Table
//
//  Created by andrew on 19.04.22.
//

import UIKit

class NewTableViewController: UITableViewController {
    var emoji = Emoji(emoji: "", description: "", name: "", isFavourite: true)
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emojiTF: UITextField!
    
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()//запускается когда экран загрузітся
        updateSaveButton()
    }
    private func updateSaveButton() {
        let description = descriptionTF.text ?? "" //тут проверяем т,так как аутлеты опциональные ,соотвественно теранрный оператор и потом через свойства изэмти через лгическое и ,затем также добавляем запуск этой функции в вью дид лоад и при обновлении аутлетов
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        saveButton.isEnabled = !description.isEmpty && !emojiText.isEmpty && !nameText.isEmpty
    }
    //функція для обновленія через едіт
    private func updateUI() {
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        descriptionTF.text = emoji.description
    }
    @IBAction func emojiEditCheck(_ sender: UITextField) {
         updateSaveButton()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        self.emoji = Emoji(emoji: emoji, description: description, name: name, isFavourite: self.emoji.isFavourite)
    }
    

}
