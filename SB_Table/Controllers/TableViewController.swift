//
//  TableViewController.swift
//  SB_Table
//
//  Created by andrew on 18.04.22.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [Emoji(emoji: "๐", description: "Hahaha", name: "Lol", isFavourite: true),
                   Emoji(emoji: "๐", description: "It was shame", name: "Shame", isFavourite: true),
                   Emoji(emoji: "๐", description: "Wassup", name: "Another smile", isFavourite: true),
                   Emoji(emoji: "๐ญ", description: "I',m crying", name: "Sad Smile", isFavourite: false)]
    override func viewDidLoad() {
        super.viewDidLoad()

  
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else {return}
        let sourceNWC = segue.source as! NewTableViewController  // ะบะฐััะธะผ
        let emoji = sourceNWC.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            
        let newIndexPath = IndexPath(row: objects.count
                                     , section: 0)
        objects.append(emoji)
      
        tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        	
        let navigationVC = segue.destination as! UINavigationController
        let newTableVC = navigationVC.topViewController as! NewTableViewController
        newTableVC.emoji = emoji
        newTableVC.title = "Edit"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        // Configure the cell...
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //ะดะตัะพะปั ะดัะปะธั
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //ะฟัะธะฝะธะผะฐะตั editing style
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath] , with: .fade)//ััะนะด ะตัะพ ะฐะฝะธะผะฐัะธั ะฟัะธ ัะดะฐะปะตะฝะธะธ
        }
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //ัะพะทะดะฐะตะผ ะบะพะฝััะฐะฝัั ะดะปั ะฟะพะปััะฐะตะผะพะณะพ ะธะท ััะฝะบัะธะธ ัะธ ะบะพะฝัะตะบััะฐะป ัะบัะธะฝ
        let done = doneAction(at: indexPath)
        let like = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done,like])
    }
    func doneAction(at IndexPath: IndexPath ) -> UIContextualAction {//ัะพะทะดะฐะตะผ ะฟะพ ัะฐะบัั ััะบะฝัะธั ั ะบะพัะพัะพะน ะฑัะดะตั ะธ ะฒะพะทะฒัะฐัะฐัััั ัะบัะฝ ะดะปั ััะฝะบัะธะธ ะฒััะต,ะดะปั ัะดะฐะปะตะฝะธั ะฟะพ ัะฒะฐะนะฟั
        let action = UIContextualAction(style: .destructive, title: "Done") { (action,view,completion) in self.objects.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)// ะฟะพ ัะฒะฐะนะฟั ะฑัะดะตั ัะดะฐะปะตะฝะธะต ะธ ัะพะพัะฒะตัะฒะตะฝะฝะพ ัะดะฐะปัะตะผ ะฒ ะดะฒัั ะผะตััะฐั ะธ ะฒ ััะนะฑะป ะฒัั ะธ ะฒ ะผะฐััะธะฒะต
            completion(true)//complition true ะพะทะฝะฐัะฐะตั ััะพ ะฝะฐ ััะพะผ ััะฐะฟะต ะบะพะฝะตั ะดะตะนััะฒะธั ะธ ะฝะธัะตะณะพ ะฝะต ะฑัะดะตั
        }
            action.backgroundColor = .systemOrange
            action.image = UIImage(systemName: "checkmark.circle")
            return action
    }
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {// ะฟะพะฒัะพััะตะผ ะตัะต ะพะดะธะฝ ัะบัะฝ ะดะปั ะบะฝะพะฟะบะธ ะปะฐะนะบะฐ,  ะดะตะปะฐะตะผ ะตัะต ะพะดะฝั ััะฝะบัะธั
        var object = objects[indexPath.row]//ััััะธะผัั ะดะพ ะพะฑัะตะบัะฐ ะธะท ะผะฐััะธะฒะฐ ะฟะพ ะธะฝะดะตะบั ะฟะฐั
        let action = UIContextualAction(style: .normal, title: "Like", handler: {(action,view,completion)  in
            object.isFavourite = !object.isFavourite //ะพะฑัะฐัะฝะพะต ะทะฝะฐัะตะฝะธะต
            self.objects[indexPath.row] = object // ะฟัะธัะฐะธะฒะฐะตะผ ะฟะพ ะธะฝะดะตะบั ะฟะฐัั ะฟัะธัะพะดััะตะผั ะฝะพะฒะพะต ะทะฝะฐัะตะฝะธะต,ะบะฐะบ ั ะฟะพะฝัะป ะฟะพ ะฐะฝะฐะปะพะณะธะธ ะดะปั ััะนะฑะป ะฒัั, ัะพะตััั ะฑะตะท ััะพะณะพ ะฑั ะผะตะฝัะปะพัั ะฒ ััััะบัััะต ะธะท ััะนะฒะพัะธั , ะฝะพ ะฝะฐ ัะฐะผะพะผ ััะนะฑะป ะฒัั ะฑั ััะพ ะฝะธะบะฐะบ ะฝะต ะพะฑะฝะพะฒะปัะปะพัั
            completion(true)
        })
        action.image = UIImage(systemName: "heart")
        action.backgroundColor = object.isFavourite ? .systemGreen : .systemGray2
        /* if object.isFavourite {
            action.backgroundColor = .systemGreen
        } else {
            action.backgroundColor = .systemGray2
        }
         */
        return action
    }
}

