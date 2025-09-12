import 'package:flutter_test/flutter_test.dart';
import 'package:e_lgu_mob/features/phase3/facility_bookings/domain/entities/facility_booking_entity.dart';
import 'package:e_lgu_mob/features/phase3/events_calendar/domain/entities/event_entity.dart';
import 'package:e_lgu_mob/features/phase3/pet_registration/domain/entities/pet_entity.dart';
import 'package:e_lgu_mob/features/phase3/waste_schedule/domain/entities/waste_schedule_entity.dart';
import 'package:e_lgu_mob/features/phase3/hazard_reporting/domain/entities/hazard_report_entity.dart';
import 'package:e_lgu_mob/features/phase3/transparency_dashboards/domain/entities/transparency_entity.dart';
import 'package:e_lgu_mob/features/phase3/open_data_portal/domain/entities/open_data_entity.dart';

void main() {
  group('Phase 3 Domain Entities Tests', () {
    group('Facility Booking Entity', () {
      test('should create facility booking entity with all properties', () {
        final booking = FacilityBookingEntity(
          id: '1',
          facilityId: 'facility_1',
          facilityName: 'Barangay Hall',
          facilityType: FacilityType.barangayHall,
          userId: 'user_1',
          userName: 'John Doe',
          userEmail: 'john@email.com',
          userPhone: '+63 912 345 6789',
          bookingDate: DateTime(2024, 1, 15),
          startTime: DateTime(2024, 1, 15, 9, 0),
          endTime: DateTime(2024, 1, 15, 12, 0),
          purpose: 'Community Meeting',
          expectedAttendees: 50,
          status: BookingStatus.confirmed,
          createdAt: DateTime(2024, 1, 10),
          totalCost: 1500.0,
          paymentStatus: 'Paid',
          bookingReference: 'BK-2024-001',
        );

        expect(booking.id, '1');
        expect(booking.facilityName, 'Barangay Hall');
        expect(booking.facilityType, FacilityType.barangayHall);
        expect(booking.durationHours, 3.0);
        expect(booking.isActive, false); // Future booking
        expect(booking.isUpcoming, true);
      });

      test('should calculate duration correctly', () {
        final booking = FacilityBookingEntity(
          id: '1',
          facilityId: 'facility_1',
          facilityName: 'Test Facility',
          facilityType: FacilityType.gymnasium,
          userId: 'user_1',
          userName: 'John Doe',
          userEmail: 'john@email.com',
          userPhone: '+63 912 345 6789',
          bookingDate: DateTime.now(),
          startTime: DateTime.now().add(const Duration(hours: 1)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
          purpose: 'Test',
          expectedAttendees: 10,
          status: BookingStatus.pending,
          createdAt: DateTime.now(),
        );

        expect(booking.durationHours, 3.0);
      });
    });

    group('Event Entity', () {
      test('should create event entity with all properties', () {
        final event = EventEntity(
          id: '1',
          title: 'Community Clean-up',
          description: 'Monthly community clean-up drive',
          type: EventType.community,
          status: EventStatus.published,
          organizerId: 'org_1',
          organizerName: 'Green Community Group',
          organizerType: 'citizen',
          startDate: DateTime(2024, 1, 20, 8, 0),
          endDate: DateTime(2024, 1, 20, 12, 0),
          location: 'Main Street',
          isPublic: true,
          maxAttendees: 100,
          registrationRequired: true,
          createdAt: DateTime(2024, 1, 15),
          registrationDeadline: DateTime(2024, 1, 18),
          tags: ['environment', 'community'],
        );

        expect(event.id, '1');
        expect(event.title, 'Community Clean-up');
        expect(event.type, EventType.community);
        expect(event.durationHours, 4.0);
        expect(event.isUpcoming, true);
        expect(event.isLguOfficial, false);
        expect(event.isRegistrationOpen, true);
      });

      test('should check registration status correctly', () {
        final event = EventEntity(
          id: '1',
          title: 'Test Event',
          description: 'Test',
          type: EventType.lguOfficial,
          status: EventStatus.published,
          organizerId: 'org_1',
          organizerName: 'LGU',
          organizerType: 'lgu',
          startDate: DateTime.now().add(const Duration(days: 5)),
          endDate: DateTime.now().add(const Duration(days: 5, hours: 2)),
          location: 'Test Location',
          isPublic: true,
          maxAttendees: 50,
          registrationRequired: true,
          createdAt: DateTime.now(),
          registrationDeadline: DateTime.now().add(const Duration(days: 2)),
        );

        expect(event.isRegistrationOpen, true);
        expect(event.isLguOfficial, true);
      });
    });

    group('Pet Entity', () {
      test('should create pet entity with all properties', () {
        final pet = PetEntity(
          id: '1',
          ownerId: 'user_1',
          ownerName: 'John Doe',
          ownerEmail: 'john@email.com',
          ownerPhone: '+63 912 345 6789',
          ownerAddress: '123 Main Street',
          name: 'Buddy',
          type: PetType.dog,
          breed: 'Golden Retriever',
          gender: PetGender.male,
          size: PetSize.large,
          birthDate: DateTime(2020, 3, 15),
          color: 'Golden',
          microchipId: 'MC-123456789',
          registrationNumber: 'PET-2024-001',
          registrationDate: DateTime(2024, 1, 15),
          expiryDate: DateTime(2025, 1, 15),
          status: PetRegistrationStatus.approved,
          createdAt: DateTime(2024, 1, 10),
          vaccinationRecords: [
            VaccinationRecordEntity(
              id: '1',
              petId: '1',
              vaccineName: 'Rabies',
              vaccineType: 'Core',
              administeredDate: DateTime(2024, 1, 10),
              nextDueDate: DateTime(2025, 1, 10),
              isRequired: true,
              veterinarianName: 'Dr. Maria Santos',
              veterinarianLicense: 'VET-12345',
              clinicName: 'Animal Care Clinic',
              clinicAddress: '123 Vet Street',
            ),
          ],
        );

        expect(pet.id, '1');
        expect(pet.name, 'Buddy');
        expect(pet.type, PetType.dog);
        expect(pet.ageInYears, greaterThan(3.0));
        expect(pet.isExpired, false);
        expect(pet.isExpiringSoon, false);
        expect(pet.isUpToDateOnVaccinations, true);
      });

      test('should check vaccination status correctly', () {
        final pet = PetEntity(
          id: '1',
          ownerId: 'user_1',
          ownerName: 'John Doe',
          ownerEmail: 'john@email.com',
          ownerPhone: '+63 912 345 6789',
          ownerAddress: '123 Main Street',
          name: 'Buddy',
          type: PetType.dog,
          breed: 'Golden Retriever',
          gender: PetGender.male,
          size: PetSize.large,
          birthDate: DateTime(2020, 3, 15),
          color: 'Golden',
          microchipId: 'MC-123456789',
          registrationNumber: 'PET-2024-001',
          registrationDate: DateTime(2024, 1, 15),
          expiryDate: DateTime.now().add(const Duration(days: 15)), // Expiring soon
          status: PetRegistrationStatus.approved,
          createdAt: DateTime(2024, 1, 10),
        );

        expect(pet.isExpiringSoon, true);
        expect(pet.isExpired, false);
      });
    });

    group('Waste Schedule Entity', () {
      test('should create waste schedule entity with all properties', () {
        final schedule = WasteScheduleEntity(
          id: '1',
          barangayId: 'brgy_001',
          barangayName: 'Barangay 1',
          zone: 'Zone A',
          wasteType: WasteType.general,
          collectionDate: DateTime.now().add(const Duration(days: 1)),
          collectionTime: '08:00',
          status: CollectionStatus.scheduled,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          residentsNotified: true,
        );

        expect(schedule.id, '1');
        expect(schedule.wasteType, WasteType.general);
        expect(schedule.isToday, false);
        expect(schedule.isTomorrow, true);
        expect(schedule.isUpcoming, true);
        expect(schedule.isOverdue, false);
      });

      test('should check schedule status correctly', () {
        final pastSchedule = WasteScheduleEntity(
          id: '1',
          barangayId: 'brgy_001',
          barangayName: 'Barangay 1',
          zone: 'Zone A',
          wasteType: WasteType.general,
          collectionDate: DateTime.now().subtract(const Duration(days: 1)),
          collectionTime: '08:00',
          status: CollectionStatus.scheduled,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
        );

        expect(pastSchedule.isOverdue, true);
        expect(pastSchedule.isToday, false);
        expect(pastSchedule.isUpcoming, false);
      });
    });

    group('Hazard Report Entity', () {
      test('should create hazard report entity with all properties', () {
        final report = HazardReportEntity(
          id: '1',
          reporterId: 'user_1',
          reporterName: 'John Doe',
          reporterEmail: 'john@email.com',
          reporterPhone: '+63 912 345 6789',
          hazardType: HazardType.roadDamage,
          severity: HazardSeverity.medium,
          title: 'Pothole on Main Street',
          description: 'Large pothole causing traffic issues',
          location: 'Main Street, near Barangay Hall',
          latitude: 14.5995,
          longitude: 120.9842,
          status: HazardReportStatus.assigned,
          reportDate: DateTime.now().subtract(const Duration(days: 3)),
          isAnonymous: false,
          assignedTo: 'Public Works Department',
          estimatedResolutionDate: DateTime.now().add(const Duration(days: 7)),
          images: ['image1.jpg', 'image2.jpg'],
        );

        expect(report.id, '1');
        expect(report.hazardType, HazardType.roadDamage);
        expect(report.severity, HazardSeverity.medium);
        expect(report.daysSinceReport, 3);
        expect(report.isOverdue, false);
        expect(report.isInProgress, true);
        expect(report.isResolved, false);
      });

      test('should check report status correctly', () {
        final overdueReport = HazardReportEntity(
          id: '1',
          reporterId: 'user_1',
          reporterName: 'John Doe',
          reporterEmail: 'john@email.com',
          reporterPhone: '+63 912 345 6789',
          hazardType: HazardType.roadDamage,
          severity: HazardSeverity.medium,
          title: 'Overdue Report',
          description: 'Test report',
          location: 'Test Location',
          latitude: 14.5995,
          longitude: 120.9842,
          status: HazardReportStatus.assigned,
          reportDate: DateTime.now().subtract(const Duration(days: 10)),
          isAnonymous: false,
          estimatedResolutionDate: DateTime.now().subtract(const Duration(days: 1)), // Overdue
        );

        expect(overdueReport.isOverdue, true);
        expect(overdueReport.daysSinceReport, 10);
      });
    });

    group('SLA Metrics Entity', () {
      test('should create SLA metrics entity with all properties', () {
        const sla = SlaMetricsEntity(
          serviceName: 'Business Permits',
          totalRequests: 150,
          completedOnTime: 135,
          completedLate: 10,
          pendingRequests: 5,
          averageProcessingTime: 2.5,
          targetSlaHours: 24,
          complianceRate: 90.0,
          period: 'monthly',
        );

        expect(sla.serviceName, 'Business Permits');
        expect(sla.calculatedComplianceRate, 90.0);
        expect(sla.performanceStatus, 'excellent');
      });

      test('should calculate compliance rate correctly', () {
        const sla = SlaMetricsEntity(
          serviceName: 'Test Service',
          totalRequests: 100,
          completedOnTime: 80,
          completedLate: 15,
          pendingRequests: 5,
          averageProcessingTime: 1.0,
          targetSlaHours: 24,
          complianceRate: 80.0,
          period: 'monthly',
        );

        expect(sla.calculatedComplianceRate, 80.0);
        expect(sla.performanceStatus, 'good');
      });
    });

    group('Collection Stats Entity', () {
      test('should create collection stats entity with all properties', () {
        const stats = CollectionStatsEntity(
          period: 'January 2024',
          totalRevenue: 2500000.0,
          taxCollection: 1800000.0,
          permitFees: 500000.0,
          businessPermitFees: 300000.0,
          propertyTaxCollection: 1500000.0,
          otherFees: 200000.0,
          collectionTarget: 3000000.0,
          collectionRate: 83.3,
        );

        expect(stats.period, 'January 2024');
        expect(stats.calculatedCollectionRate, 83.3);
        expect(stats.collectionStatus, 'on_track');
      });
    });

    group('Service Usage Entity', () {
      test('should create service usage entity with all properties', () {
        const usage = ServiceUsageEntity(
          serviceName: 'Property Tax',
          totalRequests: 200,
          completedRequests: 198,
          pendingRequests: 2,
          cancelledRequests: 0,
          completionRate: 99.0,
          averageProcessingTime: 1.2,
          userSatisfaction: 4.5,
        );

        expect(usage.serviceName, 'Property Tax');
        expect(usage.calculatedCompletionRate, 99.0);
      });
    });

    group('Open Data Dataset Entity', () {
      test('should create open data dataset entity with all properties', () {
        final dataset = OpenDataDatasetEntity(
          id: '1',
          title: 'Business Permits Data',
          description: 'Monthly business permit data',
          category: DataCategory.business,
          organization: 'BPLO',
          contactEmail: 'bplo@lgu.gov.ph',
          license: DataLicense.openData,
          updateFrequency: UpdateFrequency.monthly,
          lastUpdated: DateTime(2024, 1, 15),
          createdAt: DateTime(2024, 1, 1),
          isPublic: true,
          downloadCount: 245,
          viewCount: 1200,
          recordCount: 1500,
        );

        expect(dataset.id, '1');
        expect(dataset.title, 'Business Permits Data');
        expect(dataset.category, DataCategory.business);
        expect(dataset.isRecentlyUpdated, true);
        expect(dataset.popularityScore, 1690); // (245 * 2) + 1200
      });

      test('should check dataset status correctly', () {
        final oldDataset = OpenDataDatasetEntity(
          id: '1',
          title: 'Old Dataset',
          description: 'Old data',
          category: DataCategory.business,
          organization: 'Test Org',
          contactEmail: 'test@email.com',
          license: DataLicense.openData,
          updateFrequency: UpdateFrequency.monthly,
          lastUpdated: DateTime(2023, 12, 1), // Old date
          createdAt: DateTime(2023, 1, 1),
          isPublic: true,
          downloadCount: 100,
          viewCount: 500,
        );

        expect(oldDataset.isRecentlyUpdated, false);
        expect(oldDataset.popularityScore, 700); // (100 * 2) + 500
      });
    });

    group('Data Quality Report Entity', () {
      test('should create data quality report entity with all properties', () {
        final qualityReport = DataQualityReportEntity(
          datasetId: '1',
          reportDate: DateTime(2024, 1, 15),
          overallScore: 85.0,
          completeness: 90.0,
          accuracy: 85.0,
          consistency: 80.0,
          timeliness: 90.0,
          validity: 85.0,
        );

        expect(qualityReport.datasetId, '1');
        expect(qualityReport.overallScore, 85.0);
        expect(qualityReport.qualityGrade, 'B');
        expect(qualityReport.qualityStatus, 'good');
      });
    });

    group('Dashboard Summary Entity', () {
      test('should create dashboard summary entity with all properties', () {
        final summary = DashboardSummaryEntity(
          period: 'January 2024',
          slaMetrics: [
            SlaMetricsEntity(
              serviceName: 'Test Service',
              totalRequests: 100,
              completedOnTime: 90,
              completedLate: 5,
              pendingRequests: 5,
              averageProcessingTime: 2.0,
              targetSlaHours: 24,
              complianceRate: 90.0,
              period: 'monthly',
            ),
          ],
          collectionStats: CollectionStatsEntity(
            period: 'January 2024',
            totalRevenue: 1000000.0,
            taxCollection: 800000.0,
            permitFees: 200000.0,
            businessPermitFees: 100000.0,
            propertyTaxCollection: 700000.0,
            otherFees: 100000.0,
            collectionTarget: 1200000.0,
            collectionRate: 83.3,
          ),
          serviceUsageStats: ServiceUsageStatsEntity(
            period: 'January 2024',
            totalUsers: 1000,
            activeUsers: 800,
            newUsers: 100,
            mostUsedServices: [],
            leastUsedServices: [],
            userEngagement: 80.0,
            serviceCompletionRate: 95.0,
          ),
          lastUpdated: DateTime(2024, 1, 15),
        );

        expect(summary.period, 'January 2024');
        expect(summary.overallPerformanceScore, greaterThan(80.0));
        expect(summary.overallPerformanceStatus, 'good');
      });
    });
  });
}
