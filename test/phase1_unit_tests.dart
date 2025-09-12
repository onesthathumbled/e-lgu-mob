import 'package:flutter_test/flutter_test.dart';
import 'package:e_lgu_mob/features/auth/domain/entities/user_entity.dart';
import 'package:e_lgu_mob/features/business_permits/domain/entities/business_permit_entity.dart';
import 'package:e_lgu_mob/features/civil_registry/domain/entities/civil_registry_entity.dart';
import 'package:e_lgu_mob/features/community/domain/entities/community_entity.dart';
import 'package:e_lgu_mob/features/permits/domain/entities/permit_entity.dart';
import 'package:e_lgu_mob/features/social_programs/domain/entities/social_program_entity.dart';

/// Phase 1 Unit Tests for e-LGU Mobile App
/// 
/// This test suite validates domain entities and business logic
void main() {
  group('User Entity Tests', () {
    test('UserEntity should be created with required fields', () {
      final address = AddressEntity(
        street: '123 Main St',
        barangay: 'Barangay 1',
        city: 'Sample City',
        province: 'Sample Province',
        postalCode: '1234',
      );

      final user = UserEntity(
        id: 'user_001',
        email: 'john.doe@email.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '+63 912 345 6789',
        dateOfBirth: DateTime(1990, 5, 15),
        address: address,
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.id, 'user_001');
      expect(user.email, 'john.doe@email.com');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.isVerified, true);
    });

    test('UserEntity should support optional fields', () {
      final address = AddressEntity(
        street: '123 Main St',
        barangay: 'Barangay 1',
        city: 'Sample City',
        province: 'Sample Province',
        postalCode: '1234',
      );

      final user = UserEntity(
        id: 'user_001',
        email: 'john.doe@email.com',
        firstName: 'John',
        lastName: 'Doe',
        middleName: 'Michael',
        phoneNumber: '+63 912 345 6789',
        dateOfBirth: DateTime(1990, 5, 15),
        address: address,
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.middleName, 'Michael');
      expect(user.phoneNumber, '+63 912 345 6789');
      expect(user.address, address);
    });

    test('UserEntity should implement equality correctly', () {
      final address = AddressEntity(
        street: '123 Main St',
        barangay: 'Barangay 1',
        city: 'Sample City',
        province: 'Sample Province',
        postalCode: '1234',
      );

      final user1 = UserEntity(
        id: 'user_001',
        email: 'john.doe@email.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '+63 912 345 6789',
        dateOfBirth: DateTime(1990, 5, 15),
        address: address,
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final user2 = UserEntity(
        id: 'user_001',
        email: 'john.doe@email.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '+63 912 345 6789',
        dateOfBirth: DateTime(1990, 5, 15),
        address: address,
        isVerified: true,
        createdAt: user1.createdAt,
        updatedAt: user1.updatedAt,
      );

      expect(user1, equals(user2));
    });
  });

  group('Business Permit Entity Tests', () {
    test('BusinessPermitEntity should be created with required fields', () {
      final businessAddress = BusinessAddressEntity(
        street: '123 Main St',
        barangay: 'Barangay 1',
        city: 'Sample City',
        province: 'Sample Province',
        postalCode: '1234',
      );

      final permit = BusinessPermitEntity(
        id: 'permit_001',
        userId: 'user_001',
        businessName: 'Sample Business',
        businessType: 'Retail',
        businessAddress: businessAddress,
        ownerName: 'John Doe',
        ownerAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        businessDescription: 'A sample retail business',
        capitalization: 100000.0,
        employeesCount: 5,
        status: BusinessPermitStatus.pending,
        submittedAt: DateTime.now(),
      );

      expect(permit.id, 'permit_001');
      expect(permit.businessName, 'Sample Business');
      expect(permit.businessType, 'Retail');
      expect(permit.capitalization, 100000.0);
      expect(permit.employeesCount, 5);
      expect(permit.status, BusinessPermitStatus.pending);
    });

    test('BusinessPermitEntity should support optional fields', () {
      final businessAddress = BusinessAddressEntity(
        street: '123 Business St',
        barangay: 'Barangay 1',
        city: 'Sample City',
        province: 'Sample Province',
        postalCode: '1234',
      );

      final permit = BusinessPermitEntity(
        id: 'permit_001',
        userId: 'user_001',
        businessName: 'Sample Business',
        businessType: 'Retail',
        businessAddress: businessAddress,
        ownerName: 'John Doe',
        ownerAddress: '123 Business St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        businessDescription: 'A sample retail business',
        capitalization: 100000.0,
        employeesCount: 5,
        status: BusinessPermitStatus.approved,
        submittedAt: DateTime.now(),
        processedAt: DateTime.now().add(const Duration(days: 1)),
        completedAt: DateTime.now().add(const Duration(days: 7)),
        notes: 'Application approved',
      );

      expect(permit.status, BusinessPermitStatus.approved);
      expect(permit.processedAt, isNotNull);
      expect(permit.completedAt, isNotNull);
      expect(permit.notes, 'Application approved');
    });
  });

  group('Civil Registry Entity Tests', () {
    test('CivilRegistryDocumentEntity should be created with required fields', () {
      final document = CivilRegistryDocumentEntity(
        id: 'doc_001',
        userId: 'user_001',
        documentType: CivilRegistryDocumentType.birthCertificate,
        requestorName: 'John Doe',
        requestorAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        purpose: 'Passport application',
        status: CivilRegistryStatus.pending,
        submittedAt: DateTime.now(),
      );

      expect(document.id, 'doc_001');
      expect(document.userId, 'user_001');
      expect(document.documentType, CivilRegistryDocumentType.birthCertificate);
      expect(document.requestorName, 'John Doe');
      expect(document.purpose, 'Passport application');
      expect(document.status, CivilRegistryStatus.pending);
    });

    test('CivilRegistryDocumentEntity should support delivery options', () {
      final document = CivilRegistryDocumentEntity(
        id: 'doc_001',
        userId: 'user_001',
        documentType: CivilRegistryDocumentType.birthCertificate,
        requestorName: 'John Doe',
        requestorAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        purpose: 'Passport application',
        status: CivilRegistryStatus.pending,
        submittedAt: DateTime.now(),
        deliveryMethod: DeliveryMethod.delivery,
        deliveryAddress: '456 Delivery St, Barangay 2, Sample City',
        totalAmount: 155.0,
      );

      expect(document.deliveryMethod, DeliveryMethod.delivery);
      expect(document.deliveryAddress, '456 Delivery St, Barangay 2, Sample City');
      expect(document.totalAmount, 155.0);
    });

    test('CivilRegistryDocumentEntity status checks should work correctly', () {
      final pendingDoc = CivilRegistryDocumentEntity(
        id: 'doc_001',
        userId: 'user_001',
        documentType: CivilRegistryDocumentType.birthCertificate,
        requestorName: 'John Doe',
        requestorAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        purpose: 'Passport application',
        status: CivilRegistryStatus.pending,
        submittedAt: DateTime.now(),
      );

      final approvedDoc = CivilRegistryDocumentEntity(
        id: 'doc_002',
        userId: 'user_001',
        documentType: CivilRegistryDocumentType.marriageCertificate,
        requestorName: 'Jane Doe',
        requestorAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'jane.doe@email.com',
        purpose: 'Legal documentation',
        status: CivilRegistryStatus.approved,
        submittedAt: DateTime.now(),
      );

      expect(pendingDoc.isPending, true);
      expect(pendingDoc.isApproved, false);
      expect(approvedDoc.isPending, false);
      expect(approvedDoc.isApproved, true);
    });
  });

  group('Community Entity Tests', () {
    test('CommunityEventEntity should be created with required fields', () {
      final event = CommunityEventEntity(
        id: 'event_001',
        title: 'Annual Fiesta',
        description: 'Community fiesta celebration',
        eventType: EventType.fiesta,
        startDate: DateTime.now().add(const Duration(days: 7)),
        endDate: DateTime.now().add(const Duration(days: 7, hours: 8)),
        location: 'Town Plaza',
        organizer: 'Sample City Tourism Office',
        contactNumber: '+63 912 345 6789',
        contactEmail: 'tourism@samplecity.gov.ph',
        status: EventStatus.active,
        createdAt: DateTime.now(),
        registrationRequired: false,
      );

      expect(event.id, 'event_001');
      expect(event.title, 'Annual Fiesta');
      expect(event.eventType, EventType.fiesta);
      expect(event.status, EventStatus.active);
      expect(event.isActive, true);
    });

    test('CommunityEventEntity should handle participant limits', () {
      final event = CommunityEventEntity(
        id: 'event_001',
        title: 'Training Workshop',
        description: 'Skills training workshop',
        eventType: EventType.training,
        startDate: DateTime.now().add(const Duration(days: 7)),
        endDate: DateTime.now().add(const Duration(days: 7, hours: 8)),
        location: 'Training Center',
        organizer: 'Sample City Livelihood Office',
        contactNumber: '+63 912 345 6789',
        contactEmail: 'livelihood@samplecity.gov.ph',
        status: EventStatus.active,
        createdAt: DateTime.now(),
        maxParticipants: 30,
        currentParticipants: 25,
        registrationRequired: true,
      );

      expect(event.maxParticipants, 30);
      expect(event.currentParticipants, 25);
      expect(event.remainingSlots, 5);
      expect(event.isFull, false);

      // Test full event
      final fullEvent = CommunityEventEntity(
        id: 'event_002',
        title: 'Full Workshop',
        description: 'Full workshop',
        eventType: EventType.training,
        startDate: DateTime.now().add(const Duration(days: 7)),
        endDate: DateTime.now().add(const Duration(days: 7, hours: 8)),
        location: 'Training Center',
        organizer: 'Sample City Livelihood Office',
        contactNumber: '+63 912 345 6789',
        contactEmail: 'livelihood@samplecity.gov.ph',
        status: EventStatus.active,
        createdAt: DateTime.now(),
        maxParticipants: 30,
        currentParticipants: 30,
        registrationRequired: true,
      );

      expect(fullEvent.isFull, true);
      expect(fullEvent.remainingSlots, 0);
    });

    test('JobPostingEntity should be created with required fields', () {
      final job = JobPostingEntity(
        id: 'job_001',
        title: 'Administrative Assistant',
        description: 'Office administrative work',
        company: 'Sample City Hall',
        location: 'Sample City, Philippines',
        jobType: JobType.fullTime,
        salaryRange: '₱15,000 - ₱20,000',
        requirements: ['Bachelor\'s degree', '1 year experience'],
        benefits: ['Government benefits', 'Health insurance'],
        contactEmail: 'hr@samplecity.gov.ph',
        contactNumber: '+63 912 345 6789',
        status: JobStatus.active,
        postedAt: DateTime.now(),
      );

      expect(job.id, 'job_001');
      expect(job.title, 'Administrative Assistant');
      expect(job.company, 'Sample City Hall');
      expect(job.jobType, JobType.fullTime);
      expect(job.status, JobStatus.active);
      expect(job.isActive, true);
    });

    test('MarketplaceItemEntity should be created with required fields', () {
      final item = MarketplaceItemEntity(
        id: 'item_001',
        title: 'Samsung Galaxy S21',
        description: 'Smartphone in excellent condition',
        price: 25000.0,
        category: MarketplaceCategory.electronics,
        sellerName: 'Juan Dela Cruz',
        sellerContact: '+63 912 345 6789',
        location: 'Barangay 1, Sample City',
        status: MarketplaceStatus.active,
        postedAt: DateTime.now(),
        negotiable: true,
        deliveryAvailable: true,
      );

      expect(item.id, 'item_001');
      expect(item.title, 'Samsung Galaxy S21');
      expect(item.price, 25000.0);
      expect(item.category, MarketplaceCategory.electronics);
      expect(item.negotiable, true);
      expect(item.deliveryAvailable, true);
      expect(item.isActive, true);
    });
  });

  group('Permit Entity Tests', () {
    test('PermitEntity should be created with required fields', () {
      final permit = PermitEntity(
        id: 'permit_001',
        userId: 'user_001',
        permitType: PermitType.healthPermit,
        businessName: 'Sample Restaurant',
        businessAddress: '123 Food St, Barangay 1, Sample City',
        ownerName: 'John Doe',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        businessDescription: 'Restaurant serving local cuisine',
        status: PermitStatus.pending,
        submittedAt: DateTime.now(),
      );

      expect(permit.id, 'permit_001');
      expect(permit.userId, 'user_001');
      expect(permit.permitType, PermitType.healthPermit);
      expect(permit.businessName, 'Sample Restaurant');
      expect(permit.status, PermitStatus.pending);
      expect(permit.isPending, true);
    });

    test('PermitEntity should support fees and processing time', () {
      final permit = PermitEntity(
        id: 'permit_001',
        userId: 'user_001',
        permitType: PermitType.healthPermit,
        businessName: 'Sample Restaurant',
        businessAddress: '123 Food St, Barangay 1, Sample City',
        ownerName: 'John Doe',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        businessDescription: 'Restaurant serving local cuisine',
        status: PermitStatus.approved,
        submittedAt: DateTime.now(),
        processedAt: DateTime.now().add(const Duration(days: 1)),
        completedAt: DateTime.now().add(const Duration(days: 7)),
        fees: [
          PermitFeeEntity(
            id: 'fee_001',
            name: 'Application Fee',
            amount: 500.0,
            type: PermitFeeType.application,
          ),
        ],
        estimatedProcessingTime: 7,
        actualProcessingTime: 6,
      );

      expect(permit.status, PermitStatus.approved);
      expect(permit.isApproved, true);
      expect(permit.totalFees, 500.0);
      expect(permit.estimatedProcessingTime, 7);
      expect(permit.actualProcessingTime, 6);
      expect(permit.processingTimeInDays, 6);
    });
  });

  group('Social Program Entity Tests', () {
    test('SocialProgramEntity should be created with required fields', () {
      final program = SocialProgramEntity(
        id: 'prog_001',
        title: 'Medical Assistance Program',
        description: 'Financial assistance for medical expenses',
        type: SocialProgramType.medical,
        category: SocialProgramCategory.health,
        eligibilityRequirements: [
          'Must be a resident',
          'Must have valid ID',
        ],
        benefits: [
          'Up to ₱10,000 assistance',
          'Priority in government hospitals',
        ],
        applicationDeadline: DateTime.now().add(const Duration(days: 30)),
        status: SocialProgramStatus.active,
        createdAt: DateTime.now(),
      );

      expect(program.id, 'prog_001');
      expect(program.title, 'Medical Assistance Program');
      expect(program.type, SocialProgramType.medical);
      expect(program.category, SocialProgramCategory.health);
      expect(program.status, SocialProgramStatus.active);
      expect(program.isActive, true);
    });

    test('SocialProgramEntity should handle participant limits and deadlines', () {
      final program = SocialProgramEntity(
        id: 'prog_001',
        title: 'Scholarship Program',
        description: 'Educational scholarship program',
        type: SocialProgramType.scholarship,
        category: SocialProgramCategory.education,
        eligibilityRequirements: ['Must be enrolled in public school'],
        benefits: ['Full tuition coverage', 'Monthly allowance'],
        applicationDeadline: DateTime.now().add(const Duration(days: 15)),
        status: SocialProgramStatus.active,
        createdAt: DateTime.now(),
        maxParticipants: 50,
        currentParticipants: 30,
      );

      expect(program.maxParticipants, 50);
      expect(program.currentParticipants, 30);
      expect(program.remainingSlots, 20);
      expect(program.isFull, false);
      expect(program.isDeadlinePassed, false);

      // Test deadline passed
      final expiredProgram = SocialProgramEntity(
        id: 'prog_002',
        title: 'Expired Program',
        description: 'Expired program',
        type: SocialProgramType.scholarship,
        category: SocialProgramCategory.education,
        eligibilityRequirements: ['Must be enrolled'],
        benefits: ['Full tuition coverage'],
        applicationDeadline: DateTime.now().subtract(const Duration(days: 1)),
        status: SocialProgramStatus.active,
        createdAt: DateTime.now(),
      );

      expect(expiredProgram.isDeadlinePassed, true);
    });

    test('SocialProgramApplicationEntity should be created with required fields', () {
      final application = SocialProgramApplicationEntity(
        id: 'app_001',
        userId: 'user_001',
        programId: 'prog_001',
        applicantName: 'John Doe',
        applicantAddress: '123 Main St, Barangay 1, Sample City',
        contactNumber: '+63 912 345 6789',
        email: 'john.doe@email.com',
        reasonForApplication: 'Medical expenses for family member',
        status: ApplicationStatus.pending,
        submittedAt: DateTime.now(),
      );

      expect(application.id, 'app_001');
      expect(application.userId, 'user_001');
      expect(application.programId, 'prog_001');
      expect(application.applicantName, 'John Doe');
      expect(application.status, ApplicationStatus.pending);
      expect(application.isPending, true);
    });
  });

  group('Enum Tests', () {
    test('All enums should have correct values', () {
      // Test Civil Registry Document Types
      expect(CivilRegistryDocumentType.values.length, 8);
      expect(CivilRegistryDocumentType.birthCertificate.name, 'birthCertificate');
      expect(CivilRegistryDocumentType.marriageCertificate.name, 'marriageCertificate');

      // Test Event Types
      expect(EventType.values.length, 9);
      expect(EventType.fiesta.name, 'fiesta');
      expect(EventType.training.name, 'training');

      // Test Job Types
      expect(JobType.values.length, 6);
      expect(JobType.fullTime.name, 'fullTime');
      expect(JobType.partTime.name, 'partTime');

      // Test Marketplace Categories
      expect(MarketplaceCategory.values.length, 9);
      expect(MarketplaceCategory.electronics.name, 'electronics');
      expect(MarketplaceCategory.food.name, 'food');

      // Test Permit Types
      expect(PermitType.values.length, 6);
      expect(PermitType.healthPermit.name, 'healthPermit');
      expect(PermitType.workPermit.name, 'workPermit');

      // Test Social Program Types
      expect(SocialProgramType.values.length, 8);
      expect(SocialProgramType.medical.name, 'medical');
      expect(SocialProgramType.scholarship.name, 'scholarship');
    });
  });
}
