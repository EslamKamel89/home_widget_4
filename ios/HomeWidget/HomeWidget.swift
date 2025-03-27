import WidgetKit
import SwiftUI

// MARK: - Prayer Model and JSON Parsing

struct Prayer: Decodable, Identifiable {
    // Conform to Identifiable to use ForEach directly.
    var id = UUID()
    let prayerName: String
    let prayerTime: String
    let prayerImg: String
}

func parsePrayers(from jsonString: String) -> [Prayer]? {
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    do {
        let prayers = try JSONDecoder().decode([Prayer].self, from: jsonData)
        return prayers
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}

// MARK: - Data Provider

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        // Provide a simple placeholder JSON string
        let placeholderJSON = """
        [{"prayerName":"Fajr","prayerTime":"05:33\\nAM","prayerImg":"fajr"},
         {"prayerName":"Sunrise","prayerTime":"07:02\\nAM","prayerImg":"three"},
         {"prayerName":"Dhuhr","prayerTime":"01:15\\nPM","prayerImg":"two"},
         {"prayerName":"Asr","prayerTime":"04:45\\nPM","prayerImg":"one"},
         {"prayerName":"Maghrib","prayerTime":"07:28\\nPM","prayerImg":"four"},
         {"prayerName":"Isha","prayerTime":"08:52\\nPM","prayerImg":"five"}]
        """
        return SimpleEntry(date: Date(), data: placeholderJSON)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.gaztec4widget")
        let data = userDefaults?.string(forKey: "data") ?? ""
        let entry = SimpleEntry(date: Date(), data: data)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: String  // JSON encoded string holding prayer data
}

// MARK: - Reusable PrayerView

struct PrayerView: View {
    let prayer: Prayer
    let imageSize: CGSize
    
    var body: some View {
        VStack(spacing: 5) {
            Text(prayer.prayerName)
                .font(.system(size: imageSize.height * 0.3, weight: .semibold))
                .foregroundColor(.black)
            
            Image(prayer.prayerImg)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
                .clipped()
                .cornerRadius(8)
            
            Text(prayer.prayerTime)
                .font(.system(size: imageSize.height * 0.25))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

// MARK: - Main Widget View

struct HomeWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    // Decode the JSON string from entry.data into an array of Prayer objects.
    // If decoding fails, use a fallback default array.
    var prayers: [Prayer] {
        parsePrayers(from: entry.data) ?? [
            Prayer(prayerName: "Fajr", prayerTime: "05:33\nAM", prayerImg: "fajr"),
            Prayer(prayerName: "Sunrise", prayerTime: "07:02\nAM", prayerImg: "three"),
            Prayer(prayerName: "Dhuhr", prayerTime: "01:15\nPM", prayerImg: "two"),
            Prayer(prayerName: "Asr", prayerTime: "04:45\nPM", prayerImg: "one"),
            Prayer(prayerName: "Maghrib", prayerTime: "07:28\nPM", prayerImg: "four"),
            Prayer(prayerName: "Isha", prayerTime: "08:52\nPM", prayerImg: "five")
        ]
    }
    
    var body: some View {
        ZStack {
            // Background with a generic subtle gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.05), Color.green.opacity(0.05)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Layout based on widget family
            switch family {
            case .systemSmall, .systemMedium:
                // For small and medium sizes, wrap the HStack in a ScrollView for pagination.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(prayers) { prayer in
                            PrayerView(
                                prayer: prayer,
                                imageSize: family == .systemSmall ?
                                    CGSize(width: 40, height: 50) : CGSize(width: 50, height: 60)
                            )
                        }
                    }
                    .padding()
                }
            case .systemLarge:
                // For large size, display all prayers in a grid layout.
                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(prayers) { prayer in
                        PrayerView(
                            prayer: prayer,
                            imageSize: CGSize(width: 50, height: 45)
                        )
                    }
                }
                .padding()
            default:
                // Fallback: a horizontal scroll view.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(prayers) { prayer in
                            PrayerView(
                                prayer: prayer,
                                imageSize: CGSize(width: 40, height: 40)
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// MARK: - Widget Declaration

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Prayer Times")
        .description("Displays Islamic prayer times with a modern, responsive design.")
    }
}
