//
//  TableViewController.swift
//  SB_Table
//
//  Created by andrew on 18.04.22.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [Emoji(emoji: "😁", description: "Hahaha", name: "Lol", isFavourite: true),
                   Emoji(emoji: "😅", description: "It was shame", name: "Shame", isFavourite: true),
                   Emoji(emoji: "🙃", description: "Wassup", name: "Another smile", isFavourite: true),
                   Emoji(emoji: "😭", description: "I',m crying", name: "Sad Smile", isFavourite: false)]
    override func viewDidLoad() {
        super.viewDidLoad()

  
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else {return}//проверка что пришел с анвинда но к первому ненужно так как по фатку данных не передаем и чичто на отмену с кэнсел
        let sourceNWC = segue.source as! NewTableViewController  // кастим
        let emoji = sourceNWC.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            
        let newIndexPath = IndexPath(row: objects.count
                                     , section: 0)// тут тоже разобраться!!
        objects.append(emoji)//кроме того,что сейчас добавілі в массів не забывай обновлять вью,іначе в сімуляторе он толком і не появітся!!
      
        tableView.insertRows(at: [newIndexPath], with: .fade)//надо бы еше разобрать!!но как я понял мы создаем новый індекс паф где указываем в качестве роу,до добавленія нового элемента обўее колічесвто как номер последней ячейкі ,ну і секція ноль по умолчанію і юзаем метод інсерт роус по новому індек пафу і второй аргумент фэйд это анімація
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow! //фіксація індекс паф
        let emoji = objects[indexPath.row]
        	//далее через навігэйшн вію конт добіраемся до нью тэйбл вью конт
        let navigationVC = segue.destination as! UINavigationController
        let newTableVC = navigationVC.topViewController as! NewTableViewController //соответвенно через какой-то топвьюконтроллер і другой каст добралісь в начале до навігэйшн вію контролдлера а потом через него кастілісь до нью тэйблвьюконтроллер
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
        //дефолт дэлит
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //принимает editing style
            objects.remove(at: indexPath.row)//недостаточно только удалить объект массива,надо сообщить тэйбл вью что удаляется ячейка по индекс паф
            tableView.deleteRows(at: [indexPath] , with: .fade)//фэйд ето анимация при удалении
        }//также если ты удалишь что-либо уже в симуляторе и перезапустишь потом, останется столько же объектов в массиве сколько было в начале , так как нужно сохранять изменения в память устройства с core data,отдельный курс и тп/
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)//как с коробками в одном месте забрать (удалить из массива) по индексу сорса,и добавить в массив по индексу дестенэйшн плюс фикс удаления и в конце обновление таблицы
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //создаем константу для получаемого из функции юи контекшуал экшин
        let done = doneAction(at: indexPath)
        let like = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done,like])
    }
    func doneAction(at IndexPath: IndexPath ) -> UIContextualAction {//создаем по факту фукнцию с которой будет и возвращаться экшн для функции выше,для удаления по свайпу
        let action = UIContextualAction(style: .destructive, title: "Done") { (action,view,completion) in self.objects.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)// по свайпу будет удаление и соотвесвенно удаляем в двух местах и в тэйбл вью и в массиве
            completion(true)//complition true означает что на этом этапе конец действия и ничего не будет
        }
            action.backgroundColor = .systemOrange
            action.image = UIImage(systemName: "checkmark.circle")
            return action
    }
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {// повторяем еще один экшн для кнопки лайка,  делаем еще одну функцию
        var object = objects[indexPath.row]//стучимся до объекта из массива по индекс паф
        let action = UIContextualAction(style: .normal, title: "Like", handler: {(action,view,completion)  in
            object.isFavourite = !object.isFavourite //обратное значение
            self.objects[indexPath.row] = object // присаиваем по индекс пафу приходящему новое значение,как я понял по аналогии для тэйбл вью, тоесть без этого бы менялось в структуре из фэйворит , но на самом тэйбл вью бы это никак не обновлялось
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

