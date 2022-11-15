//
//  Drops.swift
//  iceberg-dash
//
//  Created by yury mid on 13.11.2022.
//

import SwiftUI
import Drops

let qrStringIsEmptyDrop = Drop(
    title: LocalizedStringKey("Incorrect data").stringKey ?? "Error",
    icon: UIImage(systemName: "rectangle.and.pencil.and.ellipsis.rtl"),
    action: .init {
        Drops.hideCurrent()
    },
    position: .top,
    duration: 3.0,
    accessibility: "Alert: Title, Subtitle"
    )

let qrReadingErrorDrop = Drop(
    title: LocalizedStringKey("QR is not defined").stringKey ?? "Error",
    icon: UIImage(systemName: "exclamationmark.triangle.fill"),
    action: .init {
        Drops.hideCurrent()
    },
    position: .top,
    duration: 3.0,
    accessibility: "Alert: Title, Subtitle"
    )

let qrReadingSuccessDrop = Drop(
    title: LocalizedStringKey("QR reached").stringKey ?? "Success",
    icon: UIImage(systemName: "qrcode.viewfinder"),
    action: .init {
        Drops.hideCurrent()
    },
    position: .top,
    duration: 3.0,
    accessibility: "Alert: Title, Subtitle"
    )

let qrCreatingSuccessDrop = Drop(
    title: LocalizedStringKey("QR created").stringKey ?? "Success",
    icon: UIImage(systemName: "qrcode.viewfinder"),
    action: .init {
        Drops.hideCurrent()
    },
    position: .top,
    duration: 3.0,
    accessibility: "Alert: Title, Subtitle"
    )
