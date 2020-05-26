//
//  NewWord+CoreDataProperties.swift
//  Training Words
//
//  Created by Nikita Sukachev on 26.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//
//

import Foundation
import CoreData

extension NewWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewWord> {
        return NSFetchRequest<NewWord>(entityName: "NewWord")
    }

    @NSManaged public var englishWord: String?
    @NSManaged public var russianWord: String?

}
