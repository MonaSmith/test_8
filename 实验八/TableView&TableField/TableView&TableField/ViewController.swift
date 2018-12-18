//
//  ViewController.swift
//  TableView&TableField
//
//  Created by student on 2018/11/10.
//  Copyright © 2018年 yx. All rights reserved.
//

import UIKit
//控制器既是代理也是数据源
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var nameTextField: UITextField!
    //tableView的属性用于重新装载数据
    @IBOutlet weak var tableView: UITableView!
    //学生数组
    var students = [Student]()
    //教师数组
    var teachers = [Teacher]()
    //定义表头数组
    var tableTitle = ["TeacherCell","StudentCell"]
    //返回总共有几个部分，section的值,程序中包含student和teacher两部分
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count
    }
    //
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]
    }
    //几行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //有两种不同的数据信息需要展示，所以有两个section（部分），section为行数
        if section == 0 {
            return teachers.count
        } else {
            return students.count
        }
    }
    //指定表视图中的单元格的方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableTitle[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! PersonTableViewCell
        switch identifier {
        case "TeacherCell":
            let tea = teachers[indexPath.row]
            cell.title.text = tea.title
            cell.name.text = tea.fullName
            cell.age.text = "\(tea.age)"
            cell.gender.text = "\(tea.gender)"
            cell.department.text = "\(tea.department)"
            cell.picture.image = UIImage(named: "ge")
            print("Teacher\(String(describing: cell.name.text))Finshed")
            break
        case "StudentCell":
            let stu = students[indexPath.row]
            cell.number.text = "\(stu.stuNo)"
            cell.name.text = stu.fullName
            cell.age.text = "\(stu.age)"
            cell.gender.text = "\(stu.gender)"
            cell.department.text = "\(stu.department)"
            cell.picture.image = UIImage(named: "hu")
            print("Student\(String(describing: cell.name.text))Finshed")
            break
        default:
            break
        }
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //生成四个student对象
        students.append(Student(stuNo: 12, firstName: "Young", lastName: "Lay", age: 14, gender: .female, department: .one))
        students.append(Student(stuNo: 13, firstName: "Blue", lastName: "Lew", age: 13, gender: .male, department: .one))
        students.append(Student(stuNo: 14, firstName: "Orange", lastName: "Red", age: 14, gender: .female, department: .two))
        students.append(Student(stuNo: 15, firstName: "Kaycee", lastName: "Rice", age: 14, gender: .unknow, department: .three))
        //生成四个teacher对象
        teachers.append(Teacher(title: "Chinese", firstName: "Justin", lastName: "La", age: 22, gender: .male, department: .one))
        teachers.append(Teacher(title: "Math", firstName: "Mark", lastName: "Lee", age: 32, gender: .male, department: .two))
        teachers.append(Teacher(title: "Computer", firstName: "Sean", lastName: "Jung", age: 40, gender: .female, department: .three))
        teachers.append(Teacher(title: "Chinese", firstName: "Tae", lastName: "Kim", age: 25, gender: .unknow, department: .one))
    }
    //指定cell的高度大小
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    //添加学生提示框，UIButton？or Any？
    @IBAction func btnAddStudents(_ sender: UIButton) {
        let alertController = UIAlertController(title: "增加新的学生信息", message: "请输入以下信息", preferredStyle: .alert)
        
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的学号"
        }
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的姓"
        }
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的名"
        }
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的年龄"
        }
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的性别（male或female）"
        }
        alertController.addTextField {
            (textField: UITextField!) in
            textField.placeholder = "学生的公寓(填写阿拉伯数字1/2/3)"
        }
        
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            let no = Int(alertController.textFields![0].text!)
            let firstName = alertController.textFields![1].text!
            let lastName = alertController.textFields![2].text!
            let age = Int(alertController.textFields![3].text!)
            //?
            let gender: Gender
            switch alertController.textFields![4].text! {
            case "male":
                gender = .male
            case "female":
                gender = .female
            default:
                gender = .unknow
            }
            //?
//            let department: Department
//            switch alertController.textFields![5].text! {
//            case "1":
//                department = .one
//            case "2":
//                department = .two
//            case "3":
//                department = .three
//            default:
//                break
//            }
            let student = Student(stuNo: no!, firstName: firstName, lastName: lastName, age: age!, gender: gender)
            self.students.append(student)
            //重新装载tableView的数据，所以需要再ViewController中增加一个tableView的属性
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: " 取消", style: .cancel, handler: nil)
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //编辑button
    @IBAction func editClcked(_ sender: Any) {
        //tableView可以被编辑
        tableView.isEditing = !tableView.isEditing
    }
    //删除cell
    //首先直接使用单粒设置每一个单元格的编辑类型都是删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                teachers.remove(at: indexPath.row)
            } else {
                students.remove(at: indexPath.row)
            }
            //删除某一行，或者几行（是一个数组），with：（是一个动画效果）
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //更改划出之后显示的文字
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

