import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/facility_booking_entity.dart';

class FacilityBookingsPage extends StatefulWidget {
  const FacilityBookingsPage({super.key});

  @override
  State<FacilityBookingsPage> createState() => _FacilityBookingsPageState();
}

class _FacilityBookingsPageState extends State<FacilityBookingsPage> {
  final List<FacilityEntity> _facilities = [
    const FacilityEntity(
      id: '1',
      name: 'Barangay Hall Main',
      type: FacilityType.barangayHall,
      description: 'Main barangay hall for official meetings and events',
      capacity: 100,
      location: 'Barangay Hall, Main Street',
      amenities: ['Air Conditioning', 'Sound System', 'Projector', 'Tables & Chairs'],
      hourlyRate: 500.0,
      isAvailable: true,
      operatingHours: {
        'monday': '8:00 AM - 5:00 PM',
        'tuesday': '8:00 AM - 5:00 PM',
        'wednesday': '8:00 AM - 5:00 PM',
        'thursday': '8:00 AM - 5:00 PM',
        'friday': '8:00 AM - 5:00 PM',
        'saturday': '8:00 AM - 12:00 PM',
        'sunday': 'Closed',
      },
      contactPerson: 'Maria Santos',
      contactPhone: '+63 912 345 6789',
      contactEmail: 'barangay.hall@lgu.gov.ph',
      bookingAdvanceDays: 7,
    ),
    const FacilityEntity(
      id: '2',
      name: 'Community Gymnasium',
      type: FacilityType.gymnasium,
      description: 'Multi-purpose gymnasium for sports and events',
      capacity: 200,
      location: 'Community Center, Sports Complex',
      amenities: ['Basketball Court', 'Volleyball Court', 'Sound System', 'Lighting'],
      hourlyRate: 800.0,
      isAvailable: true,
      operatingHours: {
        'monday': '6:00 AM - 10:00 PM',
        'tuesday': '6:00 AM - 10:00 PM',
        'wednesday': '6:00 AM - 10:00 PM',
        'thursday': '6:00 AM - 10:00 PM',
        'friday': '6:00 AM - 10:00 PM',
        'saturday': '6:00 AM - 10:00 PM',
        'sunday': '8:00 AM - 8:00 PM',
      },
      contactPerson: 'Juan Dela Cruz',
      contactPhone: '+63 912 345 6790',
      contactEmail: 'gym@lgu.gov.ph',
      bookingAdvanceDays: 14,
    ),
    const FacilityEntity(
      id: '3',
      name: 'Function Room A',
      type: FacilityType.functionRoom,
      description: 'Small function room for meetings and small events',
      capacity: 50,
      location: 'Barangay Hall, 2nd Floor',
      amenities: ['Air Conditioning', 'Projector', 'Whiteboard', 'Tables & Chairs'],
      hourlyRate: 300.0,
      isAvailable: true,
      operatingHours: {
        'monday': '8:00 AM - 5:00 PM',
        'tuesday': '8:00 AM - 5:00 PM',
        'wednesday': '8:00 AM - 5:00 PM',
        'thursday': '8:00 AM - 5:00 PM',
        'friday': '8:00 AM - 5:00 PM',
        'saturday': '8:00 AM - 12:00 PM',
        'sunday': 'Closed',
      },
      contactPerson: 'Ana Rodriguez',
      contactPhone: '+63 912 345 6791',
      contactEmail: 'function.room@lgu.gov.ph',
      bookingAdvanceDays: 3,
    ),
  ];

