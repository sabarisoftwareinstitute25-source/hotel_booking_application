import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final bool showActions;

  const UserTile({
    Key? key,
    required this.user,
    required this.onTap,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [

              CircleAvatar(
                radius: 25,
                backgroundColor: _getAvatarColor().withOpacity(0.1),
                child: Icon(
                  _getAvatarIcon(),
                  color: _getAvatarColor(),
                ),
              ),
              const SizedBox(width: 12),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user.verificationStatus.toString().split('.').last,
                            style: TextStyle(
                              color: _getStatusColor(),
                              fontSize: 10,
                            ),
                          ),
                        ),
                        if (user.userType == UserType.vendor && user.hotelStar != null) ...[
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              user.hotelStar!.value,
                                  (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),


              if (showActions && user.userType == UserType.vendor)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user.verificationStatus == VerificationStatus.pending) ...[
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: AppTheme.accentColor,
                        ),
                        tooltip: 'Approve',
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: AppTheme.dangerColor,
                        ),
                        tooltip: 'Reject',
                      ),
                    ],
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppTheme.secondaryColor,
                      ),
                      tooltip: 'Edit',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getAvatarColor() {
    switch (user.userType) {
      case UserType.customer:
        return AppTheme.accentColor;
      case UserType.vendor:
        return AppTheme.secondaryColor;
      case UserType.admin:
        return AppTheme.primaryColor;
    }
  }

  IconData _getAvatarIcon() {
    switch (user.userType) {
      case UserType.customer:
        return Icons.person;
      case UserType.vendor:
        return Icons.business;
      case UserType.admin:
        return Icons.admin_panel_settings;
    }
  }

  Color _getStatusColor() {
    switch (user.verificationStatus) {
      case VerificationStatus.verified:
        return AppTheme.accentColor;
      case VerificationStatus.pending:
        return AppTheme.warningColor;
      case VerificationStatus.rejected:
        return AppTheme.dangerColor;
    }
  }
}