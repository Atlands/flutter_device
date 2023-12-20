//
//  Locale.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension Deeml {
    func getLocale() -> MELA {
        let locale = Locale.current
        
        if #available(iOS 16, *) {
            return MELA(
                country: locale.region?.identifier,
                displayCountry: locale.localizedString(forRegionCode: locale.region?.identifier ?? ""),
                displayLanguage: locale.localizedString(forLanguageCode: locale.language.languageCode?.identifier ?? ""),
                displayName: locale.localizedString(forIdentifier: locale.identifier),
                language: locale.language.minimalIdentifier,
                timeZone: locale.timeZone?.localizedName(for: .shortStandard, locale: locale),
                timeZoneId: locale.timeZone?.identifier
            )
        } else {
            let timeZone = NSTimeZone()
            return MELA(country: locale.regionCode, displayCountry: locale.localizedString(forRegionCode: locale.regionCode ?? ""), displayLanguage: locale.localizedString(forLanguageCode: locale.languageCode ?? ""), displayName: locale.localizedString(forIdentifier: locale.identifier), language: locale.languageCode, timeZone: timeZone.localizedName(.shortStandard, locale: locale), timeZoneId: timeZone.name)
        }
    }
}
