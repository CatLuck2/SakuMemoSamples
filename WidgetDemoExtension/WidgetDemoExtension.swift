//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Nekokichi on 2022/01/09.
//

import WidgetKit
import SwiftUI
import Intents


// --------------- 設定に関わる部分 ----------------

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CoffeeEntry {
        CoffeeEntry(date: Date(), beansType: "espresso")
    }

    func getSnapshot(in context: Context, completion: @escaping (CoffeeEntry) -> ()) {
        let entry = CoffeeEntry(date: Date(), beansType: "espresso")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [CoffeeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = CoffeeEntry(date: entryDate, beansType: "espresso")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//struct Provider: IntentTimelineProvider {
//    typealias Entry = CoffeeEntry
//
//    typealias Intent = WidgetIntentIntent
//
//    func placeholder(in context: Context) -> CoffeeEntry {
//        CoffeeEntry(date: Date(), beansType: "コーヒー豆")
//    }
//
//    func getSnapshot(for configuration: WidgetIntentIntent, in context: Context, completion: @escaping (CoffeeEntry) -> Void) {
//        let entry = CoffeeEntry(date: Date(), beansType: "コーヒー豆")
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: WidgetIntentIntent, in context: Context, completion: @escaping (Timeline<CoffeeEntry>) -> Void) {
//        var entries: [CoffeeEntry] = []
//
//        entries.append(CoffeeEntry(date: Date(), beansType: "BlueMountain"))
//        entries.append(CoffeeEntry(date: Date(), beansType: "BlueMountain"))
//        entries.append(CoffeeEntry(date: Date(), beansType: "Mocha"))
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}

struct CoffeeEntry: TimelineEntry {
    var date: Date
    var beansType: String
}

// ウィジェットのView階層
struct CoffeeEntryView : View {
    var coffeeData: CoffeeEntry
    
    var body: some View {
        ZStack {
            Color(UIColor.orange)
            VStack(alignment: .leading) {
                CoffeeView(coffeeData: coffeeData)
                Spacer()
                CaptionView(coffeeData: coffeeData)
            }
            .padding(.all)
        }
    }
}

// Placeholder用のView
struct CoffeePlaceholderView : View {
    var coffeeData: CoffeeEntry

    var body: some View {
        ZStack {
            Color(UIColor.orange)
            VStack(alignment: .leading) {
                CoffeeView(coffeeData: coffeeData)
                Spacer()
                CaptionView(coffeeData: coffeeData)
            }
            .padding(.all)
        }
        .redacted(reason: .placeholder)
    }
}

struct CoffeeView: View {
    let coffeeData: CoffeeEntry
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(coffeeData.beansType)")
                    .font(.body)
                    .foregroundColor(Color(UIColor.brown))
                    .bold()
                Spacer()
                Text("\(coffeeData.beansType)")
                    .font(.title2)
                    .foregroundColor(Color(UIColor.brown))
                    .bold()
            }
        }
        .padding(.all, 10.0)
        .background(Color(UIColor.systemOrange))
        .cornerRadius(20)
    }
}

struct CaptionView: View {
    let coffeeData: CoffeeEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        VStack(alignment: .leading) {
            switch family {
            case .systemSmall:
                Text("provided by Neko")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.white))
                    .bold()
            default:
                Text("provided by Nekokichi")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.white))
                    .bold()
            }
            Text(coffeeData.date, style:.time)
                .font(.caption)
                .foregroundColor(Color(UIColor.white))
                .bold()
        }
    }
}

@main
struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { coffeeData in
            CoffeeEntryView(coffeeData: coffeeData)
        }
//        IntentConfiguration(kind: kind, intent: WidgetIntentIntent.self, provider: Provider(), content: { coffeeData in
//            CoffeeEntryView(coffeeData: CoffeeData.previewData)
//        })
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// --------------- 実装に関わる部分 ----------------

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoffeeEntryView(coffeeData: CoffeeEntry(date: Date(), beansType: "Espresso"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
//            CoffeeEntryView(coffeeData: .previewData)
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            CoffeePlaceholderView(coffeeData: .previewData)
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}

//// データ
//struct CoffeeData {
//    let beansName: String
//    let amountOfCaffeine: String
//    let photoName: String
//    let date: Date
//}
//
//// インスタンス
//extension CoffeeData {
//    static let previewData = CoffeeData (
//        beansName: "Espresso",
//        amountOfCaffeine: "25.62mg",
//        photoName: "EspressoImage",
//        date: Date()
//    )
//}
