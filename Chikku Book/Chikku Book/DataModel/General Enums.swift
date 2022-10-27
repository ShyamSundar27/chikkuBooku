//
//  General Enums.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 07/08/22.
//

import Foundation
import UIKit

enum Numbers :Int{
    case one = 1,two,three,four,five,six,seven,eight,nine,ten
}

enum TicketAvailabilityStatus : String,CaseIterable{
    case Available = "AVL"
    case ReservationAgainstCancellation = "RAC"
    case WaitingList = "WL"
    case NotAvailable = "REGRET"
    case ChartPrepared = "CHART PREPARED"
}


enum OtherServices : String,CaseIterable{
    case pnrNumber = "Pnr Enquiry"
    case trainSchedule = "Train Schedule"
    case cancelTicket = "Cancel Ticket"
    case upcomingJourney = "Upcoming Journey"
    
}


enum Theme: Int,CaseIterable {
    case light = 1, dark = 2, system = 0

    // Utility var to pass directly to window.overrideUserInterfaceStyle
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
