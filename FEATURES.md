# Arise App - Features & UI/UX Design

## Overview
Arise is a gamified fitness and habit tracking app inspired by the Solo Leveling anime/manga. Users become "Hunters" who level up by completing workouts, building habits, and developing skills.

## Design Philosophy

### Solo Leveling Aesthetic
- **Dark Theme**: Deep blue/purple backgrounds (#0A0E27)
- **Glow Effects**: Blue and purple glowing text and borders
- **Gothic Typography**: Rajdhani font for headers, Inter for body
- **System Panels**: Bordered panels with corner decorations
- **Gaming UI**: Progress bars with segments, XP indicators

### Color Palette
```
Primary Blue:     #3B82F6
Primary Purple:   #8B5CF6
Glow Blue:        #60A5FA
Glow Purple:      #A78BFA
Dark Background:  #0A0E27
Dark Panel:       #1A1F3A
Panel Border:     #2D3548
Text Primary:     #E5E7EB
Text Secondary:   #9CA3AF
```

## Core Features

### 1. Authentication System
**Hunter Login / Awakening**
- Email/password authentication via Supabase
- "HUNTER LOGIN" for existing users
- "HUNTER AWAKENING" for new users (signup)
- Glowing panels with corner decorations
- Error handling with themed notifications

**UI Components:**
- SystemPanel with glow effect
- GlowText for "ARISE" title
- Themed input fields
- Elevated button with loading state

### 2. Dashboard (Main Screen)
**Purpose**: Central hub showing player status and quick access to all features

**Layout:**
```
┌─────────────────────────────────────┐
│ [≡] ARISE              [👤] [🚪]    │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐  │
│  │ System Header                 │  │
│  │ Hunter Name | Class | Level   │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Player Status Panel           │  │
│  │ ─── XP Progress Bar ───       │  │
│  │ Stats Grid (STR, AGI, etc.)   │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌──────────┐  ┌──────────────────┐ │
│  │ Skill    │  │ Training         │ │
│  │ Points   │  │ Calendar         │ │
│  └──────────┘  └──────────────────┘ │
│                                     │
│  ┌──────────┐  ┌──────────────────┐ │
│  │ Current  │  │ Potions &        │ │
│  │ Goals    │  │ Items            │ │
│  └──────────┘  └──────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Recent Sessions               │  │
│  │ Session 1: +50 XP             │  │
│  │ Session 2: +30 XP             │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

**Components:**
- **SystemHeader**: Displays player name, class, and level in gradient container
- **PlayerStatusPanel**: XP bar and stat grid
- **SkillPointsPanel**: Available skill points
- **CalendarPanel**: Training calendar (to be implemented)
- **GoalPanel**: Current active goals
- **PotionsPanel**: Virtual items/rewards
- **SessionHistory**: Recent workout sessions

### 3. Profile Screen
**Purpose**: Customize player class and profile settings

**Features:**
- Player class selection (Warrior, Assassin, Mage)
- Profile picture upload
- Display name editing
- Stats distribution
- Account settings

**Player Classes:**
- **Warrior**: Focus on Strength and Vitality
- **Assassin**: Focus on Agility and Sense
- **Mage**: Focus on Intelligence and Mana

### 4. Habits Screen
**Purpose**: Track daily habits with gamified interface

**Layout:**
```
┌─────────────────────────────────────┐
│ HABITS                    [+]       │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐  │
│  │ Daily Quests                  │  │
│  │                               │  │
│  │ ┌─────────────────────────┐   │  │
│  │ │ Habit Card              │   │  │
│  │ │ ☐ Morning Workout       │   │  │
│  │ │ Streak: 5 days          │   │  │
│  │ │ Heatmap: ■■■■■□□        │   │  │
│  │ │ +10 XP                  │   │  │
│  │ └─────────────────────────┘   │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Quest Cards                   │  │
│  │                               │  │
│  │ ┌─────────────────────────┐   │  │
│  │ │ Quest: 30-Day Challenge │   │  │
│  │ │ Progress: 15/30         │   │  │
│  │ │ Reward: +100 XP         │   │  │
│  │ └─────────────────────────┘   │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

**Features:**
- Create/edit/delete habits
- Daily check-ins
- Streak tracking
- Heatmap visualization (year view)
- XP rewards per completion
- Categories (fitness, health, learning, etc.)

### 5. Skills Screen
**Purpose**: Track and level up various skills and characteristics

**Layout:**
```
┌─────────────────────────────────────────┐
│ SKILLS                                  │
├──────────────┬──────────────────────────┤
│ Characteris  │  Skills Grid             │
│ tics (30%)   │  (70%)                   │
│              │                          │
│ ┌──────────┐ │  ┌────────┐ ┌────────┐  │
│ │ Strength │ │  │ Push-  │ │ Running│  │
│ │ ████████ │ │  │ ups    │ │        │  │
│ │ Lv 5     │ │  │ ██████ │ │ ████   │  │
│ └──────────┘ │  │ Lv 3   │ │ Lv 2   │  │
│              │  └────────┘ └────────┘  │
│ ┌──────────┐ │                          │
│ │ Agility  │ │  ┌────────┐ ┌────────┐  │
│ │ ██████   │ │  │ Planks │ │ Cycling│  │
│ │ Lv 4     │ │  │ ████   │ │ ██     │  │
│ └──────────┘ │  │ Lv 2   │ │ Lv 1   │  │
│              │  └────────┘ └────────┘  │
│              │                          │
│              │  [+ QUICK CREATE]        │
└──────────────┴──────────────────────────┘
```

**Features:**
- **Characteristics Panel**: Core stats (Strength, Agility, Intelligence, Vitality, Sense)
- **Skills Grid**: Individual skills with progress bars
- Segmented progress bars (10 blocks)
- Level-up animations
- Skill categories
- Quick create new skills

**Progress Visualization:**
- 10-segment progress bars
- Glow effects when near completion
- Level badges

### 6. Routines Screen
**Purpose**: Create and manage workout routines

**Features:**
- Create custom workout routines
- Add exercises with sets/reps/duration
- Template routines (Push Day, Pull Day, Leg Day, etc.)
- Edit and delete routines
- Start workout session from routine

**Routine Structure:**
```
Routine: "Upper Body Blast"
├── Exercise 1: Push-ups (3 sets x 15 reps)
├── Exercise 2: Pull-ups (3 sets x 10 reps)
├── Exercise 3: Dips (3 sets x 12 reps)
└── Expected XP: 50
```

### 7. Active Workout Session
**Purpose**: Live workout tracking with timer and exercise progression

**Features:**
- Exercise list with checkboxes
- Rest timer between sets
- Skip/complete exercises
- XP accumulation display
- Session summary
- Level-up notifications

**Flow:**
1. Select routine or custom exercises
2. Start session
3. Complete exercises one by one
4. Track rest periods
5. Finish and earn XP
6. Update stats and skills

## Gamification Elements

### Experience Points (XP)
- **Habits**: 10-50 XP per completion
- **Workouts**: 30-100 XP based on intensity
- **Quests**: 50-200 XP for challenges
- **Bonuses**: Streak bonuses, time bonuses

### Leveling System
- Level 1 → Level 2: 100 XP
- XP requirement increases exponentially (level^1.5)
- Gain skill points on level-up
- Unlock new features at certain levels

### Stats System
- **Strength**: Physical power, affects workout XP
- **Agility**: Speed and flexibility, affects cardio XP
- **Intelligence**: Learning ability, affects skill progression
- **Vitality**: Endurance and health, affects stamina
- **Sense**: Awareness and precision, affects technique

### Skill Points
- Earned on level-up
- Allocate to stats
- Unlock special abilities (future feature)

### Achievements & Quests
- Daily quests (complete 3 habits)
- Weekly challenges (5 workouts)
- Long-term goals (30-day streaks)
- Achievements with badges

## UI/UX Components

### Reusable Widgets

#### SystemPanel
- Dark panel with border
- Corner decorations (blue glow lines)
- Optional title with glow text
- Optional glow effect shadow

#### GlowText
- Text with glowing shadow effect
- Blue/purple glow colors
- Used for headers and important text

#### CornerDecoration
- L-shaped corner ornaments
- Positioned at panel corners
- Glowing blue color

#### CustomProgressBar
- Segmented progress (10 blocks)
- Gradient fill
- Glow effect on filled segments
- Smooth animations

### Animations
- Level-up animation with glow burst
- XP gain number pop-up
- Progress bar fill animation
- Smooth page transitions
- Loading shimmer effects

### Navigation
- Drawer menu with glowing icons
- Bottom navigation (alternative)
- Route-based navigation with go_router
- Deep linking support

## Data Synchronization

### Offline Support
- Cache data locally
- Sync when online
- Conflict resolution

### Real-time Updates
- Supabase real-time subscriptions
- Live XP updates
- Leaderboard updates (future)

## Security & Privacy

### Row Level Security (RLS)
- Users can only access their own data
- Enforced at database level

### Authentication
- Email verification
- Password requirements
- Secure token storage

## Future Enhancements

### Phase 2
- Social features (friends, leaderboards)
- Multiplayer quests
- Guilds/teams
- Trading system for items
- Achievement badges

### Phase 3
- Apple Watch / Wear OS integration
- Integration with fitness trackers
- Voice commands
- AR workout guides

### Phase 4
- AI workout recommendations
- Personalized training plans
- Nutrition tracking
- Sleep tracking integration

## Technical Implementation

### State Management
- Riverpod for global state
- Provider for dependency injection
- StateNotifier for complex state logic

### Data Flow
```
UI → Provider → Service → Supabase → Database
                    ↓
                 Models
                    ↓
            Local Cache (Future)
```

### Performance
- Lazy loading for lists
- Image caching
- Optimistic UI updates
- Pagination for large datasets

## Testing Strategy

### Unit Tests
- Model serialization
- XP calculations
- Date utilities
- Business logic

### Widget Tests
- UI component rendering
- User interactions
- Navigation flows

### Integration Tests
- E2E user flows
- API integration
- Authentication

## Conclusion

Arise transforms fitness tracking into an engaging RPG-like experience. The Solo Leveling aesthetic creates an immersive environment that motivates users to "level up" in real life through consistent habits and workouts.
