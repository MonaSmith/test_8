//
//  Person.swift
//  TableView&TableField
//
//  Created by student on 2018/11/10.
//  Copyright © 2018年 yx. All rights reserved.
//

import Foundation
//性别的枚举
enum Gender: Int {
    case male    //男性
    case female  //女性
    case unknow  //未知
    
    //重载>操作符，方便后面排序使用
    static func >(lhs: Gender, rhs: Gender) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

//公寓的枚举
enum Department {
    case one, two, three
}

//学校协议
protocol SchoolProtocol {
    var department: Department { get set }
    func lendBook()
}

//人类
class Person: CustomStringConvertible  {
    var firstName: String  //姓
    var lastName: String  //名
    var age: Int  //年龄
    var gender: Gender  //性别
    
    var fullName: String {  //全名
        get {
            return firstName + lastName
        }
    }
    
    //构造方法
    init(firstName: String, lastName: String, age: Int, gender: Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    
    convenience init(firstName: String, age: Int, gender: Gender) {
        self.init(firstName: firstName, lastName: "", age: age, gender: gender)
    }
    
    convenience init(firstName: String) {
        self.init(firstName: firstName, age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(firstName: "")
    }
    
    //重载==
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.fullName == rhs.fullName && lhs.age == rhs.age && lhs.gender == rhs.gender
    }
    
    //重载!=
    static func !=(lhs: Person, rhs: Person) -> Bool {
        return !(lhs == rhs)
    }
    
    //实现CustomStringConvertible协议中的计算属性，可以使用print直接输出对象内容
    var description: String {
        return "fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
    
    //输出Person XXX is running
    func run() {
        print("Person \(self.fullName) is running")
    }
}

//教师类
class Teacher: Person, SchoolProtocol {
    var title: String  //标题
    var department: Department  //公寓
    
    //构造方法
    init(title: String, firstName: String, lastName: String, age: Int, gender: Gender, department: Department) {
        self.title = title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    init(title: String, department: Department) {
        self.title = title
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    
    convenience required init() {
        self.init(title: "", department: Department.one)
    }
    
    //重写父类的计算属性
    override var description: String {
        return "title: \(self.title), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), department: \(self.department)"
    }
    
    //重载父类run方法
    override func run() {
        print("Teacher \(self.fullName) is running")
    }
    
    //遵循协议的方法
    func lendBook() {
        print("Teacher \(self.fullName) lend a book")
    }
}

//学生类
class Student: Person, SchoolProtocol {
    var stuNo: Int  //学号
    var department: Department  //公寓
    
    //构造方法
    init(stuNo: Int, firstName: String, lastName: String, age: Int, gender: Gender, department: Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    convenience init(stuNo: Int, firstName: String, lastName: String, age: Int, gender: Gender) {
        self.init(stuNo: stuNo, firstName: firstName, lastName: lastName, age: age, gender: gender, department: .one)
    }
    
    init(stuNo: Int, department: Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(stuNo: 0, department: .one)
    }
    
    //重写父类的计算属性
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), department: \(self.department)"
    }
    
    //重载父类run方法
    override func run() {
        print("Student \(self.fullName) is running")
    }
    
    //遵循协议的方法
    func lendBook() {
        print("Teacher \(self.fullName) lend a book")
    }
}
