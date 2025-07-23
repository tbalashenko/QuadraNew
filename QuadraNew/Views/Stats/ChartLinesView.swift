//
//  ChartLinesView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 15/05/2024.
//

import SwiftUI
import SwiftData
import Charts

struct ChartLinesView: View {
    @ObservedObject var viewModel: StatViewModel
    @Binding var selectedPeriod: Period
    @Query var statData: [StatData]

    private var filteredStatData: [StatData] {
        statData.filter { $0.date >= selectedPeriod.fromDate }
            .sorted { $0.date < $1.date }
    }

    var body: some View {
        Chart {
            ForEach(filteredStatData) { data in
                totalNumberMarks(for: data)
                addedCardsMarks(for: data)
                repeatedCardsMarks(for: data)
                memorizedCardsMarks(for: data)
                deletedCardsMarks(for: data)
            }
        }
        .background(Color.element)
        .chartForegroundStyleScale([
            ChartLine.totalNumber.rawValue: ChartLine.totalNumber.color,
            ChartLine.added.rawValue: ChartLine.added.color,
            ChartLine.repeated.rawValue: ChartLine.repeated.color,
            ChartLine.memorized.rawValue: ChartLine.memorized.color,
            ChartLine.deleted.rawValue: ChartLine.deleted.color
        ])
        .chartXVisibleDomain(length: selectedPeriod.chartXVisibleDomainLength)
        .chartScrollableAxes(.horizontal)
        .chartLegend(position: .bottom)
        .chartYAxis { AxisMarks(position: .leading) }
        .chartXAxis {
            AxisMarks(values: selectedPeriod.axisMarksValues) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month().day(), centered: true)
            }
        }
    }
    
    @ChartContentBuilder
    private func totalNumberMarks(for data: StatData) -> some ChartContent {
        if viewModel.showTotalNumber {
            LineMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.totalNumber.rawValue, data.totalNumberOfCards),
                series: .value(ChartLine.totalNumber.rawValue, "A")
            )
            .foregroundStyle(ChartLine.totalNumber.color)
            .interpolationMethod(.monotone)
            
            AreaMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.totalNumber.rawValue, data.totalNumberOfCards),
                series: .value(ChartLine.totalNumber.rawValue, "A")
            )
            .foregroundStyle(ChartLine.totalNumber.gradient)
            .interpolationMethod(.monotone)
        }
    }
    
    @ChartContentBuilder
    private func addedCardsMarks(for data: StatData) -> some ChartContent {
        if viewModel.showAddedCards {
            LineMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.added.rawValue, data.addedItemsCounter),
                series: .value(ChartLine.added.rawValue, "B")
            )
            .foregroundStyle(ChartLine.added.color)
            .interpolationMethod(.monotone)
        }
    }
    
    @ChartContentBuilder
    private func repeatedCardsMarks(for data: StatData) -> some ChartContent {
        if viewModel.showRepeatedCards {
            LineMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.repeated.rawValue, data.repeatedItemsCounter),
                series: .value(ChartLine.repeated.rawValue, "C")
            )
            .foregroundStyle(ChartLine.repeated.color)
            .interpolationMethod(.monotone)
        }
    }
    
    @ChartContentBuilder
    private func memorizedCardsMarks(for data: StatData) -> some ChartContent {
        if viewModel.showMemorizedCards {
            LineMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.memorized.rawValue, data.memorizedItemsCounter),
                series: .value(ChartLine.memorized.rawValue, "D")
            )
            .foregroundStyle(ChartLine.memorized.color)
            .interpolationMethod(.monotone)
        }
    }
    
    @ChartContentBuilder
    private func deletedCardsMarks(for data: StatData) -> some ChartContent {
        if viewModel.showDeletedCards {
            LineMark(
                x: .value("Date", data.date, unit: .day),
                y: .value(ChartLine.deleted.rawValue, data.deletedItemsCounter),
                series: .value(ChartLine.deleted.rawValue, "E")
            )
            .lineStyle(StrokeStyle(dash: [5, 7]))
            .foregroundStyle(ChartLine.deleted.color)
            .interpolationMethod(.monotone)
        }
    }
}

#Preview {
    ChartLinesView(viewModel: StatViewModel(), selectedPeriod: .constant(Period.last2Weeks))
}
