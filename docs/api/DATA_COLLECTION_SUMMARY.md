# 📊 Data Collection Features - Screen Time & Activity Watch

## 🎯 What We Added

### 📱 Screen Time Data Collection
**File**: `scripts/screen_time_collector.sh`

**Features**:
- **Native macOS Integration**: Uses macOS Screen Time API
- **App Usage Tracking**: Monitors application usage patterns
- **Display Usage Analytics**: Tracks multi-display utilization
- **Workspace Profile Data**: Collects profile switching patterns
- **Analytics Reports**: Generates daily usage reports

**Data Collected**:
- Application usage statistics
- Display layout and utilization
- Workspace profile switching patterns
- Time-based usage analytics
- Productivity insights

**Usage**:
```bash
# Collect current data
./scripts/screen_time_collector.sh collect

# Start continuous monitoring
./scripts/screen_time_collector.sh monitor

# Generate analytics report
./scripts/screen_time_collector.sh report

# Check collection status
./scripts/screen_time_collector.sh status
```

### 📈 Activity Watch Integration
**File**: `scripts/activity_watch_integration.sh`

**Features**:
- **Real-time Activity Tracking**: Monitors current workspace activity
- **Historical Data Collection**: Analyzes past usage patterns
- **Productivity Analysis**: Identifies peak productivity hours
- **System Performance Monitoring**: Tracks CPU and memory usage
- **Workspace Optimization**: Provides recommendations

**Data Collected**:
- Active window and application data
- Display and space utilization
- System performance metrics
- Productivity pattern analysis
- Workspace optimization suggestions

**Usage**:
```bash
# Collect current activity
./scripts/activity_watch_integration.sh collect

# Collect historical data
./scripts/activity_watch_integration.sh historical

# Analyze productivity patterns
./scripts/activity_watch_integration.sh analyze

# Start continuous monitoring
./scripts/activity_watch_integration.sh monitor

# Generate activity report
./scripts/activity_watch_integration.sh report
```

## 📁 Data Storage

### Screen Time Data
**Location**: `configs/screen_time_data/`
- `app_usage_YYYY-MM-DD.json` - Application usage data
- `display_usage_YYYY-MM-DD.json` - Display utilization data
- `workspace_YYYY-MM-DD.json` - Workspace profile data
- `analytics_report_YYYY-MM-DD.md` - Daily analytics reports

### Activity Watch Data
**Location**: `configs/activity_watch_data/`
- `current_activity_YYYY-MM-DD.json` - Real-time activity data
- `historical_activity_YYYY-MM-DD.json` - Historical usage data
- `productivity_analysis_YYYY-MM-DD.json` - Productivity insights
- `activity_report_YYYY-MM-DD.md` - Activity analysis reports

## 🔧 Integration with Launcher

The data collection tools are now integrated into the main launcher:

```bash
./launcher.sh
```

**New Options**:
- **Option 8**: Screen Time Data Collection
- **Option 9**: Activity Watch Integration

## 📊 Analytics Capabilities

### Screen Time Analytics
- **App Usage Patterns**: Track which applications are used most
- **Display Utilization**: Monitor multi-display usage efficiency
- **Workspace Switching**: Analyze profile switching patterns
- **Time-based Insights**: Identify peak usage hours
- **Productivity Metrics**: Measure workspace effectiveness

### Activity Watch Analytics
- **Real-time Monitoring**: Track current workspace activity
- **Performance Metrics**: Monitor system resource usage
- **Productivity Patterns**: Identify optimal work hours
- **Workspace Optimization**: Provide improvement suggestions
- **Historical Analysis**: Compare usage over time

## 🎯 Benefits

### For Workspace Management
- **Data-Driven Decisions**: Make informed workspace optimizations
- **Productivity Insights**: Identify peak performance periods
- **Usage Patterns**: Understand your work habits
- **Optimization Opportunities**: Find areas for improvement

### For AI Integration
- **Training Data**: Provide data for ML-powered optimizations
- **Pattern Recognition**: Identify recurring workspace patterns
- **Predictive Analytics**: Anticipate workspace needs
- **Personalization**: Tailor workspace to your habits

## 🚀 Future Enhancements

### Planned Features
- **ML-Powered Analysis**: Use collected data for AI-driven insights
- **Predictive Workspace Switching**: Anticipate profile needs
- **Performance Optimization**: Automatically optimize based on data
- **Cross-Platform Integration**: Extend to other devices

### Advanced Analytics
- **Heat Maps**: Visualize workspace usage patterns
- **Productivity Scoring**: Quantify workspace effectiveness
- **Trend Analysis**: Track improvements over time
- **Recommendation Engine**: AI-powered workspace suggestions

## 📋 Installation & Setup

### Prerequisites
- **macOS Screen Time**: Enable in System Preferences
- **Activity Watch** (optional): `brew install activitywatch`
- **YABAI**: Running window manager
- **jq**: JSON processing tool

### Quick Start
```bash
# Test Screen Time collection
./scripts/screen_time_collector.sh collect

# Test Activity Watch integration
./scripts/activity_watch_integration.sh collect

# Start continuous monitoring
./scripts/screen_time_collector.sh monitor &
./scripts/activity_watch_integration.sh monitor &
```

## 📈 Data Privacy

### Local Storage
- All data is stored locally in `configs/` directories
- No external data transmission
- Full control over data collection and storage

### Privacy Controls
- **Configurable Collection**: Enable/disable specific data types
- **Data Retention**: Automatic cleanup of old data
- **Selective Monitoring**: Choose what to track
- **Local Processing**: All analysis done locally

## 🎉 Success Metrics

### Implemented Features
- ✅ Screen Time data collection
- ✅ Activity Watch integration
- ✅ Real-time monitoring capabilities
- ✅ Historical data analysis
- ✅ Analytics report generation
- ✅ Launcher integration
- ✅ Privacy-focused local storage

### Data Quality
- **Comprehensive Coverage**: App usage, display utilization, workspace patterns
- **Real-time Updates**: Continuous monitoring and data collection
- **Structured Storage**: JSON format for easy analysis
- **Report Generation**: Automated daily analytics reports

The data collection system is now fully integrated and ready to provide insights for workspace optimization! 🎯 