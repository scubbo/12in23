module BookingUpForBeauty

// The following line is needed to use the DateTime type
open System

let schedule (appointmentDateDescription: string): DateTime =
    DateTime.Parse(appointmentDateDescription)    

let hasPassed (appointmentDate: DateTime): bool =
    appointmentDate.CompareTo(DateTime.Now) < 0

let isAfternoonAppointment (appointmentDate: DateTime): bool =
    let hour = appointmentDate.Hour
    hour >= 12 && hour < 18

let description (appointmentDate: DateTime): string =
    sprintf "You have an appointment on %d/%d/%d %d:%02d:%02d %s." appointmentDate.Month appointmentDate.Day appointmentDate.Year (appointmentDate.Hour % 12) appointmentDate.Minute appointmentDate.Second (if appointmentDate.Hour < 12 then "AM" else "PM")

let anniversaryDate(): DateTime =
    DateTime(DateTime.Now.Year, 9, 15, 0, 0, 0)
