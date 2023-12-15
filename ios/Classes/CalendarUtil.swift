////
////  CalendarUtil.swift
////  flutter_device
////
////  Created by atlands on 2023/8/3.
////
//
//import Foundation
//import EventKit
//
//class CalendarUtil {
//    let eventStore = EKEventStore()
//    private var calendars = [Calendar]()
//    private var onResult: ((Result<[Calendar]>) -> Void)? = nil
//    
//    func getContacts(onResult: @escaping ((Result<[Calendar]>) -> Void)){
//        self.onResult = onResult
//        
//        let status = EKEventStore.authorizationStatus(for: .event)
//        if(status == .authorized){
//            self.res()
//        }else{
//            EKEventStore().requestAccess(to: .event){ status,_ in
//                if status {
//                    self.res()
//                } else {
//                    self.onResult?(Result(code: ResultError.calendarPermission, message: "calendar permission denied", data: []))
//                    self.onResult = nil
//                }
//            }
//        }
//    }
//    
//    private func res() {
//        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: allCalendars()))
//        self.onResult = nil
//    }
//    
//    private func allCalendars() -> [Calendar] {
//        if !calendars.isEmpty {
//            return calendars
//        }
//        
//        let eventStore = EKEventStore()
////        let calendars = eventStore.calendars(for: .event)
//        
//        // 获取所有的事件（前后90天）
//        let startDate = Date(timeIntervalSinceNow: -3600*24*90)
//        let endDate = Date(timeIntervalSinceNow: 3600*24*90)
//        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
//        let events = eventStore.events(matching: predicate)
//
//        for event in events {
//            if !event.calendar.allowsContentModifications {
//                continue
//            }
//            
//            let schedule = Calendar(
//                id: event.eventIdentifier,
//                eventTitle: event.title,
//                description: event.notes ?? "",
//                startTime: dateFormat.string(from: event.startDate),
//                endTime: dateFormat.string(from: event.endDate),
//                createdAt: dateFormat.string(from: event.creationDate ?? Date())
//            )
//            self.calendars.append(schedule)
//        }
//        return self.calendars
//    }
//}
