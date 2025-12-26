# Olympedia : Olympics Database Application

A comprehensive **Olympic data management system** with **Role-Based Access Control** built on Python and MySQL. This application enables efficient management and exploration of Olympic history through structured database interactions, stored procedures, and an intuitive CLI interface.

![Python](https://img.shields.io/badge/Python3-3.12%2B-blue) ![MySQL](https://img.shields.io/badge/MySQL-Relational%20DB-orange) ![Architecture](https://img.shields.io/badge/Architecture-Client--Server-green)

---

## ✨ Features

### 👤 User Access
- Browse and explore comprehensive Olympic historical data
- Query athlete statistics and performance records
- View event information, medal counts, and rankings
- Access broadcasting and viewership data

### 🔐 Admin Capabilities (RBAC)
- Full CRUD operations on all database entities
- Manage athletes, events, teams, and countries
- Update records, rankings, and medal history
- Maintain data integrity across relationships

### ⚡ Performance Optimizations
- Stored procedures for efficient database operations
- Parameterized queries preventing SQL injection
- Optimized joins for complex multi-table queries
- Transaction management for data consistency

---

## 🗃️ Database Architecture

```
┌─────────────────────────────────────────┐
│           Olympic Event                 │
│  (Year, Season, StartDate, EndDate)    │
└──────────┬──────────────────┬───────────┘
           │                  │
    ┌──────▼──────┐    ┌─────▼─────┐
    │    City     │    │   Sport   │
    │  (Hosted)   │    │ (Includes)│
    └──────┬──────┘    └─────┬─────┘
           │                  │
    ┌──────▼──────┐    ┌─────▼─────┐
    │   Country   │    │  Athlete  │
    │  (Part of)  │    │   Team    │
    └──────┬──────┘    └─────┬─────┘
           │                  │
           └──────────┬───────┘
                 ┌────▼────┐
                 │  Medal  │
                 │ Record  │
                 │ Ranking │
                 └─────────┘
```

### Core Entities

**Geographic Data:**
- **Country** - National information with Olympic codes
- **City** - Host city demographics and coordinates

**Competition Data:**
- **OlympicEvent** - Games metadata (year, season, dates)
- **Sport** - Sport classifications and requirements
- **Medal** - Achievement types and records

**Participant Data:**
- **Athlete** - Individual competitor profiles
- **Team** - Team rosters and coaching staff
- **Record** - Historical Olympic records

**Auxiliary Data:**
- **Broadcaster** - Media coverage details
- **AthleteRanking** - Global performance rankings
- **TeamRanking** - Team standings and points

### Key Relationships

- **Hosted in**: Olympic Events → Cities (many-to-one)
- **Part of**: Cities → Countries (many-to-one)
- **Participates in**: Athletes ↔ Sports (many-to-many)
- **From**: Athletes → Countries (many-to-one)
- **Wins in Event**: Athletes → Olympic Events → Medals (ternary)
- **Broadcasted**: Broadcasters → Events → Countries (ternary)

---

## 🛠️ Tech Stack

### Backend
- **Python 3.6+** - Application logic and CLI interface
- **MySQL** - Relational database management
- **pymysql** - Python-MySQL database connector
- **tabulate** - Formatted table output

### Database Features
- **Stored Procedures** - Encapsulated business logic
- **Parameterized Queries** - SQL injection prevention
- **Foreign Key Constraints** - Data integrity enforcement
- **Indexes** - Query performance optimization

---

## 📂 Project Structure

```
olympics-database-application/
├── olympics_app.py          # Main application entry point
├── dbmsproj.sql            # Database schema definition
├── dbmssp.sql              # Stored procedures
├── README.md               # Project documentation
└── requirements.txt        # Python dependencies
```

---

## 🔐 Security Implementation

### Authentication
- Secure user registration with role assignment
- Password-based authentication (upgrade to hashing recommended)
- Session management for logged-in users
- Role verification on every operation

### Authorization (RBAC)
- **Two roles:** `user` and `admin`
- Admin-exclusive operations:
  - Create, Update, Delete entities
  - Manage critical data (events, athletes, records)
- User operations:
  - Read-only access to all data
  - Complex query execution
  - Data exploration and analysis

### Data Protection
- Parameterized queries preventing SQL injection
- Input validation for all user inputs
- Transaction rollback on error conditions
- Database connection security

---

## 🚀 Getting Started

### Prerequisites

```bash
# Python 3.6 or higher
python --version

# MySQL Server running locally or remotely
mysql --version
```

### Installation

```bash
# Clone the repository
git clone https://github.com/KartikJondhalekar/Olympedia
cd olympics-database-application

# Install Python dependencies
pip install pymysql tabulate
```

### Database Setup

**Option 1: MySQL Workbench (Recommended)**
1. Open MySQL Workbench
2. Import `dbmsproj.sql` to create schema
3. Import `dbmssp.sql` to create stored procedures
4. Verify database `CS5200_Project` exists

**Option 2: Command Line**
```bash
# Create and populate database
mysql -u <username> -p < dbmsproj.sql

# Import stored procedures
mysql -u <username> -p < dbmssp.sql
```

### Running the Application

```bash
# Start the application
python olympics_app.py

# Enter MySQL credentials when prompted
# Follow CLI menu for Sign Up/Sign In
```

---

## 💡 Application Workflow

### Initial Setup
1. Launch application with `python olympics_app.py`
2. Enter MySQL database credentials
3. Connection confirmation message appears

### Main Menu
```
1. Sign Up - Register new user account
2. Sign In - Login with existing credentials
3. Exit    - Close application
```

### Admin Operations
Once logged in as admin, access full CRUD capabilities:

**Create Operations:**
- Add new athletes, teams, events, cities, countries
- Register new sports and records
- Input medal history and rankings

**Read Operations:**
- View all entities with filtering
- Execute complex analytical queries
- Generate reports and statistics

**Update Operations:**
- Modify athlete information
- Update event details
- Correct records and rankings

**Delete Operations:**
- Remove outdated entries
- Clean up test data
- Maintain database hygiene

### User Operations
Users have read-only access to:
- Complete Olympic event history
- Athlete profiles and statistics
- Medal counts by country
- Broadcasting information
- Global rankings and records

---

## 📊 Key Stored Procedures

### CRUD Operations
```sql
-- User Management
add_user(username, password, role)
authenticate_user(username, password)

-- Entity Management
add_athlete(first_name, last_name, dob, gender, ...)
update_country(code, name, continent, population)
delete_city(city_name)
```

### Analytical Queries
```sql
-- Historical Analysis
get_olympic_events()
get_medal_winning_countries(event_id)
get_athletes_by_sport(sport_name)

-- Performance Metrics
get_athlete_win_history(athlete_id)
get_team_rankings(event_id)
get_broadcaster_viewership(event_id)
```

---

## 🎯 Project Highlights

- **Comprehensive data model** - Captures complex Olympic relationships
- **Role-based security** - Protects sensitive operations
- **Efficient queries** - Stored procedures optimize performance
- **User-friendly CLI** - Intuitive menu-driven interface
- **Scalable design** - Ready for frontend integration
- **Real-world application** - Based on actual Olympic data structures

---

## 💡 Key Learnings

### Database Design
- Designed normalized relational schema with 15+ entities
- Implemented complex relationships (one-to-many, many-to-many, ternary)
- Created stored procedures for business logic encapsulation
- Optimized queries with proper indexing and joins

### Application Development
- Built role-based access control from scratch
- Implemented secure authentication flow
- Managed database connections and transactions
- Created modular Python architecture for maintainability

### Best Practices
- SQL injection prevention through parameterization
- Separation of concerns (database logic vs application logic)
- Comprehensive error handling and user feedback
- Clean code organization with helper functions

---

## 🔮 Future Enhancements

### Frontend Development
- React.js web interface for modern user experience
- Interactive data visualizations (charts, graphs)
- Responsive design for mobile access
- Real-time data updates

### Security Improvements
- Password hashing with bcrypt
- JWT token authentication
- Multi-factor authentication
- Audit logging for admin actions

### Features
- Advanced search and filtering
- Export data to CSV/Excel
- Comparison tools for athletes/teams
- Historical trend analysis
- API development for third-party integration

---

## 📚 Documentation

### Database Schema
Detailed entity relationship diagram and table specifications available in `dbmsproj.sql`

### API Reference
Complete list of stored procedures with parameters documented in `dbmssp.sql`

### User Guide
Step-by-step instructions for common operations included in application help menus

---

## 👨‍💻 Author

**Kartik Jayram Jondhalekar**

[![GitHub](https://img.shields.io/badge/GitHub-KartikJondhalekar-black?logo=github)](https://github.com/KartikJondhalekar)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://linkedin.com/in/kartik-jondhalekar)

*Group Project developed with Sri Nithya Anne*

---

## 🙏 Acknowledgments

This project demonstrates practical application of database management principles, showcasing expertise in relational database design, SQL optimization, Python development, and system architecture. Built as a comprehensive learning experience in managing complex real-world data structures.

---

## 📝 License

This project is open source and available under the MIT License.

---

**⭐ If you find this project useful, please consider giving it a star!**

**Built with 🏅 celebrating Olympic excellence and data management**
