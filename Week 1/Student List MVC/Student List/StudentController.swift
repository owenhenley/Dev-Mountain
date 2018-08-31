//
//  StudentController.swift
//  Student List
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class StudentController {
    
    init() {
        self.students = [Student(firstName: "Owen", lastName: "Henley", age: 26),
                         Student(firstName: "Steve", lastName: "Jobs", age: 63),
                         Student(firstName: "Adam", lastName: "Henley", age: 24),
                         Student(firstName: "Charlotte", lastName: "Kenyon", age: 24)]
    }
    
    func create(studentWithFirstName firstName: String, lastName: String, age: Int) -> Student {
        let student = Student(firstName: "James", lastName: "Brown", age: 29)
        self.students.append(student)
        return student
    }
    
    func delete(student: Student) {
        if let index = self.students.index(where: { $0 == student}) {
            self.students.remove(at: index)
        }
    }
    var students: [Student]
    
}
