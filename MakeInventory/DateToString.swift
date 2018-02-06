//
//  DateToString.swift
//  MakeInventory
//
//  Created by Kaichi Momose on 2018/02/06.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

extension Date {
    func convertString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}
