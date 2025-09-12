import 'package:flutter_test/flutter_test.dart';
import 'package:e_lgu_mob/features/phase2/queue_management/domain/entities/queue_entity.dart';
import 'package:e_lgu_mob/features/phase2/obos/domain/entities/obos_entity.dart';
import 'package:e_lgu_mob/features/phase2/transport/domain/entities/transport_entity.dart';
import 'package:e_lgu_mob/features/phase2/evac_map/domain/entities/evac_entity.dart';
import 'package:e_lgu_mob/features/phase2/community_groups/domain/entities/community_group_entity.dart';
import 'package:e_lgu_mob/features/phase2/gamification/domain/entities/gamification_entity.dart';

void main() {
  group('Phase 2 Unit Tests', () {
    group('Queue Management Entities', () {
      test('QueueTicketEntity should be created correctly', () {
        final ticket = QueueTicketEntity(
          id: 'ticket_001',
          ticketNumber: 'A-001',
          serviceType: QueueServiceType.businessPermit,
          citizenName: 'John Doe',
          citizenContact: '+63 912 345 6789',
          estimatedWaitTime: 30,
          status: QueueStatus.waiting,
          createdAt: DateTime.now(),
          priority: QueuePriority.normal,
        );

        expect(ticket.id, 'ticket_001');
        expect(ticket.ticketNumber, 'A-001');
        expect(ticket.serviceType, QueueServiceType.businessPermit);
        expect(ticket.citizenName, 'John Doe');
        expect(ticket.isActive, true);
        expect(ticket.isCompleted, false);
        expect(ticket.isHighPriority, false);
      });

      test('QueueOfficeEntity should calculate capacity correctly', () {
        final office = QueueOfficeEntity(
          id: 'office_001',
          name: 'Business Permit Office',
          location: 'City Hall, 2nd Floor',
          operatingHours: '8:00 AM - 5:00 PM',
          services: [QueueServiceType.businessPermit],
          currentQueue: 8,
          averageWaitTime: 25,
          isOpen: true,
          capacity: 20,
        );

        expect(office.isAtCapacity, false);
        expect(office.queueStatus, 'Moderate Queue');
        expect(office.availableCapacity, 12);
      });
    });

    group('OBOS Entities', () {
      test('BuildingPermitEntity should be created correctly', () {
        final permit = BuildingPermitEntity(
          id: 'permit_001',
          applicantName: 'John Doe',
          applicantContact: '+63 912 345 6789',
          propertyAddress: '123 Main St',
          buildingType: BuildingType.residential,
          constructionType: ConstructionType.newConstruction,
          totalFloorArea: 100.0,
          numberOfFloors: 2,
          estimatedCost: 500000.0,
          status: ObosStatus.pending,
          submittedAt: DateTime.now(),
        );

        expect(permit.id, 'permit_001');
        expect(permit.buildingType, BuildingType.residential);
        expect(permit.isPending, true);
        expect(permit.isApproved, false);
        expect(permit.totalFees, 0.0);
      });

      test('ObosFeeEntity should track payment status', () {
        final fee = ObosFeeEntity(
          id: 'fee_001',
          name: 'Application Fee',
          amount: 500.0,
          type: ObosFeeType.application,
          description: 'Building permit application fee',
          isPaid: true,
          paymentDate: DateTime.now(),
        );

        expect(fee.amount, 500.0);
        expect(fee.isPaid, true);
        expect(fee.paymentDate, isNotNull);
      });
    });

    group('Transport Entities', () {
      test('TricycleFranchiseEntity should track status correctly', () {
        final franchise = TricycleFranchiseEntity(
          id: 'franchise_001',
          operatorName: 'John Doe',
          operatorContact: '+63 912 345 6789',
          tricycleNumber: 'TR-001',
          engineNumber: 'ENG-001',
          chassisNumber: 'CH-001',
          route: 'Route 1',
          status: FranchiseStatus.active,
          applicationDate: DateTime.now().subtract(const Duration(days: 30)),
          approvedDate: DateTime.now().subtract(const Duration(days: 25)),
          expiryDate: DateTime.now().add(const Duration(days: 335)),
        );

        expect(franchise.isActive, true);
        expect(franchise.isExpired, false);
        expect(franchise.daysUntilExpiry, greaterThan(300));
      });

      test('TrafficViolationEntity should calculate due dates correctly', () {
        final violation = TrafficViolationEntity(
          id: 'violation_001',
          violatorName: 'John Doe',
          violatorContact: '+63 912 345 6789',
          vehiclePlateNumber: 'ABC-123',
          violationType: ViolationType.noHelmet,
          violationLocation: 'Main Street',
          violationDate: DateTime.now().subtract(const Duration(days: 15)),
          fineAmount: 1000.0,
          status: ViolationStatus.pending,
        );

        expect(violation.isPaid, false);
        expect(violation.isPending, true);
        expect(violation.isOverdue, false);
        expect(violation.daysUntilDue, greaterThan(0));
      });
    });

    group('EVAC Map Entities', () {
      test('EvacuationCenterEntity should calculate capacity correctly', () {
        final center = EvacuationCenterEntity(
          id: 'evac_001',
          name: 'Sample School',
          address: '123 Education St',
          latitude: 14.5995,
          longitude: 120.9842,
          capacity: 500,
          currentOccupancy: 120,
          status: EvacCenterStatus.available,
          category: EvacCenterCategory.school,
          facilities: [EvacFacility.electricity, EvacFacility.water],
        );

        expect(center.isAvailable, true);
        expect(center.isAtCapacity, false);
        expect(center.availableCapacity, 380);
        expect(center.occupancyPercentage, 24.0);
      });

      test('DisasterAlertEntity should track status correctly', () {
        final alert = DisasterAlertEntity(
          id: 'alert_001',
          title: 'Typhoon Warning',
          description: 'Heavy rainfall expected',
          alertType: DisasterType.typhoon,
          severity: AlertSeverity.high,
          affectedAreas: ['Barangay 1', 'Barangay 2'],
          issuedAt: DateTime.now().subtract(const Duration(hours: 2)),
          validUntil: DateTime.now().add(const Duration(hours: 24)),
          status: AlertStatus.active,
        );

        expect(alert.isActive, true);
        expect(alert.isExpired, false);
        expect(alert.isHighSeverity, true);
        expect(alert.timeRemaining.inHours, greaterThan(20));
      });
    });

    group('Community Groups Entities', () {
      test('CommunityGroupEntity should track membership correctly', () {
        final group = CommunityGroupEntity(
          id: 'group_001',
          name: 'Sample Group',
          description: 'A sample community group',
          category: GroupCategory.neighborhood,
          creatorId: 'user_001',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          memberCount: 150,
          isPublic: true,
          isActive: true,
        );

        expect(group.isPopular, true);
        expect(group.isNew, false);
        expect(group.isModerated, false);
      });

      test('GroupPostEntity should track engagement correctly', () {
        final post = GroupPostEntity(
          id: 'post_001',
          groupId: 'group_001',
          authorId: 'user_001',
          authorName: 'John Doe',
          content: 'Sample post content',
          postType: PostType.text,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          isPinned: false,
          isLocked: false,
          likes: 15,
          comments: 8,
          shares: 3,
        );

        expect(post.isPopular, true);
        expect(post.isRecent, true);
        expect(post.isEdited, false);
        expect(post.isDeleted, false);
      });

      test('GroupPollEntity should track voting correctly', () {
        final poll = GroupPollEntity(
          id: 'poll_001',
          groupId: 'group_001',
          creatorId: 'user_001',
          creatorName: 'John Doe',
          question: 'What is your favorite color?',
          options: [
            PollOptionEntity(id: 'opt_1', text: 'Red', voteCount: 10),
            PollOptionEntity(id: 'opt_2', text: 'Blue', voteCount: 15),
            PollOptionEntity(id: 'opt_3', text: 'Green', voteCount: 5),
          ],
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          expiresAt: DateTime.now().add(const Duration(days: 6)),
          isActive: true,
        );

        expect(poll.isCurrentlyActive, true);
        expect(poll.isExpired, false);
        expect(poll.daysUntilExpiry, 5);
      });
    });

    group('Gamification Entities', () {
      test('UserPointsEntity should calculate level correctly', () {
        final userPoints = UserPointsEntity(
          userId: 'user_001',
          totalPoints: 2450,
          availablePoints: 1800,
          level: 8,
          experience: 450,
          nextLevelExperience: 600,
          rank: 15,
          badges: [],
          achievements: [],
        );

        expect(userPoints.levelTitle, 'Active Citizen');
        expect(userPoints.experienceProgress, 0.75);
        expect(userPoints.pointsToNextLevel, 150);
        expect(userPoints.isMaxLevel, false);
      });

      test('BadgeEntity should track progress correctly', () {
        final badge = BadgeEntity(
          id: 'badge_001',
          name: 'Service Master',
          description: 'Complete 10 service applications',
          icon: '⭐',
          category: BadgeCategory.service,
          rarity: BadgeRarity.rare,
          pointsRequired: 1000,
          isEarned: false,
          progress: 0.7,
        );

        expect(badge.isInProgress, true);
        expect(badge.progressPercentage, 0.7);
        expect(badge.isEarned, false);
      });

      test('AchievementEntity should calculate progress correctly', () {
        final achievement = AchievementEntity(
          id: 'ach_001',
          title: 'Service Champion',
          description: 'Complete 10 service applications',
          category: AchievementCategory.service,
          pointsReward: 500,
          isCompleted: false,
          requirements: ['complete_applications'],
          progress: {'complete_applications': 7},
        );

        expect(achievement.isInProgress, true);
        expect(achievement.overallProgress, 0.7);
        expect(achievement.isCompleted, false);
      });

      test('RewardEntity should validate redemption correctly', () {
        final reward = RewardEntity(
          id: 'reward_001',
          name: '10% Off Business Permit',
          description: 'Get 10% discount on your next business permit',
          pointsCost: 500,
          category: RewardCategory.discount,
          isAvailable: true,
          quantity: 10,
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        expect(reward.canBeRedeemed, true);
        expect(reward.isExpired, false);
        expect(reward.isOutOfStock, false);
      });

      test('LeaderboardEntryEntity should display rank correctly', () {
        final entry = LeaderboardEntryEntity(
          userId: 'user_001',
          userName: 'John Doe',
          userAvatar: null,
          totalPoints: 2450,
          level: 8,
          rank: 15,
          badgesCount: 5,
          achievementsCount: 3,
        );

        expect(entry.levelTitle, 'Active Citizen');
        expect(entry.rank, 15);
        expect(entry.totalPoints, 2450);
      });
    });

    group('Enum Values', () {
      test('QueueServiceType should have all expected values', () {
        expect(QueueServiceType.values.length, 10);
        expect(QueueServiceType.values.contains(QueueServiceType.businessPermit), true);
        expect(QueueServiceType.values.contains(QueueServiceType.propertyTax), true);
        expect(QueueServiceType.values.contains(QueueServiceType.civilRegistry), true);
      });

      test('ObosStatus should have all expected values', () {
        expect(ObosStatus.values.length, 8);
        expect(ObosStatus.values.contains(ObosStatus.pending), true);
        expect(ObosStatus.values.contains(ObosStatus.approved), true);
        expect(ObosStatus.values.contains(ObosStatus.rejected), true);
      });

      test('DisasterType should have all expected values', () {
        expect(DisasterType.values.length, 8);
        expect(DisasterType.values.contains(DisasterType.typhoon), true);
        expect(DisasterType.values.contains(DisasterType.flood), true);
        expect(DisasterType.values.contains(DisasterType.earthquake), true);
      });

      test('GroupCategory should have all expected values', () {
        expect(GroupCategory.values.length, 11);
        expect(GroupCategory.values.contains(GroupCategory.neighborhood), true);
        expect(GroupCategory.values.contains(GroupCategory.hobby), true);
        expect(GroupCategory.values.contains(GroupCategory.business), true);
      });

      test('BadgeRarity should have all expected values', () {
        expect(BadgeRarity.values.length, 5);
        expect(BadgeRarity.values.contains(BadgeRarity.common), true);
        expect(BadgeRarity.values.contains(BadgeRarity.rare), true);
        expect(BadgeRarity.values.contains(BadgeRarity.legendary), true);
      });
    });
  });
}
