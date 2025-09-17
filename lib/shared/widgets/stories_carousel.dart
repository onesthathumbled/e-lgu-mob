import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Story/MyDay entity for the carousel
class StoryEntity {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String videoUrl;
  final String author;
  final String authorImageUrl;
  final DateTime createdAt;
  final Duration duration;
  final bool isVideo;

  const StoryEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.videoUrl,
    required this.author,
    required this.authorImageUrl,
    required this.createdAt,
    required this.duration,
    this.isVideo = false,
  });
}

/// Stories carousel widget with MyDay-style layout
class StoriesCarousel extends StatefulWidget {
  const StoriesCarousel({super.key});

  @override
  State<StoriesCarousel> createState() => _StoriesCarouselState();
}

class _StoriesCarouselState extends State<StoriesCarousel> {
  
  // Mock stories data - only mayor stories
  final List<StoryEntity> _stories = [
    StoryEntity(
      id: '1',
      title: 'Weekly Update',
      subtitle: 'Mayor\'s weekly message to the community',
      imageUrl: 'https://via.placeholder.com/300x400/0038A8/FFFFFF?text=Mayor+Message',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      author: 'Mayor Juan Santos',
      authorImageUrl: 'https://via.placeholder.com/50x50/0038A8/FFFFFF?text=JS',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      duration: const Duration(seconds: 15),
      isVideo: true,
    ),
    StoryEntity(
      id: '2',
      title: 'Infrastructure Progress',
      subtitle: 'Updates on ongoing infrastructure projects',
      imageUrl: 'https://via.placeholder.com/300x400/CE1126/FFFFFF?text=Infrastructure',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      author: 'Mayor Juan Santos',
      authorImageUrl: 'https://via.placeholder.com/50x50/0038A8/FFFFFF?text=JS',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      duration: const Duration(seconds: 12),
      isVideo: true,
    ),
    StoryEntity(
      id: '3',
      title: 'Community Programs',
      subtitle: 'New community programs and initiatives',
      imageUrl: 'https://via.placeholder.com/300x400/FCD116/000000?text=Programs',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      author: 'Mayor Juan Santos',
      authorImageUrl: 'https://via.placeholder.com/50x50/0038A8/FFFFFF?text=JS',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      duration: const Duration(seconds: 18),
      isVideo: true,
    ),
    StoryEntity(
      id: '4',
      title: 'Public Safety Update',
      subtitle: 'Important safety information for residents',
      imageUrl: 'https://via.placeholder.com/300x400/0038A8/FFFFFF?text=Safety',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      author: 'Mayor Juan Santos',
      authorImageUrl: 'https://via.placeholder.com/50x50/0038A8/FFFFFF?text=JS',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      duration: const Duration(seconds: 20),
      isVideo: true,
    ),
    StoryEntity(
      id: '5',
      title: 'Economic Development',
      subtitle: 'Updates on local economic development',
      imageUrl: 'https://via.placeholder.com/300x400/CE1126/FFFFFF?text=Economy',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      author: 'Mayor Juan Santos',
      authorImageUrl: 'https://via.placeholder.com/50x50/0038A8/FFFFFF?text=JS',
      createdAt: DateTime.now().subtract(const Duration(hours: 10)),
      duration: const Duration(seconds: 14),
      isVideo: true,
    ),
  ];

