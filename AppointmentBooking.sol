// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AppointmentBooking {

    struct Appointment {
        address patient;
        address doctor;
        uint256 date;
        bool confirmed;
    }

    uint256 public appointmentCount;
    mapping(uint256 => Appointment) public appointments;

    event AppointmentBooked(uint256 id, address patient, address doctor);
    event AppointmentConfirmed(uint256 id);

    function bookAppointment(address _doctor, uint256 _date) public {
        appointmentCount++;
        appointments[appointmentCount] = Appointment(msg.sender, _doctor, _date, false);
        emit AppointmentBooked(appointmentCount, msg.sender, _doctor);
    }

    function confirmAppointment(uint256 _id) public {
        Appointment storage appt = appointments[_id];
        require(msg.sender == appt.doctor, "Only doctor can confirm");
        appt.confirmed = true;
        emit AppointmentConfirmed(_id);
    }
}
