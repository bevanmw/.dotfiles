//
//  main.swift
//  Reminders
//
//  Created by Bevan Wentzel on 2024/08/24.
//

import Foundation
import EventKit
import SwiftDate
import ArgumentParser

enum RemindersError: Error {
  case accessDenied
  case noRemindersFound
  case noReminderFound
  case unableToSaveReminder
  case other
  case invalidInput
}

enum ListType: String {
    case today = "today"
    case overdue = "overdue"
    case upcoming = "upcoming"
    case single = "single"
    case all = "all"
}

struct CodableReminder: Codable {
    var title: String
    var date: Date
    var formated: String
}

struct CodableReminders: Codable {
    var overdue: [CodableReminder]
    var today: [CodableReminder]
    var upcoming: [CodableReminder]
    var all: [CodableReminder]
}

@available(iOS 17.0, *)
@main
struct Reminders: AsyncParsableCommand {
    public func run() async throws {
        SwiftDate.defaultRegion = .local
        
        let eventStore = EKEventStore()
        let granted: Bool
        if #available(macOS 14.0, *) {
            granted = try await eventStore.requestFullAccessToReminders()
            
        } else {
            granted = try await eventStore.requestAccess(to: .reminder)
        }
        guard granted else {
            throw RemindersError.accessDenied
        }
        
        let predicate = eventStore.predicateForIncompleteReminders(
            withDueDateStarting: nil,
            ending: nil,
            calendars: nil
          )
        let reminders = try await withCheckedThrowingContinuation{ continuation in
            eventStore.fetchReminders(matching: predicate) { (reminders) in
                if let reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: RemindersError.noReminderFound)
                }
            }
        }
        
        let dueReminders: [EKReminder] = reminders.filter { $0.dueDateComponents != nil }
            .sorted {
            guard let date0 = $0.dueDateComponents?.date else { return false }
            guard let date1 = $1.dueDateComponents?.date else { return false }
            return date0.compare(.isEarlier(than: date1))
        }
        
        let overdueReminders: [EKReminder] = dueReminders.filter{
            guard let reminderDate = $0.dueDateComponents?.date else { return false }
            return Date().isAfterDate(reminderDate, orEqual: false, granularity: .minute) && !reminderDate.inDefaultRegion().compare(.isToday)
        }
        
        let todayReminders = dueReminders.filter {
            guard let reminderDate = $0.dueDateComponents?.date else { return false }
            return reminderDate.inDefaultRegion().compare(.isToday)
        }
        
        let upcomingReminders = dueReminders.filter {
            guard let reminderDate = $0.dueDateComponents?.date else { return false }
            return Date().isBeforeDate(reminderDate, orEqual: false, granularity: .minute) && !(reminderDate.compare(.isToday))
        }
        
        
       let codable = try CodableReminders(overdue: makeReminderListCodable(reminders: overdueReminders), today: makeReminderListCodable(reminders: todayReminders), upcoming: makeReminderListCodable(reminders: upcomingReminders), all: makeReminderListCodable(reminders: dueReminders))
        
        let encoded = try JSONEncoder().encode(codable)
    
        print(String(data: encoded, encoding: .utf8)!)
    }
    
    func makeReminderListCodable(reminders: [EKReminder]) throws -> [CodableReminder] {
        try reminders.map { reminder in
            guard let reminderDate = reminder.dueDateComponents?.date else { throw RemindersError.other }
            return CodableReminder(title: reminder.title, date: reminderDate, formated: formatReminder(reminder: reminder))
        }
    }
    
    func formatReminder(reminder: EKReminder) -> String {
        guard let reminderTitle = reminder.title else { return "" }
        guard let reminderDate = reminder.dueDateComponents?.date else { return reminder.title }
        
        // If at exactly the start of today. We assume it's just "today" and don't show a time.
        if (reminderDate.compare(toDate: Date().dateAtStartOf(.day), granularity: .minute) == .orderedSame) {
            return reminderTitle
        }
        return reminderTitle + " (" + reminderDate.toRelative(style: RelativeFormatter.twitterStyle()) + ")"
    }
}