  final List<FacilityBookingEntity> _myBookings = [
    FacilityBookingEntity(
      id: '1',
      facilityId: '1',
      facilityName: 'Barangay Hall Main',
      facilityType: FacilityType.barangayHall,
      userId: 'user_001',
      userName: 'John Doe',
      userEmail: 'john.doe@email.com',
      userPhone: '+63 912 345 6789',
      bookingDate: DateTime.now().add(const Duration(days: 7)),
      startTime: DateTime.now().add(const Duration(days: 7, hours: 9)),
      endTime: DateTime.now().add(const Duration(days: 7, hours: 12)),
      purpose: 'Community Meeting',
      expectedAttendees: 50,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      confirmedAt: DateTime.now().subtract(const Duration(days: 1)),
      totalCost: 1500.0,
      paymentStatus: 'Paid',
      bookingReference: 'BK-2024-001',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facility Bookings'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Book LGU Facilities',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Reserve barangay halls, gyms, courts, and function rooms for your events',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // My Bookings Section
            if (_myBookings.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Bookings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all bookings
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._myBookings.map((booking) => _buildBookingCard(booking)),
              const SizedBox(height: 24),
            ],
            
            // Available Facilities
            Text(
              'Available Facilities',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Facilities Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _facilities.length,
              itemBuilder: (context, index) {
                final facility = _facilities[index];
                return _buildFacilityCard(facility);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(FacilityBookingEntity booking) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ShadCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getFacilityIcon(booking.facilityType),
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.facilityName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    booking.status.name.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(booking.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                '${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                '${booking.startTime.hour.toString().padLeft(2, '0')}:${booking.startTime.minute.toString().padLeft(2, '0')} - ${booking.endTime.hour.toString().padLeft(2, '0')}:${booking.endTime.minute.toString().padLeft(2, '0')}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                '${booking.expectedAttendees} attendees',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          if (booking.bookingReference != null) ...[
            const SizedBox(height: 8),
            Text(
              'Reference: ${booking.bookingReference}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityCard(FacilityEntity facility) {
    final theme = Theme.of(context);
    
    return ShadCard(
      child: InkWell(
        onTap: () {
          // Navigate to facility details and booking
          _showFacilityDetails(facility);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Facility Icon
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getFacilityIcon(facility.type),
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Facility Name
            Text(
              facility.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 4),
            
            // Capacity
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  '${facility.capacity} capacity',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            // Hourly Rate
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  '₱${facility.hourlyRate.toStringAsFixed(0)}/hour',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            
            const Spacer(),
            
            // Book Button
            SizedBox(
              width: double.infinity,
              child: ShadButton(
                text: 'Book Now',
                variant: ShadButtonVariant.outline,
                size: ShadButtonSize.sm,
                onPressed: () {
                  _showFacilityDetails(facility);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFacilityIcon(FacilityType type) {
    switch (type) {
      case FacilityType.barangayHall:
        return Icons.account_balance;
      case FacilityType.gymnasium:
        return Icons.sports_gymnastics;
      case FacilityType.basketballCourt:
        return Icons.sports_basketball;
      case FacilityType.functionRoom:
        return Icons.meeting_room;
      case FacilityType.meetingRoom:
        return Icons.business;
      case FacilityType.playground:
        return Icons.park;
      case FacilityType.multipurposeHall:
        return Icons.event;
      case FacilityType.auditorium:
        return Icons.theater_comedy;
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
      case BookingStatus.completed:
        return Colors.blue;
      case BookingStatus.rejected:
        return Colors.red;
    }
  }

  void _showFacilityDetails(FacilityEntity facility) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Facility Header
              Row(
                children: [
                  Icon(
                    _getFacilityIcon(facility.type),
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          facility.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          facility.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Details
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Location', facility.location),
                      _buildDetailRow('Capacity', '${facility.capacity} people'),
                      _buildDetailRow('Hourly Rate', '₱${facility.hourlyRate.toStringAsFixed(0)}'),
                      _buildDetailRow('Contact', facility.contactPhone ?? 'N/A'),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'Amenities',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: facility.amenities.map((amenity) => Chip(
                          label: Text(amenity),
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        )).toList(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Book Button
                      SizedBox(
                        width: double.infinity,
                        child: ShadButton(
                          text: 'Book This Facility',
                          onPressed: () {
                            Navigator.pop(context);
                            _showBookingForm(facility);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingForm(FacilityEntity facility) {
    // This would show a booking form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking form for ${facility.name} would open here'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
