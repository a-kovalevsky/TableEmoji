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
        updateUI()//запускается когда экран загрузітся (для обновленія через едіт походу)
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
         updateSaveButton()//при любом изменении в аутлетах будет запускаться эта функция ,она завязана плюсами на эдитинг на всех трех аутлетах
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let emoji = emojiTF.text ?? ""//как я понял доп проверка на нил
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        self.emoji = Emoji(emoji: emoji, description: description, name: name, isFavourite: self.emoji.isFavourite)
    }
    
    
    
    

    // MARK: - Table view data source
//ПО ФАКТУ ЕСЛИ У ВАС НЕ ДИНАМИЧЕСКИЙ КОНТЕНТ И НЕ НАДО ДЕЛАТЬ КАСТОМ ЯЧЕЙКИ ТО ВАМ НЕ НУЖНЫ ЭТИ ФУНКЦИИ(удаляем их), ВСЕ СДЕЛАНО В ИНТЕРФЕЙС БИЛДЕРЕ,В ЭТОТ РАЗ СТАТИЧЕСКИЕ ЯЧЕЙКИ
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