  void _onStoryTap(StoryEntity story) {
    // Navigate to full story view
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenStoryView(
          stories: _stories,
          initialIndex: _stories.indexOf(story),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_stories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Stories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Horizontal scrollable stories
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                final story = _stories[index];
                return _buildStoryItem(story);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(StoryEntity story) {
    return GestureDetector(
      onTap: () => _onStoryTap(story),
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            // Story rectangle with gradient border
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0038A8),
                    const Color(0xFFCE1126),
                    const Color(0xFFFCD116),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0038A8).withValues(alpha: 0.8),
                        const Color(0xFFCE1126).withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: story.isVideo
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                story.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF0038A8),
                                    child: const Icon(
                                      Icons.play_circle_filled,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_circle_filled,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Image.network(
                            story.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF0038A8),
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 4),
            
            
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// Full-screen story view with left/right navigation
class FullScreenStoryView extends StatefulWidget {
  final List<StoryEntity> stories;
  final int initialIndex;

  const FullScreenStoryView({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<FullScreenStoryView> createState() => _FullScreenStoryViewState();
}

class _FullScreenStoryViewState extends State<FullScreenStoryView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  
  int _currentIndex = 0;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _progressController = AnimationController(
      duration: widget.stories[_currentIndex].duration,
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));
    
    _startProgress();
    
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startProgress() {
    if (_isPlaying) {
      _progressController.forward();
    }
  }

  void _pauseProgress() {
    _progressController.stop();
  }

  void _resumeProgress() {
    if (_isPlaying) {
      _progressController.forward();
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      _currentIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _resetProgress();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _resetProgress();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _resetProgress() {
    _progressController.reset();
    _progressController.duration = widget.stories[_currentIndex].duration;
    _startProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            // Swipe down to close
            if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
              Navigator.of(context).pop();
            }
          },
          child: Stack(
            children: [
            // Progress bars
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(widget.stories.length, (index) {
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: EdgeInsets.only(
                        right: index < widget.stories.length - 1 ? 4 : 0,
                      ),
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          double progress = 0.0;
                          if (index < _currentIndex) {
                            progress = 1.0;
                          } else if (index == _currentIndex) {
                            progress = _progressAnimation.value;
                          }
                          
                          return LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withValues(alpha: 0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            // Story content
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _resetProgress();
              },
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return _buildFullScreenStory(story);
              },
            ),
            
            // Header with author info
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.stories[_currentIndex].authorImageUrl),
                    backgroundColor: Colors.white,
                    child: widget.stories[_currentIndex].authorImageUrl.contains('placeholder')
                        ? Text(
                            widget.stories[_currentIndex].author.substring(0, 2).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.stories[_currentIndex].author,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatTimeAgo(widget.stories[_currentIndex].createdAt),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Touch areas for navigation (avoiding top area where X button is)
            Positioned(
              left: 0,
              top: 80, // Start below the header area
              bottom: 0,
              child: GestureDetector(
                onTap: _previousStory,
                onTapDown: (_) => _pauseProgress(),
                onTapUp: (_) => _resumeProgress(),
                onTapCancel: () => _resumeProgress(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.transparent,
                ),
              ),
            ),
            
            Positioned(
              right: 0,
              top: 80, // Start below the header area
              bottom: 0,
              child: GestureDetector(
                onTap: _nextStory,
                onTapDown: (_) => _pauseProgress(),
                onTapUp: (_) => _resumeProgress(),
                onTapCancel: () => _resumeProgress(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.transparent,
                ),
              ),
            ),
            
            // Center tap area to pause/resume
            Positioned(
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              top: 80, // Start below the header area
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                  if (_isPlaying) {
                    _resumeProgress();
                  } else {
                    _pauseProgress();
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildFullScreenStory(StoryEntity story) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: story.isVideo
          ? Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0038A8).withValues(alpha: 0.8),
                        const Color(0xFFCE1126).withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  story.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0038A8).withValues(alpha: 0.8),
                            const Color(0xFFCE1126).withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// Story detail modal
class StoryDetailModal extends StatelessWidget {
  final StoryEntity story;

  const StoryDetailModal({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(story.authorImageUrl),
                  backgroundColor: const Color(0xFF0038A8),
                  child: story.authorImageUrl.contains('placeholder')
                      ? Text(
                          story.author.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.author,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatTimeAgo(story.createdAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    story.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Video/Image placeholder
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: story.isVideo
                        ? const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              size: 60,
                              color: Color(0xFF0038A8),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle share action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Story shared!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0038A8),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Handle like action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Story liked!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.favorite_border),
                          label: const Text('Like'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0038A8),
                            side: const BorderSide(color: Color(0xFF0038A8)),
                          ),
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
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
