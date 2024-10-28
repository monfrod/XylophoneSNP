//
//  RecordingData+CoreDataProperties.swift
//  XylophoneSNP
//
//  Created by yunus on 28.10.2024.
//
//

import Foundation
import CoreData


extension RecordingData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordingData> {
        return NSFetchRequest<RecordingData>(entityName: "RecordingData")
    }

    @NSManaged public var recording: NSObject?

}

extension RecordingData : Identifiable {

}
