import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/pet_entity.dart';

class PetRegistrationPage extends StatefulWidget {
  const PetRegistrationPage({super.key});

  @override
  State<PetRegistrationPage> createState() => _PetRegistrationPageState();
}

class _PetRegistrationPageState extends State<PetRegistrationPage> {
  final List<PetEntity> _myPets = [
    PetEntity(
      id: '1',
      ownerId: 'user_001',
      ownerName: 'John Doe',
      ownerEmail: 'john.doe@email.com',
      ownerPhone: '+63 912 345 6789',
      ownerAddress: '123 Main Street, Barangay 1',
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
      description: 'Friendly and energetic golden retriever',
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
          clinicAddress: '123 Vet Street, Barangay 1',
        ),
        VaccinationRecordEntity(
          id: '2',
          petId: '1',
          vaccineName: 'DHPP',
          vaccineType: 'Core',
          administeredDate: DateTime(2024, 1, 10),
          nextDueDate: DateTime(2024, 7, 10),
          isRequired: true,
          veterinarianName: 'Dr. Maria Santos',
          veterinarianLicense: 'VET-12345',
          clinicName: 'Animal Care Clinic',
          clinicAddress: '123 Vet Street, Barangay 1',
        ),
      ],
      sterilizationStatus: true,
      sterilizationDate: DateTime(2021, 6, 15),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Registration'),
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
              'Pet Registration',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Register your pets and manage their vaccination records',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // My Pets Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Pets',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ShadButton(
                  text: 'Register New Pet',
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _showRegistrationForm();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (_myPets.isEmpty)
              ShadCard(
                child: Column(
                  children: [
                    Icon(
                      Icons.pets,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No pets registered yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Register your first pet to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ShadButton(
                      text: 'Register Pet',
                      onPressed: () {
                        _showRegistrationForm();
                      },
                    ),
                  ],
                ),
              )
            else
              ..._myPets.map((pet) => _buildPetCard(pet)),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildQuickActionCard(
                  'Lost Pet Report',
                  Icons.pets,
                  Colors.red,
                  () {
                    _showLostPetReport();
                  },
                ),
                _buildQuickActionCard(
                  'Vaccination Reminder',
                  Icons.medical_services,
                  Colors.green,
                  () {
                    _showVaccinationReminders();
                  },
                ),
                _buildQuickActionCard(
                  'Pet Directory',
                  Icons.pets,
                  Colors.blue,
                  () {
                    _showPetDirectory();
                  },
                ),
                _buildQuickActionCard(
                  'Veterinary Services',
                  Icons.local_hospital,
                  Colors.purple,
                  () {
                    _showVeterinaryServices();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetCard(PetEntity pet) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadCard(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pet Header
          Row(
            children: [
              // Pet Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getPetTypeColor(pet.type).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  _getPetTypeIcon(pet.type),
                  size: 30,
                  color: _getPetTypeColor(pet.type),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${pet.breed} • ${pet.gender.name} • ${pet.ageInYears.toStringAsFixed(1)} years old',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(pet.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pet.status.name.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(pet.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Pet Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem('Registration', pet.registrationNumber),
              ),
              Expanded(
                child: _buildDetailItem('Expires', '${pet.expiryDate.day}/${pet.expiryDate.month}/${pet.expiryDate.year}'),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildDetailItem('Microchip', pet.microchipId),
              ),
              Expanded(
                child: _buildDetailItem('Color', pet.color),
              ),
            ],
          ),
          
          if (pet.isExpiringSoon) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Registration expires soon. Please renew to avoid penalties.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ShadButton(
                  text: 'View Details',
                  variant: ShadButtonVariant.outline,
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _showPetDetails(pet);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShadButton(
                  text: 'QR Code',
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _showQRCode(pet);
                  },
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return ShadCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPetTypeIcon(PetType type) {
    switch (type) {
      case PetType.dog:
        return Icons.pets;
      case PetType.cat:
        return Icons.pets;
      case PetType.bird:
        return Icons.pets;
      case PetType.fish:
        return Icons.pets;
      case PetType.rabbit:
        return Icons.pets;
      case PetType.hamster:
        return Icons.pets;
      case PetType.guineaPig:
        return Icons.pets;
      case PetType.reptile:
        return Icons.pets;
      case PetType.other:
        return Icons.pets;
    }
  }

  Color _getPetTypeColor(PetType type) {
    switch (type) {
      case PetType.dog:
        return Colors.brown;
      case PetType.cat:
        return Colors.orange;
      case PetType.bird:
        return Colors.blue;
      case PetType.fish:
        return Colors.cyan;
      case PetType.rabbit:
        return Colors.grey;
      case PetType.hamster:
        return Colors.amber;
      case PetType.guineaPig:
        return Colors.pink;
      case PetType.reptile:
        return Colors.green;
      case PetType.other:
        return Colors.purple;
    }
  }

  Color _getStatusColor(PetRegistrationStatus status) {
    switch (status) {
      case PetRegistrationStatus.pending:
        return Colors.orange;
      case PetRegistrationStatus.approved:
        return Colors.green;
      case PetRegistrationStatus.rejected:
        return Colors.red;
      case PetRegistrationStatus.expired:
        return Colors.red;
      case PetRegistrationStatus.renewed:
        return Colors.blue;
    }
  }

  void _showPetDetails(PetEntity pet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
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
              
              // Pet Header
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _getPetTypeColor(pet.type).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      _getPetTypeIcon(pet.type),
                      size: 40,
                      color: _getPetTypeColor(pet.type),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${pet.breed} • ${pet.gender.name} • ${pet.ageInYears.toStringAsFixed(1)} years old',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
                      _buildDetailRow('Registration Number', pet.registrationNumber),
                      _buildDetailRow('Microchip ID', pet.microchipId),
                      _buildDetailRow('Color', pet.color),
                      _buildDetailRow('Size', pet.size.name),
                      _buildDetailRow('Registration Date', '${pet.registrationDate.day}/${pet.registrationDate.month}/${pet.registrationDate.year}'),
                      _buildDetailRow('Expiry Date', '${pet.expiryDate.day}/${pet.expiryDate.month}/${pet.expiryDate.year}'),
                      _buildDetailRow('Status', pet.status.name.toUpperCase()),
                      
                      if (pet.description != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pet.description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                      
                      if (pet.vaccinationRecords != null && pet.vaccinationRecords!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Vaccination Records',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...pet.vaccinationRecords!.map((record) => _buildVaccinationCard(record)),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ShadButton(
                              text: 'View QR Code',
                              onPressed: () {
                                Navigator.pop(context);
                                _showQRCode(pet);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ShadButton(
                              text: 'Update Info',
                              variant: ShadButtonVariant.outline,
                              onPressed: () {
                                // Update pet info
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Update pet info form would open here')),
                                );
                              },
                            ),
                          ),
                        ],
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
            width: 120,
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

  Widget _buildVaccinationCard(VaccinationRecordEntity record) {
    final theme = Theme.of(context);
    final isDue = record.isDue;
    final isDueSoon = record.isDueSoon;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDue 
            ? Colors.red.withValues(alpha: 0.1)
            : isDueSoon
                ? Colors.orange.withValues(alpha: 0.1)
                : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDue 
              ? Colors.red.withValues(alpha: 0.3)
              : isDueSoon
                  ? Colors.orange.withValues(alpha: 0.3)
                  : Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                size: 16,
                color: isDue 
                    ? Colors.red
                    : isDueSoon
                        ? Colors.orange
                        : Colors.green,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  record.vaccineName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isDue)
                Text(
                  'DUE',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else if (isDueSoon)
                Text(
                  'DUE SOON',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Next due: ${record.nextDueDate.day}/${record.nextDueDate.month}/${record.nextDueDate.year}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          Text(
            'Vet: ${record.veterinarianName}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCode(PetEntity pet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${pet.name}\'s QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Center(
                child: Text('QR Code Placeholder'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Registration: ${pet.registrationNumber}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Microchip: ${pet.microchipId}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showRegistrationForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet registration form would open here'),
      ),
    );
  }

  void _showLostPetReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lost pet report form would open here'),
      ),
    );
  }

  void _showVaccinationReminders() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vaccination reminders would be shown here'),
      ),
    );
  }

  void _showPetDirectory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet directory would be shown here'),
      ),
    );
  }

  void _showVeterinaryServices() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veterinary services directory would be shown here'),
      ),
    );
  }
}
