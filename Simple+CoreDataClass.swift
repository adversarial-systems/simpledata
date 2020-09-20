//
//  Simple+CoreDataClass.swift
//  simpledata
//
//  Created by user on 9/20/20.
//
//  Created using the menu option "Editor-> Create NSManagedObject subclass" while focused on the simple.xcdatamodeld file
//  Also note there are options to use three distinct "Codegen" options when you focus cursor over any Entity in the model file
//
//  The option chosen in this case is Category/Extension. Take note that this choice requires deletion of the Simple+CoreDataProperties.swift file before builds
//  Get to know how the codegen options work, they are very useful but can create conflicts with using "Editor-> Create NSManagedObject subclass" because that process
//  creates both files without regard to the setting of "Codegen"
//  Codegen expects the correct number of files to be present, no less no more.
//  Option "Manual/None" requires both files to be accessible as it does not generate at build time
//  Option "Class Definition" requires neither file exists as it autogenerates them at build
//  Option "Category/Extension" requires ONLY the Class file as it autogenerates the Properties file at build
//
//  This last option can be very useful as it does not require correlating changes between the model Entity and the {Entityname}+CoreDataProperties.swift file
//  That said, any other choice REQUIRES keeping the properties file correlated with the model entity, failure to do so will result in hard to diagnose compile errors
//  With that in mind, it becomes obvious why the "Category/Extension" option may be preferred as it reduces the maintenance work when changing the model

import Foundation
import CoreData

@objc(Simple)
public class Simple: NSManagedObject {

}
